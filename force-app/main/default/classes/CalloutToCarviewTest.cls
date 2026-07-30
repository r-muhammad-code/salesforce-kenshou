@isTest
private class CalloutToCarviewTest {

    // HTTPレスポンス用モッククラス
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'text/xml');
            res.setBody('<?xml version="1.0" encoding="UTF-8"?>' +
                '<Result xmlns="http://tempuri.org/">' +
                '<AssessInfo>' +
                '<Item>' +
                '<Name>テスト太郎</Name>' +
                '<EMail>test@example.com</EMail>' +
                '<Tel1>09012345678</Tel1>' +
                '<Mileage>45,001～50,000</Mileage>' +
                '<ContactDate>2025-06-16</ContactDate>' +
                '<IsBroken>事故車</IsBroken>' +
                '<CarType>セダン</CarType>' +
                '<NameKana>テストタロウ</NameKana>' +
                '<PostalCode>123-4567</PostalCode>' +
                '<Region>東京都</Region>' +
                '<Address>渋谷区1-2-3</Address>' +
                '<Model>カムリ</Model>' +
                '<ModelYear>2020</ModelYear>' +
                '<Option>サンルーフ</Option>' +
                '<Comment>きれいな車です</Comment>' +
                '<CVComment>整備済み</CVComment>' +
                '<Grade>X</Grade>' +
                '<Color>ブラック</Color>' +
                '<Transmission>AT</Transmission>' +
                '<Steering>右</Steering>' +
                '<Door>4</Door>' +
                '<Displacement>2000</Displacement>' +
                '<FuelType>ガソリン</FuelType>' +
                '</Item>' +
                '</AssessInfo>' +
                '</Result>');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testCallExternalService() {
        // RecordTypeの取得（個人取引先）
        Id personRtId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND IsPersonType = true LIMIT 1].Id;

        // ケース作成
        Case c = new Case(Subject = 'テストケース');
        insert c;

        // HTTPモックを設定
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        // RequestWrapper を準備
        CalloutToCarview.RequestWrapper req = new CalloutToCarview.RequestWrapper();
        req.case_id = c.Id;
        req.contact_id = 'abc123';
        req.mail_media = 'メール';
        req.mail_email = 'test@example.com';
        req.mail_subject = '件名';
        req.mail_body = '本文';
        req.owner_id = UserInfo.getUserId();
        
        // フロー修正に合わせて、キャンペーンのテストレコードを作成
        Campaign dummyCampaign = new Campaign(
            Name = '売却時期不明_未対応1H以内オートコール', 
            IsActive = true
        );
        insert dummyCampaign;

        // テスト実行
        Test.startTest();
        CalloutToCarview.callExternalService(new List<CalloutToCarview.RequestWrapper>{ req });
        Test.stopTest();

        // 結果検証
        List<Account> accList = [SELECT Id, LastName, PersonEmail, PersonMobilePhone FROM Account WHERE PersonEmail = 'test@example.com'];
        System.assertEquals(1, accList.size(), 'アカウントが作成されているべき');
        Account acc = accList[0];
        System.assertEquals('テスト太郎', acc.LastName);

        List<Case__c> ccList = [SELECT Id, Account__c, MailBody__c, Mileage_hs__c FROM Case__c WHERE Account__c = :acc.Id];
        System.assertEquals(1, ccList.size(), 'Case__c が作成されているべき');
        Case__c cc = ccList[0];
        System.assertEquals(45001, cc.Mileage_hs__c, '走行距離が正しく変換されているべき');
        System.assert(cc.MailBody__c.contains('事故車'), '事故車情報が本文に含まれているべき');

        // Case に CustomCase__c がセットされていること
        Case updated = [SELECT CustomCase__c FROM Case WHERE Id = :c.Id];
        System.assertNotEquals(null, updated.CustomCase__c, 'Case に CustomCase__c が設定されているべき');
    }
}