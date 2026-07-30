@IsTest
private class GetDismantlingFeeApiCallerTest {
    
    // ▼ モックレスポンスを返すクラス
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);
            res.setBody('{"result": [{"type": "C","member_name": "テスト株式会社","price_class": "メイン","price": 12345,"note": "テスト備考"}],"error": null}');
            return res;
        }
    }

    @IsTest
    static void testCallCostApi_Success() {
        // モックレスポンスの登録
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // テスト用の入力データ
        GetDismantlingFeeApiCaller.ApiRequestWrapper input = new GetDismantlingFeeApiCaller.ApiRequestWrapper();
        input.prefecture = '27';
        input.keyword = '大阪市';
        input.displacement = '2000';
        input.order = '0';
        input.sort_by = '0';

        List<GetDismantlingFeeApiCaller.ApiRequestWrapper> inputs = new List<GetDismantlingFeeApiCaller.ApiRequestWrapper>{ input };

        // メソッド呼び出し
        Test.startTest();
        List<GetDismantlingFeeApiCaller.ApiResponseWrapper> result = GetDismantlingFeeApiCaller.callCostApi(inputs);
        Test.stopTest();

        // 結果の検証
        System.assertEquals(1, result.size());
        System.assertEquals(false, result[0].hasError);
        System.assertNotEquals(null, result[0].results);
        System.assertEquals('テスト株式会社', result[0].results[0].member_name);
        System.assert(result[0].formattedResults.contains('テスト株式会社'));
    }

    // ▼ エラーレスポンス用のモック（必要なら追加）
    private class MockErrorResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(400);
            res.setBody('{"result": null,"error": {"code": "400","message": "不正なリクエストです"}}');
            return res;
        }
    }

    @IsTest
    static void testCallCostApi_ErrorResponse() {
        // モック登録（エラー用）
        Test.setMock(HttpCalloutMock.class, new MockErrorResponseGenerator());

        GetDismantlingFeeApiCaller.ApiRequestWrapper input = new GetDismantlingFeeApiCaller.ApiRequestWrapper();
        input.prefecture = '24';
        input.keyword = 'いなべ市';
        input.displacement = '660';
        input.order = '0';
        input.sort_by = '0';

        List<GetDismantlingFeeApiCaller.ApiRequestWrapper> inputs = new List<GetDismantlingFeeApiCaller.ApiRequestWrapper>{ input };

        Test.startTest();
        List<GetDismantlingFeeApiCaller.ApiResponseWrapper> result = GetDismantlingFeeApiCaller.callCostApi(inputs);
        Test.stopTest();

        System.assertEquals(1, result.size());
        System.assertEquals(true, result[0].hasError);
        System.assertEquals(400, result[0].errorCode);
        System.assertEquals('不正なリクエストです', result[0].errorMessage);
    }
}