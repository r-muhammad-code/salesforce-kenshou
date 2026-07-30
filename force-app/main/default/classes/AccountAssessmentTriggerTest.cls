@isTest
public without sharing class AccountAssessmentTriggerTest {
    testmethod private static void testAccountAssessmentTrigger(){
        // テストデータ作成
        TestDataFactory tdf = new TestDataFactory();
        // 取引先責任者（ディーラ）
        Contact con = tdf.createContactData();
        // コミュニティユーザ（ディーラ）
        User comUser = tdf.createCommunityUser(con);
        // 査定ユーザ（ディーラ）
        Mst_Assess_Users__c assUser = tdf.createAccountAssessUser(con);

        // 取引先作成（中古車部）
        Account acc2 = tdf.createAccountData2();
        // ディーラの上位取引先に中古車部を紐付け
        tdf.relAcc(acc2);
        // 取引先責任者（中古車部）
        Contact con2 = tdf.createContactData2(acc2);
        // コミュニティユーザ（中古車部）
        User comUser2 = tdf.createCommunityUser2(con2);
        // 中古車部の通知担当者（Notifier__c）に取引先責任者（中古車部）をひも付け
        tdf.relAccNotifier(acc2, comUser2);


        // テスト開始
        Test.startTest();

        // 取引先査定表データ作成
        tdf.createAccountAssessmentData(assUser);

        // テスト終了
        Test.stopTest();

        // Assert
        List<AccountAssessment__c> accAss = [
            Select
                Id, Name, OwnerId
            From
                AccountAssessment__c
        ];
        System.assertEquals(comUser.Id, accAss[0].OwnerId);
    }
}