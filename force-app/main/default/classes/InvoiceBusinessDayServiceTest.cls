@isTest
private class InvoiceBusinessDayServiceTest {

    // ------------------------------------------------------------
    // テスト用 Member__c 作成ヘルパー
    // zjyuKbn : '1' = 国内在住, '2' = 海外在住（元の仕様どおり）
    // ------------------------------------------------------------
    private static Member__c createMember(String zjyuKbn) {
        Member__c m = new Member__c();
        m.zjyu_kbn__c = zjyuKbn;

        // ★組織で必須の項目があればここに設定してください
        // 例:
        // m.Name = 'Test Member';

        return m;
    }

    // ------------------------------------------------------------
    // テスト用 Invoice_Info__c 作成ヘルパー
    // ------------------------------------------------------------
    private static Invoice_Info__c createInvoice(Date paymentDeadline, Id memberId) {
        Invoice_Info__c inv = new Invoice_Info__c();
        inv.payment_deadline__c = paymentDeadline;
        inv.Member__c            = memberId;

        // ★組織の必須項目があればここに追加
        // 例:
        // inv.Name = 'Test Invoice';

        return inv;
    }

    // ============================================================
    // 1) 国内＋海外＋支払期限なし の基本動作テスト
    // ============================================================
    @isTest
    static void testDomesticAndNullDeadline() {

        Date today = Date.today();

        // 1. 会員（国内 / 海外）を作成
        Member__c domesticMember = createMember('1'); // 国内在住
        Member__c overseasMember = createMember('2'); // 海外在住
        insert new List<Member__c>{ domesticMember, overseasMember };

        // 2. 国内インボイス（支払期限あり）
        Invoice_Info__c domesticInvoice = createInvoice(
            today,
            domesticMember.Id
        );

        // 3. 海外インボイス（支払期限なし）
        Invoice_Info__c noDeadlineInvoice = createInvoice(
            null,
            overseasMember.Id
        );

        insert new List<Invoice_Info__c>{ domesticInvoice, noDeadlineInvoice };

        // 4. 数式項目(zjyu_kbn__c) を含めて取り直す
        List<Invoice_Info__c> invoices = [
            SELECT Id,
                   payment_deadline__c,
                   internal_payment_deadline__c,
                   zjyu_kbn__c,
                   Member__c,
                   sales_category__c
            FROM Invoice_Info__c
            WHERE Id IN :new List<Id>{ domesticInvoice.Id, noDeadlineInvoice.Id }
        ];

        Invoice_Info__c domestic;
        Invoice_Info__c noDeadline;
        for (Invoice_Info__c inv : invoices) {
            if (inv.Id == domesticInvoice.Id) {
                domestic = inv;
            } else if (inv.Id == noDeadlineInvoice.Id) {
                noDeadline = inv;
            }
        }

        Test.startTest();
        InvoiceBusinessDayService.setInternalPaymentDeadline(invoices);
        Test.stopTest();

        // ▼ アサート

        // 国内在住 → 支払期限そのまま
        System.assertEquals(
            today,
            domestic.internal_payment_deadline__c,
            '国内在住のインボイスは支払期限がそのまま社内入金期限になるはず'
        );

        // 支払期限なし → internal_payment_deadline__c も null
        System.assertEquals(
            null,
            noDeadline.internal_payment_deadline__c,
            '支払期限が null の場合は internal_payment_deadline__c も null のままのはず'
        );
    }

    // ============================================================
    // 2) 海外在住の +2 営業日 計算テスト
    //    - 海外：+2営業日
    //    - 国内：そのまま
    // ============================================================
    @isTest
    static void testOverseasPlusTwoBusinessDays() {

        Date baseDate = Date.today();

        // 1. 会員を作成（国内 / 海外）
        Member__c domesticMember = createMember('1'); // 国内
        Member__c overseasMember = createMember('2'); // 海外
        insert new List<Member__c>{ domesticMember, overseasMember };

        // 2. 海外インボイス（支払期限あり）
        Invoice_Info__c overseasInvoice = createInvoice(
            baseDate,
            overseasMember.Id
        );

        // 3. 国内インボイス（比較用）
        Invoice_Info__c domesticInvoice = createInvoice(
            baseDate,
            domesticMember.Id
        );

        insert new List<Invoice_Info__c>{ overseasInvoice, domesticInvoice };

        // 4. 数式項目を含めて取り直し
        List<Invoice_Info__c> invoices = [
            SELECT Id,
                   payment_deadline__c,
                   internal_payment_deadline__c,
                   zjyu_kbn__c,
                   Member__c,
                   sales_category__c
            FROM Invoice_Info__c
            WHERE Id IN :new List<Id>{ overseasInvoice.Id, domesticInvoice.Id }
        ];

        Invoice_Info__c overseas;
        Invoice_Info__c domestic;
        for (Invoice_Info__c inv : invoices) {
            if (inv.Id == overseasInvoice.Id) {
                overseas = inv;
            } else if (inv.Id == domesticInvoice.Id) {
                domestic = inv;
            }
        }

        Test.startTest();
        InvoiceBusinessDayService.setInternalPaymentDeadline(invoices);
        Test.stopTest();

        // ▼ アサート

        // 国内在住 → そのまま
        System.assertEquals(
            baseDate,
            domestic.internal_payment_deadline__c,
            '国内在住のインボイスは支払期限がそのまま社内入金期限になるはず'
        );

        // 海外在住 → 支払期限とは異なる日付（後ろにずれる）
        System.assertNotEquals(
            baseDate,
            overseas.internal_payment_deadline__c,
            '海外在住のインボイスは支払期限と同じ日にはならないはず'
        );

        // 海外在住 → 必ず支払期限より後の日付
        System.assert(
            overseas.internal_payment_deadline__c > baseDate,
            '海外在住のインボイスは支払期限より後の日付になっているはず'
        );

        // 日数差（祝日を考慮して「少なくとも +2 日以上」）
        Integer diffDays = baseDate.daysBetween(overseas.internal_payment_deadline__c);
        System.assert(
            diffDays >= 2,
            '海外在住のインボイスは少なくとも +2 日以上先になっているはず。差分: ' + diffDays
        );
    }
}