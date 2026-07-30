@isTest
public without sharing class ContentVersionTriggerTest {
    testmethod private static void testContentVersionTrigger(){
        // テストデータ作成
        List<ContentVersion> contentVersionList = new List<ContentVersion>();
        ContentVersion cv = new ContentVersion();
        Integer createAuctionRecord = 20;
        Integer createContentRecord = 6;
        for(Integer i=1; i<=createAuctionRecord; i++){
            String title = '1';
            for(Integer j=1; j<=createContentRecord; j++){
                cv = new ContentVersion();
                cv.Title = title;                                                 // タイトル
                cv.cell__c = '回る';                                              // セル
                cv.jiso__c = '可';                                                // 自走
                cv.engine__c = 'かかる';                                          // エンジン
                cv.SoldData__c = Date.parse('2020/10/01');                        // 売却日
                cv.car_type__c = 'アクア';                                        // 車種
                cv.car_grade__c = 'L';                                            // グレード
                cv.car_model__c = 'DAA-MK42S';                                    // 型式
                cv.ControlNumber__c = '201205_' + String.valueOf(i).leftPad(8, '0');                      // 管理番号
                cv.registerdAtYear__c = '2019';                                   // 年式
                cv.auc_sales_price__c = Decimal.valueOf(500000);                  // 売却金額
                cv.run_dist__c = '35000';                                         // 走行距離
                cv.PathOnClient = 'expense.csv';
                cv.VersionData = Blob.valueOf('expense.csv');

                contentVersionList.add(cv);
            }
            Integer titleIncrease = Integer.valueOf(title);
            titleIncrease += 1;
            title = String.valueOf(titleIncrease);
        }
        // テスト開始
        Test.startTest();
        // コンテンツバージョンをinsertする
        insert contentVersionList;
        System.assertEquals(cv.cell__c, contentVersionList[0].cell__c);
        // オークション情報取得
        List<AuctionInformation__c> aucList = [SELECT cell__c FROM AuctionInformation__c];
        System.assertEquals(aucList[0].cell__c, contentVersionList[0].cell__c);
        // コンテンツドキュメントリンクの情報取得
        // List<ContentDocumentLink> cdlList = [SELECT LinkedEntityId FROM ContentDocumentLink];
        // System.debug(cdlList[0]);
        // テスト終了
        Test.stopTest();
    }
    testmethod private static void testContentVersionTrigger_otherAuction(){
        // テストデータ作成
        List<ContentVersion> contentVersionList = new List<ContentVersion>();
        ContentVersion cv = new ContentVersion();
        Integer createAuctionRecord = 20;
        Integer createContentRecord = 6;
        for(Integer i=1; i<=createAuctionRecord; i++){
            for(Integer j=1; j<=createContentRecord; j++){
                cv = new ContentVersion();
                cv.PathOnClient = 'expense.csv';
                cv.VersionData = Blob.valueOf('expense.csv');

                contentVersionList.add(cv);
            }
        }
        // テスト開始
        Test.startTest();
        // コンテンツバージョンをinsertする
        insert contentVersionList;
        // オークション情報取得
        List<AuctionInformation__c> aucList = [SELECT Id FROM AuctionInformation__c];
        System.assertEquals(aucList.size(), 0);
        Test.stopTest();
    }
}