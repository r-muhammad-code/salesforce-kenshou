public with sharing class AuctionDataBusinessDayNightlyInvocable {

    // Deadline_Time__c を「今日から何日未来まで」対象にするか
    private static final Integer RANGE_DAYS = 13;

    @InvocableMethod(label='Recalculate Auction Data Business Day Flags')
    public static void run(List<String> dummy) {

        Date today = Date.today();

        // 今日 00:00:00
        DateTime fromDt = DateTime.newInstance(
            today,
            Time.newInstance(0, 0, 0, 0)
        );

        // 今日 + 13日の翌日 00:00:00（未満）
        DateTime toDtExclusive = DateTime.newInstance(
            today.addDays(RANGE_DAYS + 1),
            Time.newInstance(0, 0, 0, 0)
        );

        List<Auction_Data__c> targets = [
            SELECT Id,
                   Deadline_Time__c,
                   stock_ship_date__c,
                   IsPreviousBusinessDay__c,
                   IsCurrentBusinessDay__c,
                   IsNextBusinessDay__c,
                   IsSecondNextBusinessDay__c
            FROM Auction_Data__c
            WHERE Deadline_Time__c != null
              AND stock_ship_date__c = null
              AND (
                    // ① 過去・現在：すでに意味を持つレコード
                    IsPreviousBusinessDay__c = true
                 OR IsCurrentBusinessDay__c = true
                 OR IsNextBusinessDay__c = true
                 OR IsSecondNextBusinessDay__c = true

                    // ② 未来：今日〜＋13日の締切
                 OR (
                        Deadline_Time__c >= :fromDt
                    AND Deadline_Time__c <  :toDtExclusive
                    )
              )
        ];

        if (targets.isEmpty()) {
            return;
        }

        // 変更前の値を保持
        Map<Id, Auction_Data__c> beforeMap = new Map<Id, Auction_Data__c>();
        for (Auction_Data__c a : targets) {
            beforeMap.put(a.Id, a.clone(true, true, false, false));
        }

        // フラグ再計算
        AuctionDataBusinessDayFlagService.apply(targets);

        // 変更があったものだけ更新
        List<Auction_Data__c> toUpdate = new List<Auction_Data__c>();
        for (Auction_Data__c a : targets) {
            Auction_Data__c b = beforeMap.get(a.Id);

            if (a.IsPreviousBusinessDay__c != b.IsPreviousBusinessDay__c ||
                a.IsCurrentBusinessDay__c  != b.IsCurrentBusinessDay__c  ||
                a.IsNextBusinessDay__c     != b.IsNextBusinessDay__c     ||
                a.IsSecondNextBusinessDay__c != b.IsSecondNextBusinessDay__c) {
                toUpdate.add(a);
            }
        }

        if (!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }
}