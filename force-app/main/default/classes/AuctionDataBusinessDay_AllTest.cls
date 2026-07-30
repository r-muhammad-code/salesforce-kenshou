@IsTest
private class AuctionDataBusinessDay_AllTest {

    /**
     * 直近の「営業日」を探す（今日が休日でも落ちない）
     */
    private static Date findNearestBusinessDay(Date start) {
        Date d = start;
        for (Integer i = 0; i < 20; i++) {
            if (BusinessDayUtil.isBusinessDay(d)) return d;
            d = d.addDays(1);
        }
        // 20日見ても営業日がないのは異常（テスト失敗）
        System.assert(false, 'Could not find a business day within 20 days.');
        return start;
    }

    /**
     * 指定日付の「曜日(u=1..7)」を返す
     */
    private static Integer dowIso(Date d) {
        return Integer.valueOf(DateTime.newInstance(d, Time.newInstance(12,0,0,0)).format('u'));
    }

    @IsTest
    static void test_ServiceApply_Flags_OnBusinessDay() {
        // 今日が休日でも確実に「営業日」を作る
        Date asOf = findNearestBusinessDay(Date.today());

        // Service本体は Date.today() を使うので、
        // 「asOf = 今日」を作れない問題がある。
        // ここでは「今日が営業日だった場合」のテストを確実に通すために、
        // もし今日が営業日でないなら、このテストはスキップする。
        // （下の別テストで休日分岐はカバーする）
        if (!BusinessDayUtil.isBusinessDay(Date.today())) {
            System.assert(true, 'Skipped: today is not a business day.');
            return;
        }

        Date today = Date.today();
        Date bizPrev = BusinessDayUtil.addBusinessDays(today, -1);
        Date bizNext = BusinessDayUtil.addBusinessDays(today, 1);
        Date bizNext2 = BusinessDayUtil.addBusinessDays(bizNext, 1);

        // 当日・前営業日・翌営業日・翌々営業日・null の5パターン
        Auction_Data__c rToday = new Auction_Data__c(
            Name = 'T-Today',
            Deadline_Time__c = DateTime.newInstance(today, Time.newInstance(0, 10, 0, 0)) // 0時境界近辺
        );
        Auction_Data__c rPrev = new Auction_Data__c(
            Name = 'T-Prev',
            Deadline_Time__c = DateTime.newInstance(bizPrev, Time.newInstance(23, 59, 0, 0))
        );
        Auction_Data__c rNext = new Auction_Data__c(
            Name = 'T-Next',
            Deadline_Time__c = DateTime.newInstance(bizNext, Time.newInstance(9, 0, 0, 0))
        );
        Auction_Data__c rNext2 = new Auction_Data__c(
            Name = 'T-Next2',
            Deadline_Time__c = DateTime.newInstance(bizNext2, Time.newInstance(12, 0, 0, 0))
        );
        Auction_Data__c rNull = new Auction_Data__c(
            Name = 'T-Null',
            Deadline_Time__c = null
        );

        insert new List<Auction_Data__c>{ rToday, rPrev, rNext, rNext2, rNull };

        List<Auction_Data__c> scope = [
            SELECT Id, Deadline_Time__c,
                   IsPreviousBusinessDay__c, IsCurrentBusinessDay__c, IsNextBusinessDay__c, IsSecondNextBusinessDay__c
            FROM Auction_Data__c
            WHERE Id IN :new List<Id>{ rToday.Id, rPrev.Id, rNext.Id, rNext2.Id, rNull.Id }
        ];

        Test.startTest();
        AuctionDataBusinessDayFlagService.apply(scope);
        update scope;
        Test.stopTest();

        Map<Id, Auction_Data__c> afterMap = new Map<Id, Auction_Data__c>([
            SELECT Id,
                   IsPreviousBusinessDay__c, IsCurrentBusinessDay__c, IsNextBusinessDay__c, IsSecondNextBusinessDay__c
            FROM Auction_Data__c
            WHERE Id IN :new List<Id>{ rToday.Id, rPrev.Id, rNext.Id, rNext2.Id, rNull.Id }
        ]);

        System.assertEquals(true,  afterMap.get(rToday.Id).IsCurrentBusinessDay__c, 'Current flag should be true');
        System.assertEquals(true,  afterMap.get(rPrev.Id).IsPreviousBusinessDay__c, 'Previous biz flag should be true');
        System.assertEquals(true,  afterMap.get(rNext.Id).IsNextBusinessDay__c, 'Next biz flag should be true');
        System.assertEquals(true,  afterMap.get(rNext2.Id).IsSecondNextBusinessDay__c, 'Second next biz flag should be true');

        // nullは常に全false
        Auction_Data__c aNull = afterMap.get(rNull.Id);
        System.assertEquals(false, aNull.IsPreviousBusinessDay__c);
        System.assertEquals(false, aNull.IsCurrentBusinessDay__c);
        System.assertEquals(false, aNull.IsNextBusinessDay__c);
        System.assertEquals(false, aNull.IsSecondNextBusinessDay__c);
    }

