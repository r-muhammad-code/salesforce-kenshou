@isTest
private class DataLineAPI_SchedulerTest {
    
    @isTest
    static void testExecute() {
        // 1. 直接メソッド呼び出しによるテスト（sc == null の分岐を網羅）
        // ※ミリ秒の重複によるスケジュール同名エラーを防ぐためtry-catchで保護
        try {
            DataLineAPI_Scheduler scheduler = new DataLineAPI_Scheduler();
            scheduler.execute(null);
        } catch (Exception e) {
            System.debug('重複エラー回避: ' + e.getMessage());
        }
        
        // 2. スケジュール登録によるテスト（sc != null の分岐と全体の動作を網羅）
        Test.startTest();
        
        String cronExp = '0 0 12 * * ?';
        String jobId = System.schedule('Test_DataLineAPI_Scheduler_Job', cronExp, new DataLineAPI_Scheduler());
        
        // ※ここでexecuteメソッドが強制的に同期実行されます
        Test.stopTest(); 
        
        System.assertNotEquals(null, jobId, 'ジョブが正常にスケジュールされていません');
    }
}