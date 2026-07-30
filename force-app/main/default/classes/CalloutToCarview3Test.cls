/**
 * @description Tests for CalloutToCarview3 Invocable method.
 * Covers normal and error scenarios using HttpCalloutMock.
 */
@IsTest
private class CalloutToCarview3Test {

    // Success mock returning XML body expected by parser
    private class Carview3SuccessMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            System.assertEquals('POST', req.getMethod(), 'Method should be POST');
            System.assert(req.getBody().contains('startcontactid=') && req.getBody().contains('endcontactid='), 'Body must include required params');

            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setStatus('OK');
            // Minimal XML containing all fields referenced by the code
            String xml =
'<root xmlns="urn:test">' +
'  <AssessInfo>' +
'    <Item>' +
'      <Name>山田 太郎</Name>' +
'      <EMail>taro@example.com</EMail>' +
'      <Tel1>03-1234-5678</Tel1>' +
'      <Mileage>12,345～</Mileage>' +
'      <ContactDate>2025-12-31</ContactDate>' +
'      <IsBroken>false</IsBroken>' +
'      <CarType>乗用車</CarType>' +
'      <NameKana>ヤマダ タロウ</NameKana>' +
'      <PostalCode>100-0001</PostalCode>' +
'      <Region>東京都</Region>' +
'      <Address>千代田区1-1-1</Address>' +
'      <Model>プリウス</Model>' +
'      <ModelYear>2020</ModelYear>' +
'      <Option>サンルーフ</Option>' +
'      <Comment>テストコメント</Comment>' +
'      <CVComment>内部メモ</CVComment>' +
'      <Grade>S</Grade>' +
'      <Color>ホワイト</Color>' +
'      <Transmission>AT</Transmission>' +
'      <Steering>右</Steering>' +
'      <Door>5</Door>' +
'      <Displacement>1800</Displacement>' +
'      <FuelType>Hybrid</FuelType>' +
'    </Item>' +
'  </AssessInfo>' +
'</root>';
            res.setBody(xml);
            return res;
        }
    }

    // Error mock (non-200)
    private class Carview3ErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            res.setStatus('Server Error');
            res.setBody('Internal Error');
            return res;
        }
    }

    @TestSetup
    static void setupData() {
        // Provide default org values for Custom Setting CarviewApiData__c used by target class
        // Org側のAPI参照名は key__c 固定という指示に合わせて明示的に設定
        CarviewApiData__c cs = new CarviewApiData__c(
            SetupOwnerId = UserInfo.getOrganizationId(),
            url__c = 'https://example.invalid/api',
            key__c = 'dummy-key'
        );
        insert cs;
    }

    @IsTest
    static void testSuccessSingleRequest() {
        Test.setMock(HttpCalloutMock.class, new Carview3SuccessMock());

        // Prepare request
        CalloutToCarview3.RequestWrapper req = new CalloutToCarview3.RequestWrapper();
        req.contact_id = '12345';

        Test.startTest();
        List<CalloutToCarview3.ResponseWrapper> results =
            CalloutToCarview3.callExternalService(new List<CalloutToCarview3.RequestWrapper>{ req });
        Test.stopTest();

        System.assertEquals(1, results.size(), 'One result should be returned');
        CalloutToCarview3.ResponseWrapper res = results[0];

        // Assertions for parsed fields
        System.assertEquals('山田 太郎', res.cv_name);
        System.assertEquals('taro@example.com', res.cv_email);
        System.assertEquals('03-1234-5678', res.cv_tel);
        System.assertEquals('12,345～', res.cv_mileage_str);
        System.assertEquals(12345, res.cv_mileage_int);
        System.assertEquals('2025-12-31', res.cv_contact_date);
        System.assertEquals('false', res.cv_is_broken);
        System.assertEquals('乗用車', res.cv_car_type);
        System.assertEquals('ヤマダ タロウ', res.cv_name_kana);
        System.assertEquals('100-0001', res.cv_postal_code);
        System.assertEquals('東京都', res.cv_region);
        System.assertEquals('千代田区1-1-1', res.cv_address);
        System.assertEquals('プリウス', res.cv_model);
        System.assertEquals('2020', res.cv_model_year);
        System.assertEquals('サンルーフ', res.cv_option);
        System.assertEquals('テストコメント', res.cv_user_comment);
        System.assertEquals('内部メモ', res.cv_memo);
        System.assertEquals('S', res.cv_grade);
        System.assertEquals('ホワイト', res.cv_color);
        System.assertEquals('AT', res.cv_transmission);
        System.assertEquals('右', res.cv_steering);
        System.assertEquals('5', res.cv_door);
        System.assertEquals('1800', res.cv_displacement);
        System.assertEquals('Hybrid', res.cv_fuel_type);
    }

    @IsTest
    static void testBulkTwoRequests() {
        Test.setMock(HttpCalloutMock.class, new Carview3SuccessMock());

        List<CalloutToCarview3.RequestWrapper> reqs = new List<CalloutToCarview3.RequestWrapper>();
        for (Integer i = 0; i < 2; i++) {
            CalloutToCarview3.RequestWrapper r = new CalloutToCarview3.RequestWrapper();
            r.contact_id = String.valueOf(1000 + i);
            reqs.add(r);
        }

        Test.startTest();
        List<CalloutToCarview3.ResponseWrapper> results = CalloutToCarview3.callExternalService(reqs);
        Test.stopTest();

        System.assertEquals(2, results.size(), 'Two results expected for bulk call');
        for (CalloutToCarview3.ResponseWrapper r : results) {
            System.assertNotEquals(null, r.cv_name, 'Parsed field should be populated');
            System.assertNotEquals(null, r.cv_mileage_int, 'Mileage int should be parsed');
        }
    }

    @IsTest
    static void testInvalidContactIdThrowsAuraHandled() {
        // No mock needed because the code throws before the callout when contact_id is invalid
        CalloutToCarview3.RequestWrapper req = new CalloutToCarview3.RequestWrapper();
        req.contact_id = 'not-a-number';

        Boolean thrown = false;
        try {
            Test.startTest();
            CalloutToCarview3.callExternalService(new List<CalloutToCarview3.RequestWrapper>{ req });
            Test.stopTest();
        } catch (AuraHandledException e) {
            thrown = true;
            System.assert(e.getMessage() != null,'AuraHandledException should have a message');
        }
        System.assertEquals(true, thrown, 'AuraHandledException should be thrown for non-numeric contact_id');
    }

    @IsTest
    static void testNon200ResponseHandledGracefully() {
        Test.setMock(HttpCalloutMock.class, new Carview3ErrorMock());

        CalloutToCarview3.RequestWrapper req = new CalloutToCarview3.RequestWrapper();
        req.contact_id = '12345';

        Test.startTest();
        List<CalloutToCarview3.ResponseWrapper> results =
            CalloutToCarview3.callExternalService(new List<CalloutToCarview3.RequestWrapper>{ req });
        Test.stopTest();

        System.assertEquals(1, results.size(), 'Result list should still contain one wrapper');
        // In non-200 case, fields remain null; ensure no exception and object returned
        System.assertEquals(null, results[0].cv_name);
    }
}