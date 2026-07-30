@isTest
private class CalloutToDataLineAITest {

    @testSetup
    static void setupTestData() {
        // ========================================================
        // 1. API接続情報のカスタム設定（DataLineApi_Data__c）
        // ========================================================
        DataLineApi_Data__c apiSetting = new DataLineApi_Data__c();
        // 階層型カスタム設定を「組織のデフォルト」としてテスト環境に認識させる
        apiSetting.SetupOwnerId = UserInfo.getOrganizationId(); 
        
        // クラス内で使用されている項目をすべてセットする
        apiSetting.client_key__c = 'DUMMY_CLIENT_KEY';
        apiSetting.CRYPTO_KEY__c = 'DUMMY_CRYPTO_KEY_123456789012345';
        apiSetting.account_id__c = 'DUMMY_ACCOUNT_ID';
        apiSetting.session_id_endpoint__c = 'https://dummy.dataline.com/login/v2/login';
        apiSetting.get_endpoint__c = 'https://dummy.dataline.com/sateidata/v2/sateidata';
        
        insert apiSetting;

        // ========================================================
        // 2. 同期時刻記録用のカスタム設定（DataLineAPI_SyncStatus__c）
        // ========================================================
        DataLineAPI_SyncStatus__c syncStatus = new DataLineAPI_SyncStatus__c();
        // こちらも組織のデフォルトとして認識させる
        syncStatus.SetupOwnerId = UserInfo.getOrganizationId();
        
        insert syncStatus;
    }

    // ========================================================
    // モック（ダミー通信）クラス
    // ========================================================
    private class DataLineAIMock implements HttpCalloutMock {
        private String scenario;

        public DataLineAIMock(String scenario) {
            this.scenario = scenario;
        }

        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');

            // ① セッションID取得（ログイン）の通信
            if (req.getEndpoint().contains('/login/v2/login')) {
                if (this.scenario == 'LoginError') {
                    res.setStatusCode(401);
                } else {
                    res.setStatusCode(200);
                    res.setBody('{"session_id": "dummy_session_12345"}');
                }
            } 
            // ② 査定データ取得の通信
            else if (req.getEndpoint().contains('/sateidata/v2/sateidata')) {
                if (this.scenario == 'ApiError') {
                    res.setStatusCode(500);
                } else {
                    res.setStatusCode(200);
                    // 正常に1件のデータを返すダミーJSON
                    String dummyJson = '{' +
                        '"list": [{' +
                            '"satei_id": "TEST-0001", ' +
                            '"guest_name": "DummyGuest", ' +
                            '"number_ex": "1234", ' +
                            '"satei_date": "2026/05/27", ' +
                            '"option_list": [{"seq":"1", "option_nm":"テストオプション"}], ' +
                            '"kikan_list": [{"kikan_cd":"01", "kikan_nm":"テスト機関"}], ' +
                            '"denso_list": [{"denso_cd":"01", "denso_nm":"テスト電装"}]' +
                        '}]' +
                    '}';
                    res.setBody(dummyJson);
                }
            }
            return res;
        }
    }

    // ========================================================
    // テスト1：すべてが正常に成功するパターン
    // ========================================================
    @isTest
    static void testSuccessSync() {
        // 成功を返すモックをセット
        Test.setMock(HttpCalloutMock.class, new DataLineAIMock('Success'));

        // フローからの入力パラメータを準備
        CalloutToDataLineAI.RequestWrapper req = new CalloutToDataLineAI.RequestWrapper();
        req.shonin_date_from = '20260501000000';
        req.shonin_date_to   = '20260531235959';
        List<CalloutToDataLineAI.RequestWrapper> reqList = new List<CalloutToDataLineAI.RequestWrapper>{req};

        Test.startTest();
        List<CalloutToDataLineAI.SyncResult> results = CalloutToDataLineAI.getSateiData(reqList);
        Test.stopTest();

        // 期待される結果のアサーション（検証）
        System.assertEquals(1, results.size(), '戻り値のリストが1件であること');
        System.assertEquals(true, results[0].is_success, '処理全体が成功していること');
        System.assertEquals(1, results[0].total_count, 'ダミーデータが1件取得できていること');
        
        // カスタム設定（同期時刻）が正しく更新されたか検証
        DataLineAPI_SyncStatus__c updatedStatus = [SELECT LastSyncDatetime__c FROM DataLineAPI_SyncStatus__c LIMIT 1];
        System.assertNotEquals(null, updatedStatus.LastSyncDatetime__c, '同期時刻が更新されていること');
    }

    // ========================================================
    // テスト2：ログイン（セッション取得）で失敗するパターン
    // ========================================================
    @isTest
    static void testLoginError() {
        Test.setMock(HttpCalloutMock.class, new DataLineAIMock('LoginError'));

        CalloutToDataLineAI.RequestWrapper req = new CalloutToDataLineAI.RequestWrapper();
        req.shonin_date_from = '20260501000000';
        req.shonin_date_to   = '20260531235959';

        Test.startTest();
        List<CalloutToDataLineAI.SyncResult> results = CalloutToDataLineAI.getSateiData(new List<CalloutToDataLineAI.RequestWrapper>{req});
        Test.stopTest();

        System.assertEquals(false, results[0].is_success, 'ログイン失敗によりis_successがfalseになること');
        System.assert(results[0].errorMessage.contains('ログイン失敗'), 'エラーメッセージが正しいこと');
    }

    // ========================================================
    // テスト3：データ取得APIの通信で失敗するパターン
    // ========================================================
    @isTest
    static void testApiError() {
        Test.setMock(HttpCalloutMock.class, new DataLineAIMock('ApiError'));

        CalloutToDataLineAI.RequestWrapper req = new CalloutToDataLineAI.RequestWrapper();
        req.shonin_date_from = '20260501000000';
        req.shonin_date_to   = '20260531235959';

        Test.startTest();
        List<CalloutToDataLineAI.SyncResult> results = CalloutToDataLineAI.getSateiData(new List<CalloutToDataLineAI.RequestWrapper>{req});
        Test.stopTest();

        System.assertEquals(false, results[0].is_success, 'APIエラーによりis_successがfalseになること');
        System.assert(results[0].errorMessage.contains('API連携エラー'), 'ステータスコードエラーが記録されていること');
    }
}