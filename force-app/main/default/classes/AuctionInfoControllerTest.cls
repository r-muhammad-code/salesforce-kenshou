@isTest
public with sharing class AuctionInfoControllerTest {
    public List<ContentVersion> converList {get; set;}
    public AuctionInfoControllerTest() {
    }

    @TestSetup
    static void makeData(){
        TestDataFactory factory = new TestDataFactory();
        // 取引先責任者
        Contact con = factory.createContactData();
        // ユーザ
        User comUsr = factory.createCommunityUser(con);
        /**
         * 取引先作成
         */
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

        List<ContentVersion> cvList = new List<ContentVersion>();
        // String titleBase = 'TEST-';
        String titleBase = 'TEST-1';
        // for (Integer i; i<=6; i++) {
            // String ControlNumber = '201215-' + String.valueOf(i);
            // String title = String.valueOf(i);
            // String title = 'TEST-1';
            ContentVersion cv = new ContentVersion(
                ControlNumber__c = '201215-1',                 // 管理番号
                Title = 'TEST-1',
                cell__c = 'セル',                                   // セル
                jiso__c = '自走',                                   // 自走
                engine__c = 'エンジン',                               // エンジン
                SoldData__c = Date.parse('2020/12/12'),                           // 売却日
                car_model__c = 'アクア',                           // 車種
                car_grade__c = 'グレード',                         // グレード
                car_type__c = '',                         // 型式
                registerdAtYear__c = '',             // 年式
                auc_sales_price__c = 10000,             // 売却金額
                PathOnClient ='test',
                run_dist__c = '123',
                // Blob b=Blob.valueOf('Unit Test Attachment Body'),
                versiondata = EncodingUtil.base64Decode('Unit Test Attachment Body')
            );
            cvList.add(cv);
            ContentVersion cv2 = new ContentVersion(
                ControlNumber__c = '201215-1',                 // 管理番号
                Title = 'TEST-2',
                cell__c = 'セル',                                   // セル
                jiso__c = '自走',                                   // 自走
                engine__c = 'エンジン',                               // エンジン
                SoldData__c = Date.parse('2020/12/12'),                           // 売却日
                car_model__c = 'アクア',                           // 車種
                car_grade__c = 'グレード',                         // グレード
                car_type__c = '',                         // 型式
                registerdAtYear__c = '',             // 年式
                auc_sales_price__c = 10000,             // 売却金額
                PathOnClient ='test',
                run_dist__c = '123',
                // Blob b=Blob.valueOf('Unit Test Attachment Body'),
                versiondata = EncodingUtil.base64Decode('Unit Test Attachment Body')
            );
            cvList.add(cv2);
            ContentVersion cv3 = new ContentVersion(
                ControlNumber__c = '201215-1',                 // 管理番号
                Title = 'TEST-3',
                cell__c = 'セル',                                   // セル
                jiso__c = '自走',                                   // 自走
                engine__c = 'エンジン',                               // エンジン
                SoldData__c = Date.parse('2020/12/12'),                           // 売却日
                car_model__c = 'アクア',                           // 車種
                car_grade__c = 'グレード',                         // グレード
                car_type__c = '',                         // 型式
                registerdAtYear__c = '',             // 年式
                auc_sales_price__c = 10000,             // 売却金額
                PathOnClient ='test',
                run_dist__c = '123',
                // Blob b=Blob.valueOf('Unit Test Attachment Body'),
                versiondata = EncodingUtil.base64Decode('Unit Test Attachment Body')
            );
            cvList.add(cv3);
            ContentVersion cv4 = new ContentVersion(
                ControlNumber__c = '201215-1',                 // 管理番号
                Title = 'TEST-4',
                cell__c = 'セル',                                   // セル
                jiso__c = '自走',                                   // 自走
                engine__c = 'エンジン',                               // エンジン
                SoldData__c = Date.parse('2020/12/12'),                           // 売却日
                car_model__c = 'アクア',                           // 車種
                car_grade__c = 'グレード',                         // グレード
                car_type__c = '',                         // 型式
                registerdAtYear__c = '',             // 年式
                auc_sales_price__c = 10000,             // 売却金額
                PathOnClient ='test',
                run_dist__c = '123',
                // Blob b=Blob.valueOf('Unit Test Attachment Body'),
                versiondata = EncodingUtil.base64Decode('Unit Test Attachment Body')
            );
            cvList.add(cv4);
            ContentVersion cv5 = new ContentVersion(
                ControlNumber__c = '201215-1',                 // 管理番号
                Title = 'TEST-5',
                cell__c = 'セル',                                   // セル
                jiso__c = '自走',                                   // 自走
                engine__c = 'エンジン',                               // エンジン
                SoldData__c = Date.parse('2020/12/12'),                           // 売却日
                car_model__c = 'アクア',                           // 車種
                car_grade__c = 'グレード',                         // グレード
                car_type__c = '',                         // 型式
                registerdAtYear__c = '',             // 年式
                auc_sales_price__c = 10000,             // 売却金額
                PathOnClient ='test',
                run_dist__c = '123',
                // Blob b=Blob.valueOf('Unit Test Attachment Body'),
                versiondata = EncodingUtil.base64Decode('Unit Test Attachment Body')
            );
            cvList.add(cv5);
            ContentVersion cv6 = new ContentVersion(
                ControlNumber__c = '201215-1',                 // 管理番号
                Title = 'TEST-6',
                cell__c = 'セル',                                   // セル
                jiso__c = '自走',                                   // 自走
                engine__c = 'エンジン',                               // エンジン
                SoldData__c = Date.parse('2020/12/12'),                           // 売却日
                car_model__c = 'アクア',                           // 車種
                car_grade__c = 'グレード',                         // グレード
                car_type__c = '',                         // 型式
                registerdAtYear__c = '',             // 年式
                auc_sales_price__c = 10000,             // 売却金額
                PathOnClient ='test',
                run_dist__c = '123',
                // Blob b=Blob.valueOf('Unit Test Attachment Body'),
                versiondata = EncodingUtil.base64Decode('Unit Test Attachment Body')
            );
            cvList.add(cv6);
        // }
        insert cvList;
    }

    @isTest
    static void auctionInfoDataTest() {
        // 取引先査定表取得
        AccountAssessment__c accAss = [SELECT Id, car_model__r.Name ,registerdAtYear__c,car_type__r.Name FROM AccountAssessment__c LIMIT 1];
        List<ContentVersion> conVer = [SELECT Id, Title FROM ContentVersion];
        // assert用に変数を用意
        String imgUrl1 = '';
        String imgUrl2 = '';
        String imgUrl3 = '';
        String imgUrl4 = '';
        String imgUrl5 = '';
        String imgUrl6 = '';
        for (ContentVersion cv : conVer) {
            String title = cv.Title.right(1);
            if (title == '1') {
                imgUrl1 = AuctionInfoConstants.IMAGE_URL_BASE + cv.Id;
            } else if (title == '2') {
                imgUrl2 = AuctionInfoConstants.IMAGE_URL_BASE + cv.Id;
            } else if (title == '3') {
                imgUrl3 = AuctionInfoConstants.IMAGE_URL_BASE + cv.Id;
            } else if (title == '4') {
                imgUrl4 = AuctionInfoConstants.IMAGE_URL_BASE + cv.Id;
            } else if (title == '5') {
                imgUrl5 = AuctionInfoConstants.IMAGE_URL_BASE + cv.Id;
            } else if (title == '6') {
                imgUrl6 = AuctionInfoConstants.IMAGE_URL_BASE + cv.Id;
            }
        }
        // テストするページを設定
        PageReference currentPage = Page.AuctionInfo;
        Test.setCurrentPage(currentPage);
        System.debug(accAss.car_model__r.Name);
        currentPage.getParameters().put('Id' , accAss.Id );
        // StandardController設定
        ApexPages.StandardController sc = new ApexPages.StandardController(accAss);
        AuctionInformation__c auction = [SELECT Id, car_model__c ,registerdAtYear__c,car_type__c FROM   AuctionInformation__c LIMIT 1];
        System.debug(auction);

        Test.startTest();
        AuctionInfoController your_ctrl = new AuctionInfoController(sc);
        // 初期化
        your_ctrl.init();
        // テストデータのAssert
        System.assertEquals(null, your_ctrl.rcList.get(0).firstResisteredYear);            // 初年度登録日
        System.assertEquals('セル', your_ctrl.rcList.get(0).cell);                         // セル
        System.assertEquals('アクア', your_ctrl.rcList.get(0).carModel);                       // 車種
        System.assertEquals('グレード', your_ctrl.rcList.get(0).grade);                     // グレード
        System.assertEquals(null, your_ctrl.rcList.get(0).carType);                        // 型式
        System.assertEquals(123, your_ctrl.rcList.get(0).runDist);                         // 走行距離
        System.assertEquals('エンジン', your_ctrl.rcList.get(0).engine);                    // エンジン
        System.assertEquals('自走', your_ctrl.rcList.get(0).selfRun);                       // 自走
        System.assertEquals(Date.parse('2020/12/12'), your_ctrl.rcList.get(0).soldDate);    // 売却日
        System.assertEquals(10000, your_ctrl.rcList.get(0).soldAmount);                     // 売却金額
        System.assertEquals(imgUrl1, your_ctrl.rcList.get(0).imgUrl1);                      // 画像1
        System.assertEquals(imgUrl2, your_ctrl.rcList.get(0).imgUrl2);                      // 画像2
        System.assertEquals(imgUrl3, your_ctrl.rcList.get(0).imgUrl3);                      // 画像3
        System.assertEquals(imgUrl4, your_ctrl.rcList.get(0).imgUrl4);                      // 画像4
        System.assertEquals(imgUrl5, your_ctrl.rcList.get(0).imgUrl5);                      // 画像5
        System.assertEquals(imgUrl6, your_ctrl.rcList.get(0).imgUrl6);                      // 画像6

        Test.stopTest();
    }
    @isTest
    static void auctionInfoSortTest() {
        // 取引先査定表取得
        AccountAssessment__c accAss = [SELECT Id, car_model__r.Name ,registerdAtYear__c,car_type__r.Name FROM AccountAssessment__c LIMIT 1];
        // テストするページを設定
        PageReference currentPage = Page.AuctionInfo;
        Test.setCurrentPage(currentPage);
        currentPage.getParameters().put('Id' , accAss.Id );
        // StandardController設定
        ApexPages.StandardController sc = new ApexPages.StandardController(accAss);
        // 定数クラス
        AuctionInfoConstants constant = new AuctionInfoConstants();

        Test.startTest();
        AuctionInfoController your_ctrl = new AuctionInfoController(sc);
        // 初期ソート（売却日の降順でソートする）
        your_ctrl.init();
        System.assertEquals('DESC', your_ctrl.condition.order);
        System.assertEquals('SoldData__c', your_ctrl.getSortKey());
        System.assertEquals('▼', your_ctrl.getSortOrder());

        // ソート順 売却日でソート
        your_ctrl.sortingField = 'SoldData__c';
        your_ctrl.sort();
        System.assertEquals('ASC', your_ctrl.condition.order);
        System.assertEquals('SoldData__c', your_ctrl.getSortKey());
        System.assertEquals('▲', your_ctrl.getSortOrder());

        // 自走でソート（1回目　降順）
        your_ctrl.sortingField = 'jiso__c';
        your_ctrl.sort();
        System.assertEquals('ASC', your_ctrl.condition.order);
        System.assertEquals('jiso__c', your_ctrl.getSortKey());
        System.assertEquals('▲', your_ctrl.getSortOrder());

        // 自走でソート（2回目　昇順）
        your_ctrl.sortingField = 'jiso__c';
        your_ctrl.sort();
        System.assertEquals('DESC', your_ctrl.condition.order);
        System.assertEquals('jiso__c', your_ctrl.getSortKey());
        System.assertEquals('▼', your_ctrl.getSortOrder());

        // 売却金額でソート（1回目　降順）
        your_ctrl.sortingField = 'auc_sales_price__c';
        your_ctrl.sort();
        System.assertEquals('ASC', your_ctrl.condition.order);
        System.assertEquals('auc_sales_price__c', your_ctrl.getSortKey());
        System.assertEquals('▲', your_ctrl.getSortOrder());

        // 売却金額でソート（2回目　昇順）
        your_ctrl.sortingField = 'auc_sales_price__c';
        your_ctrl.sort();
        System.assertEquals('DESC', your_ctrl.condition.order);
        System.assertEquals('auc_sales_price__c', your_ctrl.getSortKey());
        System.assertEquals('▼', your_ctrl.getSortOrder());
        
        // オフセット
        your_ctrl.getOffset();
        
        your_ctrl.sortingField = 'SoldData__c';
        your_ctrl.getSortOrder();
        Test.stopTest();
    }

}