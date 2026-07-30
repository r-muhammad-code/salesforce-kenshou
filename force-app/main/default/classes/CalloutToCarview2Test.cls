@IsTest
private class CalloutToCarview2Test {

    // HTTP callout のモッククラス
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/xml');
            res.setStatusCode(200);
            res.setBody('<?xml version="1.0" encoding="UTF-8"?>' +
                        '<Result xmlns="http://bb.carview.co.jp/">' +
                        '  <AssessInfo>' +
                        '    <Item>' +
                        '      <Name>山田太郎</Name>' +
                        '      <EMail>taro@example.com</EMail>' +
                        '      <Tel1>09012345678</Tel1>' +
                        '      <Mileage>45,001～50,000</Mileage>' +
                        '      <ContactDate>2025-06-17</ContactDate>' +
                        '      <IsBroken>普通車</IsBroken>' +
                        '      <CarType>セダン</CarType>' +
                        '      <NameKana>ヤマダタロウ</NameKana>' +
                        '      <PostalCode>123-4567</PostalCode>' +
                        '      <Region>東京都</Region>' +
                        '      <Address>港区南青山1-1-1</Address>' +
                        '      <Model>カローラ</Model>' +
                        '      <ModelYear>2020</ModelYear>' +
                        '      <Option>サンルーフ</Option>' +
                        '      <Comment>特になし</Comment>' +
                        '      <CVComment>査定希望</CVComment>' +
                        '      <Grade>G</Grade>' +
                        '      <Color>黒</Color>' +
                        '      <Transmission>AT</Transmission>' +
                        '      <Steering>右</Steering>' +
                        '      <Door>4</Door>' +
                        '      <Displacement>1800</Displacement>' +
                        '      <FuelType>ガソリン</FuelType>' +
                        '    </Item>' +
                        '  </AssessInfo>' +
                        '</Result>');
            return res;
        }
    }

    @IsTest
    static void testCallExternalService() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // リクエストデータの準備
        CalloutToCarview2.RequestWrapper req = new CalloutToCarview2.RequestWrapper();
        req.api_key = 'dummy_api_key';
        req.contact_id = '123456';

        List<CalloutToCarview2.RequestWrapper> requests = new List<CalloutToCarview2.RequestWrapper>{ req };

        Test.startTest();
        List<CalloutToCarview2.ResponseWrapper> responses = CalloutToCarview2.callExternalService(requests);
        Test.stopTest();

        // アサーション
        System.assertEquals(1, responses.size());
        CalloutToCarview2.ResponseWrapper res = responses[0];
        System.assertEquals('山田太郎', res.cv_name);
        System.assertEquals('taro@example.com', res.cv_email);
        System.assertEquals('09012345678', res.cv_tel);
        System.assertEquals('45,001～50,000', res.cv_mileage_str);
        System.assertEquals(45001, res.cv_mileage_int); // 「～」前の数値がパースされている
        System.assertEquals('東京都', res.cv_region);
        System.assertEquals('右', res.cv_steering);
        System.assertEquals('ガソリン', res.cv_fuel_type);
    }
}