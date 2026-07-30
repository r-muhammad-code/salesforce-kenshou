// スケジュールから呼び出すクラス
global class CaseTaskEscalationScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        // バッチ本体を実行
        CaseTaskEscalationBatch batch = new CaseTaskEscalationBatch();
        // バッチサイズはお好みで。200 が一般的
        Database.executeBatch(batch, 200);
    }

    // ★管理者が一度だけ「開発者コンソールの実行ウィンドウ」で呼べば、
    //   30分おきに永続的に動くスケジュール登録用のヘルパーメソッド
    public static void scheduleEvery30Minutes() {
        // 「毎時 0分 と 30分」に実行される Cron 式
        String cron = '0 0,30 * * * ?';
        System.schedule('CaseTaskEscalationEvery30Min', cron, new CaseTaskEscalationScheduler());
    }
}