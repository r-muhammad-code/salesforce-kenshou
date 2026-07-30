public with sharing class InvoiceBusinessDayService {

    // ----------------------------------------------------------------------
    // 在住区分（Invoice_Info__c 側の数式テキスト）から「海外扱いかどうか」を判定
    //
    // 前提：
    //   Invoice_Info__c.zjyu_kbn__c には以下のようなテキストが入る想定
    //     - '国内在住'
    //     - '海外在住'
    //     - など、「海外」を含むテキスト ＝ 海外扱い
    // ----------------------------------------------------------------------
    private static Boolean isOverseas(String residenceText) {
        if (String.isBlank(residenceText)) {
            return false;
        }

        String s = residenceText.trim();

        // 「海外」が含まれていれば海外扱い
        if (s.contains('海外')) {
            return true;
        }

        // 念のため、昔のデータで '2' がそのまま入っているケースも拾う
        if (s == '2') {
            return true;
        }

        return false;
    }

    // ----------------------------------------------------------------------
    // 請求レコードの internal_payment_deadline__c をまとめて計算
    //
    // ルール：
    //   - sales_category__c = 'AucBid（代行）'
    //       → payment_deadline__c をそのままコピー
    //   - 上記以外で Invoice_Info__c.zjyu_kbn__c に「海外」を含む
    //       → payment_deadline__c の +2営業日後（土日・祝日除外）を設定
    //   - それ以外（国内在住 / 未設定 / その他）
    //       → payment_deadline__c をそのままコピー
    //
    // ※ 書き換えるのは internal_payment_deadline__c のみ
    // ----------------------------------------------------------------------
    public static void setInternalPaymentDeadline(List<Invoice_Info__c> invoices) {

        if (invoices == null || invoices.isEmpty()) {
            return;
        }

        Date minDate;
        Date maxDate;

        // 1) +2営業日計算が必要なレコードの最小・最大支払期限を取得
        for (Invoice_Info__c inv : invoices) {

            if (inv == null) {
                continue;
            }

            // 支払期限がなければ対象外
            if (inv.payment_deadline__c == null) {
                continue;
            }

            // AucBid（代行）は +2営業日の対象外
            if (inv.sales_category__c == 'AucBid（代行）') {
                continue;
            }

            // 在住区分（数式テキスト）から海外判定
            Boolean overseas = isOverseas(inv.zjyu_kbn__c);
            if (!overseas) {
                // 海外在住でなければ +2営業日の対象外
                continue;
            }

            Date pd = inv.payment_deadline__c;
            if (minDate == null || pd < minDate) {
                minDate = pd;
            }
            if (maxDate == null || pd > maxDate) {
                maxDate = pd;
            }
        }

        // 2) 休日日付を格納する Set
        Set<Date> holidayDates = new Set<Date>();

        // +2営業日計算が必要なレコードがある場合だけ休日を取得
        if (minDate != null && maxDate != null) {

            // 余裕を見て最大日付 +10 日までの休日を取得
            Date holidaySearchEnd = maxDate.addDays(10);

            List<Holiday__mdt> holidayMdtList = [
                SELECT Holiday__c
                FROM Holiday__mdt
                WHERE Holiday__c >= :minDate
                  AND Holiday__c <= :holidaySearchEnd
            ];

            for (Holiday__mdt h : holidayMdtList) {
                if (h.Holiday__c != null) {
                    holidayDates.add(h.Holiday__c);
                }
            }
        }

        // 3) 各レコードに internal_payment_deadline__c をセット
        for (Invoice_Info__c inv : invoices) {

            if (inv == null) {
                continue;
            }

            // 支払期限がない場合は何もしない
            if (inv.payment_deadline__c == null) {
                continue;
            }

            // AucBid（代行）の場合はそのままコピー
            if (inv.sales_category__c == 'AucBid（代行）') {
                inv.internal_payment_deadline__c = inv.payment_deadline__c;
                continue;
            }

            // 在住区分テキストから海外判定
            Boolean overseas = isOverseas(inv.zjyu_kbn__c);

            // ★ 海外在住 → +2営業日
            if (overseas) {

                Date resultDate = calcAfterBusinessDays(
                    inv.payment_deadline__c,
                    2,
                    holidayDates
                );
                inv.internal_payment_deadline__c = resultDate;

            // ★ それ以外（国内在住・未設定など） → コピー
            } else {
                inv.internal_payment_deadline__c = inv.payment_deadline__c;
            }
        }
    }

    // ----------------------------------------------------------------------
    // startDate から businessDays 日後の「営業日」を返す
    //
    // 例：
    //   startDate = 2025-10-08(水), businessDays = 2
    //   → 木曜・金曜が営業日なら 2025-10-10(金) を返す
    //
    // 対象外：
    //   - 土曜 / 日曜
    //   - Holiday__mdt.Holiday__c に含まれる日
    // ----------------------------------------------------------------------
    private static Date calcAfterBusinessDays(
        Date startDate,
        Integer businessDays,
        Set<Date> holidayDates
    ) {
        // 防御的コード：おかしな引数なら startDate をそのまま返す
        if (startDate == null || businessDays == null || businessDays <= 0) {
            return startDate;
        }
        if (holidayDates == null) {
            holidayDates = new Set<Date>();
        }

        Date currentDate = startDate;
        Integer counted = 0;

        while (counted < businessDays) {
            // 1日進める
            currentDate = currentDate.addDays(1);

            // 曜日番号取得（1=月曜 … 7=日曜）
            Datetime dt = Datetime.newInstance(
                currentDate.year(),
                currentDate.month(),
                currentDate.day()
            );
            Integer dow = Integer.valueOf(dt.format('u'));

            // 土曜(6)・日曜(7)はスキップ
            if (dow == 6 || dow == 7) {
                continue;
            }

            // 休日メタデータに含まれていればスキップ
            if (holidayDates.contains(currentDate)) {
                continue;
            }

            // ここまで来たら営業日としてカウント
            counted++;
        }

        return currentDate;
    }
}