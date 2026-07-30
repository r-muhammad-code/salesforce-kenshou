public with sharing class BusinessDayUtil {

    /** ApexにはIllegalStateExceptionがないので自作する */
    public class BusinessDayException extends Exception {}

    // Transaction cache (SOQL only once per transaction)
    private static Set<Date> holidaySetCache;

    private static Set<Date> getHolidaySet() {
        if (holidaySetCache != null) return holidaySetCache;

        holidaySetCache = new Set<Date>();
        for (Holiday__mdt h : [
            SELECT Holiday__c
            FROM Holiday__mdt
            WHERE Holiday__c != null
        ]) {
            holidaySetCache.add(h.Holiday__c);
        }
        return holidaySetCache;
    }

    /**
     * Day-of-week number using DateTime.format('u')
     * 'u' = 1(Mon) .. 7(Sun)
     */
    private static Integer dayOfWeekIso(Date d) {
        // Use midday to avoid DST edge cases
        DateTime dt = DateTime.newInstance(d, Time.newInstance(12, 0, 0, 0));
        return Integer.valueOf(dt.format('u'));
    }

    private static Boolean isWeekend(Date d) {
        Integer dow = dayOfWeekIso(d); // 1=Mon..7=Sun
        return (dow == 6 || dow == 7); // Sat(6), Sun(7)
    }

    public static Boolean isBusinessDay(Date d) {
        if (d == null) return false;
        if (isWeekend(d)) return false;
        return !getHolidaySet().contains(d);
    }

    /**
     * Add/subtract N business days from baseDate.
     * baseDate itself is not counted; it starts from the next/previous day.
     */
    public static Date addBusinessDays(Date baseDate, Integer businessDays) {
        if (baseDate == null || businessDays == null) return null;
        if (businessDays == 0) return baseDate;

        Integer step = (businessDays > 0) ? 1 : -1;
        Integer remaining = Math.abs(businessDays);

        Date d = baseDate;
        Integer guard = 0;

        while (remaining > 0) {
            d = d.addDays(step);
            if (isBusinessDay(d)) remaining--;

            // guard: 異常データ等で無限ループしないための安全弁
            if (++guard > 3000) {
                throw new BusinessDayException('Search overflow in addBusinessDays. Check holiday data.');
            }
        }
        return d;
    }
}