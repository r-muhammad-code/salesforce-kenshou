public class BusinessHoursCalculator {

    @InvocableMethod(label='営業時間を考慮した期限日時を計算' description='作成日時とカスタムメタデータの休日を考慮して、3営業時間後の日時を返します。')
    public static List<Datetime> calculateEscalationDateTime(List<Datetime> createdDates) {

        if (createdDates == null || createdDates.isEmpty() || createdDates[0] == null) {
            throw new AuraHandledException('Apex Action received a null input for createdDates. Check the Flow input configuration.');
        }

        Set<Date> holidays = new Set<Date>();
        for (Holiday__mdt holiday : [SELECT Holiday__c FROM Holiday__mdt]) {
            holidays.add(holiday.Holiday__c);
        }

        Datetime createdDate = createdDates[0];
        Datetime escalationDateTime = createdDate;

        // ▼▼▼▼▼【ここからロジックを修正】▼▼▼▼▼
        // まず、次の営業日の開始時刻（9:00）を取得する
        Date startDate = escalationDateTime.date();
        // もし営業時間外（18時以降）に作成されたら、次の日から探し始める
        if (escalationDateTime.hour() >= 18) {
            startDate = startDate.addDays(1);
        }
        
        // 営業日の9:00を計算の開始時刻とする
        escalationDateTime = getNextBusinessDayStart(startDate, holidays);
        // ▲▲▲▲▲【ここまでロジックを修正】▲▲▲▲▲
        
        Integer minutesToAdd = 180;
        while (minutesToAdd > 0) {
            Integer remainingMinutesInDay = (18 * 60) - (escalationDateTime.hour() * 60 + escalationDateTime.minute());

            if (minutesToAdd <= remainingMinutesInDay) {
                escalationDateTime = escalationDateTime.addMinutes(minutesToAdd);
                minutesToAdd = 0;
            } else {
                minutesToAdd -= remainingMinutesInDay;
                // getNextBusinessDayStartに渡す日付を翌日にする
                escalationDateTime = getNextBusinessDayStart(escalationDateTime.date().addDays(1), holidays);
            }
        }
        
        List<Datetime> returnDateTimes = new List<Datetime>();
        returnDateTimes.add(escalationDateTime);
        return returnDateTimes;
    }

    private static Boolean isNonBusinessDay(Date targetDate, Set<Date> holidays) {
        Integer dayOfWeek = Integer.valueOf(Datetime.newInstance(targetDate, Time.newInstance(0,0,0,0)).format('u'));
        return (dayOfWeek >= 6 || holidays.contains(targetDate));
    }

    private static Datetime getNextBusinessDayStart(Date targetDate, Set<Date> holidays) {
        Date nextBusinessDay = targetDate;
        while (isNonBusinessDay(nextBusinessDay, holidays)) {
            nextBusinessDay = nextBusinessDay.addDays(1);
        }
        return Datetime.newInstance(nextBusinessDay, Time.newInstance(9, 0, 0, 0));
    }
}