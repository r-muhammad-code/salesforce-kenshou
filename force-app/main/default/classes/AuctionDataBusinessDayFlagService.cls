public with sharing class AuctionDataBusinessDayFlagService {

    // ★ここだけ修正：DateTime を「日本時間の日付」に変換する
    private static Date toLocalDate(DateTime dt) {
        if (dt == null) return null;

        // 日本時間（JST）で yyyy-MM-dd を作り、その日付として扱う
        return Date.valueOf(dt.format('yyyy-MM-dd', 'Asia/Tokyo'));
    }

    public static void apply(List<Auction_Data__c> records) {
        if (records == null || records.isEmpty()) return;

        Date today = Date.today();
        Boolean todayIsBiz = BusinessDayUtil.isBusinessDay(today);

        Date bizPrev;
        Date bizNext;
        Date bizNext2;

        if (todayIsBiz) {
            bizPrev = BusinessDayUtil.addBusinessDays(today, -1);

            bizNext  = BusinessDayUtil.addBusinessDays(today, 1);
            bizNext2 = BusinessDayUtil.addBusinessDays(bizNext, 1);
        }

        for (Auction_Data__c r : records) {
            r.IsPreviousBusinessDay__c   = false;
            r.IsCurrentBusinessDay__c    = false;
            r.IsNextBusinessDay__c       = false;
            r.IsSecondNextBusinessDay__c = false;

            if (!todayIsBiz || r.Deadline_Time__c == null) continue;

            Date deadlineDate = toLocalDate(r.Deadline_Time__c);

            r.IsCurrentBusinessDay__c    = (deadlineDate == today);
            r.IsPreviousBusinessDay__c   = (deadlineDate == bizPrev);
            r.IsNextBusinessDay__c       = (deadlineDate == bizNext);
            r.IsSecondNextBusinessDay__c = (deadlineDate == bizNext2);
        }
    }
}