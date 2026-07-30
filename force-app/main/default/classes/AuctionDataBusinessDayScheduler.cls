global with sharing class AuctionDataBusinessDayScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        // 【無効化】夜間処理はスケジュールトリガーフローに移行したため実行しない
        return;

        /*
        if (!BusinessDayUtil.isBusinessDay(Date.today())) {
            return;
        }
        Database.executeBatch(new AuctionDataBusinessDayBatch(), 200);
        */
    }
}