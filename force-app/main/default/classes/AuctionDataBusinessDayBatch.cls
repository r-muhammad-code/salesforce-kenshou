global with sharing class AuctionDataBusinessDayBatch
    implements Database.Batchable<SObject> {

    // ★ ここだけが変更点
    global Database.QueryLocator start(Database.BatchableContext bc) {

        // 今日を基準に「前後1ヶ月」
        Date startDate = Date.today().addMonths(-1);
        Date endDate   = Date.today().addMonths(1);

        // Date → DateTime（1日をフルで含める）
        DateTime startDt = DateTime.newInstance(
            startDate,
            Time.newInstance(0, 0, 0, 0)
        );
        DateTime endDt = DateTime.newInstance(
            endDate,
            Time.newInstance(23, 59, 59, 999)
        );

        return Database.getQueryLocator([
            SELECT Id, Deadline_Time__c
            FROM Auction_Data__c
            WHERE Deadline_Time__c != null
              AND Deadline_Time__c >= :startDt
              AND Deadline_Time__c <= :endDt
        ]);
    }

    // 既存のまま（変更しない）
    global void execute(Database.BatchableContext bc, List<Auction_Data__c> scope) {
        AuctionDataBusinessDayFlagService.apply(scope);
        update scope;
    }

    // 既存のまま（変更しない）
    global void finish(Database.BatchableContext bc) {
        // 処理なし
    }
}