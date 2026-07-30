public with sharing class CaseTaskEscalationService {

    // 「未対応 (New)」の値（半角カッコ！スクショの「値」と同じ）
    private static final String STATUS_NEW_VALUE = '未対応 (New)';

    // Status__c が「未対応扱い」かどうか判定
    // null（未設定）の場合も「未対応」とみなす
    private static Boolean isNewStatus(String statusValue) {
        return statusValue == null || statusValue == STATUS_NEW_VALUE;
    }

    // メイン処理：EscalationDateTime__c と contact_delay_flag__c を設定
    public static void setEscalationAndFlag(List<Case_Task__c> tasks) {

        if (tasks == null || tasks.isEmpty()) {
            return;
        }

        Datetime nowDt = System.now();

        // 休日取得のための CreatedDate の最小・最大日
        Date minDate;
        Date maxDate;

        for (Case_Task__c t : tasks) {
            Datetime baseDt = (t.CreatedDate != null) ? t.CreatedDate : nowDt;
            Date d = baseDt.date();
            if (minDate == null || d < minDate) {
                minDate = d;
            }
            if (maxDate == null || d > maxDate) {
                maxDate = d;
            }
        }

        // 休日の日付セット
        Set<Date> holidayDates = new Set<Date>();

        if (minDate != null && maxDate != null) {
            Date endDate = maxDate.addDays(10);

            for (Holiday__mdt h : [
                SELECT Holiday__c
                FROM Holiday__mdt
                WHERE Holiday__c >= :minDate
                  AND Holiday__c <= :endDate
            ]) {
                if (h.Holiday__c != null) {
                    holidayDates.add(h.Holiday__c);
                }
            }
        }

        // 各タスクごとにエスカ期限＆フラグ設定
        for (Case_Task__c t : tasks) {

            Datetime baseDt = (t.CreatedDate != null) ? t.CreatedDate : nowDt;

            // 作成日時から 3 営業時間後
            Datetime threeBusinessHoursLater =
                addBusinessMinutes(baseDt, 3 * 60, holidayDates);

            Datetime escalation = threeBusinessHoursLater;

            // Compliance_deadline__c があり、3営業時間後より早ければそちらを優先
            if (t.Compliance_deadline__c != null &&
                t.Compliance_deadline__c < escalation) {
                escalation = t.Compliance_deadline__c;
            }

            // エスカレーション期限をセット
            t.EscalationDateTime__c = escalation;

            // ▼ フラグ制御：未対応扱い & 期限超過なら true にする
            if (isNewStatus(t.Status__c)
                && escalation != null
                && escalation <= nowDt) {

                t.contact_delay_flag__c = true;
            }
            // ★ それ以外のときは contact_delay_flag__c には触らない
            //    → 既存データを勝手に false に戻したりしない
        }
    }

    // 営業時間（平日9:00〜18:00、休日除外）だけをカウントして minutesToAdd 分進める
    private static Datetime addBusinessMinutes(
        Datetime start,
        Integer minutesToAdd,
        Set<Date> holidayDates
    ) {
        if (start == null || minutesToAdd == null || minutesToAdd <= 0) {
            return start;
        }
        if (holidayDates == null) {
            holidayDates = new Set<Date>();
        }

        Datetime current = start;
        Integer remaining = minutesToAdd;

        while (remaining > 0) {
            if (isBusinessMinute(current, holidayDates)) {
                remaining--;
            }
            current = current.addMinutes(1);
        }

        return current;
    }

    // その1分が「営業中」かどうか
    private static Boolean isBusinessMinute(
        Datetime dt,
        Set<Date> holidayDates
    ) {
        if (dt == null) return false;

        Date d = dt.date();

        // 1=月曜, ..., 7=日曜
        Integer dow = Integer.valueOf(dt.format('u'));
        if (dow == 6 || dow == 7) {
            return false; // 土日
        }

        if (holidayDates != null && holidayDates.contains(d)) {
            return false; // 休日
        }

        // 9:00 <= t < 18:00 を営業時間とする
        Integer hour = dt.hour();
        if (hour < 9 || hour >= 18) {
            return false;
        }

        return true;
    }
}