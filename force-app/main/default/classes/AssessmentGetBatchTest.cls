@istest
public without sharing class AssessmentGetBatchTest {
    public AssessmentGetBatchTest() {
    }

    testmethod private static void testAssessmentBatchExecuteSuccess(){
        Test.setMock(HttpCalloutMock.class, new AssessmentDetailTestCalloutMock());
        executeTest();
        // Apexをスケジュールに登録
        String jobId = System.schedule('TestScheduledApex','0 0 * * * ?', new AssessmentGetBatchSchedule());
        List<Assessment__c> postSuccess;
        postSuccess = [Select Name From Assessment__c Where SendDateToAuctionSite__c != null];
        System.assertEquals(postSuccess.size(), 5, 'success');
    }

    testmethod private static void testAssessmentBatchExecuteFailed(){
        Test.setMock(HttpCalloutMock.class, new AssessmentDetailTestCalloutMockError());
        executeTest();
        // Apexをスケジュールに登録
        String jobId = System.schedule('TestScheduledApex','0 0 * * * ?', new AssessmentGetBatchSchedule());
        List<Assessment__c> postError;
        postError = [Select Name From Assessment__c Where error_flg__c = true];
        System.assertEquals(postError.size(), 5, 'failed');
    }

    //査定ユーザ作成
    private static void executeTest(){
        Mst_Assess_Users__c sobj = new Mst_Assess_Users__c(
            Name = 'test',
            emp_kind__c = '0',
            login_user__c = 'test',
            pass__c = 'test'
        );
        insert sobj;

        //ヤードレコードタイプId取得
        RecordType RecordTypeYardId = [select Id from RecordType where DeveloperName = 'yard' And SObjectType = 'Assessment__c' Limit 1];
        List<Assessment__c> data = new List<Assessment__c>();
        
        for(integer i=0;i<5;i++){
            data.add(new Assessment__c(
                //ヤード査定表作成
                suspended_flg__c = false,                                 // 中断フラグ
                error_flg__c = false,                                     // エラーフラグ
                asses_date__c = Datetime.valueOf('2020-10-23 12:00:00'),  // 査定年月日
                asses_tanto__c = sobj.Id,                                 // 査定担当者
                asset_mngno__c = '00000'+ i.format(),                     // 査定表管理No.
                tokki_inner__c = '室内ばらし',
                RecordTypeId = RecordTypeYardId.Id));

            data.add( new Assessment__c(
                //営業査定表作成
                suspended_flg__c = false,                                 // 中断フラグ
                error_flg__c = false,                                     // エラーフラグ
                asses_date__c = Datetime.valueOf('2020-10-23 12:00:00'),  // 査定年月日
                asses_tanto__c = sobj.Id,                                 // 査定担当者
                asset_mngno__c = '11111'+i.format(),                      // 査定表管理No.
                tokki_inner__c = '室内ばらし'));
        }
        insert data;

        System.assertEquals(data.size(), 10);

        Test.startTest();
        AssessmentGetBatch batch = new AssessmentGetBatch();
        Database.QueryLocator ql = batch.start(null);
        List<Assessment__c> dataList = new List<Assessment__c>();
        
        Database.QueryLocatorIterator it =  ql.iterator();
        while (it.hasNext())
        {
            dataList.add((Assessment__c)it.next());
        }

        batch.execute(null,dataList);
        batch.finish(null);
        Test.stopTest();
    }
}