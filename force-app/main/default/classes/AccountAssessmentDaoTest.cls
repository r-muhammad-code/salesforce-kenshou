@isTest
public with sharing class AccountAssessmentDaoTest {
    testmethod private static void testIsTrue(){
        AccountAssessment__c data = CreateData([SELECT Id FROM RecordType WHERE DeveloperName ='Auction'].Id);

        // テスト開始
        Test.startTest();

        System.assertEquals(AccountAssessmentDao.IsEnableRecodeType(data.Id), true);

        // テスト終了
        Test.stopTest();
    }

    testmethod private static void testIsFalse(){
        AccountAssessment__c data = CreateData([SELECT Id FROM RecordType WHERE DeveloperName ='Normal'].Id);

        // テスト開始
        Test.startTest();

        System.assertEquals(AccountAssessmentDao.IsEnableRecodeType(data.Id), false);

        // テスト終了
        Test.stopTest();
    }

    /*
    * テストデータ作成
    */
    private static AccountAssessment__c CreateData(Id recordTypeId){
        TestDataFactory factory = new TestDataFactory();
        // 取引先責任者
        Contact con = factory.createContactData();
        // ユーザ
        User comUsr = factory.createCommunityUser(con);
        //取引先作成
        Account topAcc = new Account(
            Name = 'テスト上位会社',           // 取引先名
            TradeType__c = '新規',                     // 取引種別
            CorporationType__c = '法人',               // 一般/法人種別
            Segment__c = '損保',                       // セグメント
            Rank__c = 'S',                           // ランク
            Target__c = false,                       // ターゲット
            Fax = null,                              // Fax
            Field1__c = null,                        // 定休日
            ParentId = null,                         // 親取引先
            SummaryAccountFlg__c = false,            // 集計企業
            Description2__c = null,                  // 説明.
            CustomerCompass__CClatitude__c = null,   // CClatitude
            CustomerCompass__CClongitude__c = null,  // CClongitude
            Notifier__c = comUsr.Id
        );
        insert topAcc;
        // コミュニティ上位会社に値が無いとフローでエラーが発生するのでセットする
        Account updAcc = [SELECT Id, CommunityTopBusinessAccount__c FROM Account WHERE Name = 'ヴァイタルインフォメーション株式会社'];
        updAcc.CommunityTopBusinessAccount__c = topAcc.Id;
        update updAcc;
        // 取引先査定表ユーザ
        Mst_Assess_Users__c mstAssUser = factory.createAccountAssessUser(con);

        // 取引先査定表
        AccountAssessment__c  accAss = factory.createAccountAssessmentData(mstAssUser);

        // 引数で指定されたレコードIDを設定
        accAss.RecordTypeId = recordTypeId;
        Upsert accAss;

        return accAss;
    }

}