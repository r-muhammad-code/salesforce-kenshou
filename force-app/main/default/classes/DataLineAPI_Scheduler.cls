public class DataLineAPI_Scheduler implements Schedulable {

    public void execute(SchedulableContext sc) {
        // 1. プラットフォームイベントの発行
        DataLineAPI_Request__e event = new DataLineAPI_Request__e();
        EventBus.publish(event);

        // 2. 実行済みのジョブを削除（ジョブが溜まるのを防ぐ）
        if (sc != null) {
            System.abortJob(sc.getTriggerId());
        }

        // 3. 次の実行時間を計算（15分刻み、8:00〜21:00）
        Datetime now = Datetime.now();

        // 現在の「分」から次の15分の区切り（15, 30, 45, 60）を算出
        Integer nextMin = (now.minute() / 15 + 1) * 15;
        Integer nextHour = now.hour();
        Integer addDays = 0;

        // 60分になった場合は時間を繰り上げ
        if (nextMin == 60) {
            nextMin = 0;
            nextHour++;
        }

        // 実行可能時間（8:00〜21:00）の範囲チェック
        // 次の予定が21:01以降になる場合、翌日の8:00にスキップ
        if (nextHour > 21 || (nextHour == 21 && nextMin > 0)) {
            nextHour = 8;
            nextMin = 0;
            addDays = 1;
        }
        // （フェイルセーフ）万が一8時前に起動した場合、当日の8:00にスキップ
        else if (nextHour < 8) {
            nextHour = 8;
            nextMin = 0;
        }

        // CRON文字列の生成
        Date nextDate = now.date().addDays(addDays);
        String cronStr = '0 ' + nextMin + ' ' + nextHour + ' ' +
                        nextDate.day() + ' ' + nextDate.month() + ' ? ' + nextDate.year();

        // 4. ジョブの再スケジュール
        System.schedule('DataLineAPI_Scheduler_Job_' + Datetime.now().getTime(), cronStr, new DataLineAPI_Scheduler());
    }
}