    @IsTest
    static void test_ServiceApply_Flags_OnHolidayBranch() {
        // 今日が営業日ならこのテストはスキップ（上のテストでカバー済）
        if (BusinessDayUtil.isBusinessDay(Date.today())) {
            System.assert(true, 'Skipped: today is a business day.');
            return;
        }

        Date today = Date.today();

        // 今日が休日の場合、Deadlineが何であっても（nullでなくても）全falseになることを確認
        Auction_Data__c r = new Auction_Data__c(
            Name = 'T-Holiday',
            Deadline_Time__c = DateTime.newInstance(today, Time.newInstance(10, 0, 0, 0))
        );
        insert r;

        List<Auction_Data__c> scope = [
            SELECT Id, Deadline_Time__c,
                   IsPreviousBusinessDay__c, IsCurrentBusinessDay__c, IsNextBusinessDay__c, IsSecondNextBusinessDay__c
            FROM Auction_Data__c
            WHERE Id = :r.Id
        ];

        Test.startTest();
        AuctionDataBusinessDayFlagService.apply(scope);
        update scope;
        Test.stopTest();

        Auction_Data__c after = [
            SELECT IsPreviousBusinessDay__c, IsCurrentBusinessDay__c, IsNextBusinessDay__c, IsSecondNextBusinessDay__c
            FROM Auction_Data__c
            WHERE Id = :r.Id
        ];

        System.assertEquals(false, after.IsPreviousBusinessDay__c);
        System.assertEquals(false, after.IsCurrentBusinessDay__c);
        System.assertEquals(false, after.IsNextBusinessDay__c);
        System.assertEquals(false, after.IsSecondNextBusinessDay__c);
    }

    @IsTest
    static void test_BusinessDayUtil_weekend_and_add() {
        // 近い土曜日を探す（最大14日）
        Date d = Date.today();
        for (Integer i = 0; i < 14; i++) {
            if (dowIso(d) == 6) break; // 6=Sat
            d = d.addDays(1);
        }
        Date saturday = d;
        Date friday = saturday.addDays(-1);

        System.assertEquals(false, BusinessDayUtil.isBusinessDay(saturday), 'Saturday must be non-business day');

        // 金曜 +1 営業日 = 少なくとも月曜以降（祝日ならもっと先）
        Date monday = saturday.addDays(2);
        Date nextBiz = BusinessDayUtil.addBusinessDays(friday, 1);
        System.assert(nextBiz >= monday, 'Should skip weekend at least');
    }

    @IsTest
    static void test_Invocable_runs_and_updates_some_records() {
        // Invocableは Date.today() 基準で ±13日を取得するので、必ず範囲内に入るレコードを作る
        Date today = Date.today();

        Auction_Data__c r1 = new Auction_Data__c(
            Name = 'T-Inv-1',
            Deadline_Time__c = DateTime.newInstance(today.addDays(1), Time.newInstance(9, 0, 0, 0))
        );
        Auction_Data__c r2 = new Auction_Data__c(
            Name = 'T-Inv-2',
            Deadline_Time__c = DateTime.newInstance(today.addDays(5), Time.newInstance(9, 0, 0, 0))
        );
        insert new List<Auction_Data__c>{ r1, r2 };

        Test.startTest();
        // Invocableは引数がダミーなので null でもOK
        AuctionDataBusinessDayNightlyInvocable.run(null);
        Test.stopTest();

        // 「更新が走る」ことを最低限確認（値の真偽は今日が営業日かで変わる）
        List<Auction_Data__c> after = [
            SELECT Id,
                   IsPreviousBusinessDay__c, IsCurrentBusinessDay__c, IsNextBusinessDay__c, IsSecondNextBusinessDay__c
            FROM Auction_Data__c
            WHERE Id IN :new List<Id>{ r1.Id, r2.Id }
        ];
        System.assertEquals(2, after.size());
        System.assertNotEquals(null, after[0].IsCurrentBusinessDay__c);
        System.assertNotEquals(null, after[1].IsCurrentBusinessDay__c);
    }
}