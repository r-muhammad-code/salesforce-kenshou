@isTest
public with sharing class AssessmentDetailTestCalloutMockError implements HttpCalloutMock{

    // コンストラクタ
    public AssessmentDetailTestCalloutMockError() {
    }

    // テストで返すレスポンス
    public HttpResponse Respond(HttpRequest req){

        // オークションサイトへの送信のみ
        System.assertEquals(Constants.AUCTIONSITE_URL, req.getEndpoint());
        System.assertEquals('POST', req.getMethod());

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(201);
        // res.setBody(JsonForMock());

        return res;
    }

    // private String JsonForMock(){
    //     JSONGenerator gen = JSON.createGenerator(true);

    //     gen.writeStartObject();

    //     gen.writeStringField('Name', 'testJSON');     // 査定表名
    //     gen.writeIdField('Id', 'testId');     // Salesforce ID
    //     gen.writeBooleanField('suspended_flg__c', false);        // 中断フラグ

    //     gen.writeEndObject();

    //     return gen.getAsString();
    // }
}