@isTest
public class AssessmentDetailTest {


    // コンストラクタ
    public AssessmentDetailTest() {

    }

/*    testmethod private static void testDoSaveCancel(){

        TestDataFactory tdf = new TestDataFactory();

        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.AssessmentDetail;
        Test.setCurrentPage(pageRef);
        
        // 2.画面で操作するオブジェクトを生成
        // 検索条件なし
        Assessment__c ass = new Assessment__c();
        ass = tdf.createAssessmentData();
        ass = getAssData(ass.Id);

        System.debug('ass.id to standardController : ' + ass.id);
        System.debug('ass.name to standardController : ' + ass.name);
        
        // 3.標準コントローラを生成
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(ass);
        
        // 4.コントローラ拡張を生成
        AssessmentDetailController assCtrl = new AssessmentDetailController(stdCtrl);

        Test.startTest();
            assCtrl.ass.asset_mngno__c = '20190509-001';
            assCtrl.ass.car_number__c = '神戸501 な1234';
            assCtrl.ass.damage_other__c = 'バンパーに小さな傷あり';

            // 正常に更新
            assCtrl.doSave();

            ass = getAssData(ass.Id);

            System.assertEquals(ass.asset_mngno__c, '20190509-001');
            System.assertEquals(ass.car_number__c, '神戸501 な1234');
            System.assertEquals(ass.damage_other__c, 'バンパーに小さな傷あり');

            // エラー
            assCtrl.ass.id = 'a090w0000004r2pAAA';

            assCtrl.doSave();

            // キャンセル
            assCtrl.doCancel();

        Test.stopTest();
    }
*/
    testmethod private static void testPostAssessmentInfo(){

        TestDataFactory tdf = new TestDataFactory();

        Test.setMock(HttpCalloutMock.class, new AssessmentDetailTestCalloutMock());        

        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.PostAssessmentInfo;
        Test.setCurrentPage(pageRef);
        
        // 2.画面で操作するオブジェクトを生成
        // 検索条件なし
        Assessment__c ass = new Assessment__c();
        ass = tdf.createAssessmentData();
        ass = getAssData(ass.Id);
        System.debug('ass.id to standardController : ' + ass.id);
        System.debug('ass.name to standardController : ' + ass.name);
        
  
        // 3.標準コントローラを生成
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(ass);
        
        // 4.コントローラ拡張を生成
        PostAssessmentInfoController assCtrl = new PostAssessmentInfoController(stdCtrl);


        Test.startTest();
        // System.runAs(contextuser){
            assCtrl.postAssessmentInfo();
            
            System.assertEquals('送信に成功しました。', ApexPages.getMessages().get(0).getDetail());
            
        // }
        Test.stopTest();
        
    }

    // 営業データ出品項目確認 20211028 HANA_SF_SATEI-205
    testmethod private static void testPostAssessmentInfoSalesNotSelected(){

        TestDataFactory tdf = new TestDataFactory();

        Test.setMock(HttpCalloutMock.class, new AssessmentDetailTestCalloutMock());        

        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.PostAssessmentInfo;
        Test.setCurrentPage(pageRef);
        
        // 2.画面で操作するオブジェクトを生成
        // 検索条件なし
        Assessment__c ass = new Assessment__c();
        ass = tdf.createAssessmentDataSalesNotSelected();
        ass = getAssData(ass.Id);
        System.debug('ass.id to standardController : ' + ass.id);
        System.debug('ass.name to standardController : ' + ass.name);
        
  
        // 3.標準コントローラを生成
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(ass);
        
        // 4.コントローラ拡張を生成
        PostAssessmentInfoController assCtrl = new PostAssessmentInfoController(stdCtrl);


        Test.startTest();
        // System.runAs(contextuser){
            assCtrl.postAssessmentInfo();
            
            System.assertEquals('営業データ出品項目を入力してください。', ApexPages.getMessages().get(0).getDetail());
            
        // }
        Test.stopTest();
        
    }


    testmethod private static void testPostAssessmentInfoError(){

        TestDataFactory tdf = new TestDataFactory();

        Test.setMock(HttpCalloutMock.class, new AssessmentDetailTestCalloutMockError());        

        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.PostAssessmentInfo;
        Test.setCurrentPage(pageRef);
        
        // 2.画面で操作するオブジェクトを生成
        // 検索条件なし
        Assessment__c ass = new Assessment__c();
        ass = tdf.createAssessmentData();
        ass = getAssData(ass.Id);
        System.debug('ass.id to standardController : ' + ass.id);
        System.debug('ass.name to standardController : ' + ass.name);
        
  
        // 3.標準コントローラを生成
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(ass);
        
        // 4.コントローラ拡張を生成
        PostAssessmentInfoController assCtrl = new PostAssessmentInfoController(stdCtrl);


        Test.startTest();
        // System.runAs(contextuser){
            assCtrl.postAssessmentInfo();
            
            System.assertEquals('送信に失敗しました。管理者に連絡して下さい。', ApexPages.getMessages().get(0).getDetail());
        // }
        Test.stopTest();
        
    }

    testmethod private static void testPostAssessmentConfirm(){

        TestDataFactory tdf = new TestDataFactory();

        Test.setMock(HttpCalloutMock.class, new AssessmentDetailTestCalloutMock());        

        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.PostAssessmentInfo;
        Test.setCurrentPage(pageRef);
        
        // 2.画面で操作するオブジェクトを生成
        // 検索条件なし
        Assessment__c ass = new Assessment__c();
        ass = tdf.createAssessmentData();
        ass = getAssData(ass.Id);
        System.debug('ass.id to standardController : ' + ass.id);
        System.debug('ass.name to standardController : ' + ass.name);
        
  
        // 3.標準コントローラを生成
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(ass);
        
        // 4.コントローラ拡張を生成
        PostAssessmentInfoController assCtrl = new PostAssessmentInfoController(stdCtrl);


        Test.startTest();
        // System.runAs(contextuser){
            assCtrl.confirm();
            
            System.assertEquals(ass.Id, assCtrl.retURL);
            
        // }
        Test.stopTest();
    }


    testmethod private static void testPostAssessmentSend(){

        TestDataFactory tdf = new TestDataFactory();

        Test.setMock(HttpCalloutMock.class, new AssessmentDetailTestCalloutMock());        

        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.PostAssessmentInfo;
        Test.setCurrentPage(pageRef);
        
        // 2.画面で操作するオブジェクトを生成
        // 検索条件なし
        Assessment__c ass = new Assessment__c();
        ass = tdf.createAssessmentData();
        ass = getAssData(ass.Id);

        Assessment__c updAss = new Assessment__c(
            Id = ass.Id,
            SendDateToAuctionSite__c = Datetime.now()
        );
        update updAss;

        System.debug('ass.id to standardController : ' + ass.id);
        System.debug('ass.name to standardController : ' + ass.name);
        
  
        // 3.標準コントローラを生成
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(ass);
        
        // 4.コントローラ拡張を生成
        PostAssessmentInfoController assCtrl = new PostAssessmentInfoController(stdCtrl);


        Test.startTest();
        // System.runAs(contextuser){
            assCtrl.postAssessmentInfo();
            
            System.assertEquals('送信済です。', ApexPages.getMessages().get(0).getDetail());
            
        // }
        Test.stopTest();
        
    }


    private static Assessment__c getAssData(Id assid){
        return [
            Select
                Name
                ,account__c
                ,oppotunity__c
                ,oppotunity__r.Mst_Types__r.inum__c       // 型式（INUM）　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Mst_Types__r.Name       // 型式名　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.engine_form__c       // エンジン型式　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.form_num__c       // 型式指定番号　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.bunrui_num__c       // 類別区分番号　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.CarNo__c       // 車台番号　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.run_contents__c       // メーター状態　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.ModelYearPickList__c       // 年式　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.First_year_registration__c       // 初年度登録月　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Except_First_year_registration__c       // 初年度月除外　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.fuel__c       // 燃料　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.teiin__c       // 定員　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.dis_volume__c       // 排気量　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.vehicle_length__c       // 長さ　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.vehicle_width__c       // 幅　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.vehicle_height__c       // 高さ　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.vehicle_weight__c       // 車輌重量　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.shaken_erase_year__c       // 車検期限年　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.shaken_erase_month__c       // 車検期限月　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Mst_Grades__r.inum__c       // グレード（INUM）　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Mst_Grades__r.Name       // グレード名　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.OpportunityID_18__c       // 買取商談ID（18ケタ）　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.exhibit_memo__c       // 注意事項　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.alert_memo__c       // 警告設定　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.setting_content__c       // 取・メン・保・スペア　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.auc_area__c       // 出品先　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.nyu_price__c       // 入札希望価格　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.expected_price__c       // 仕入希望価格　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.auc_sprice__c       // ライブ開始価格　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Vehicle_Gross_Weight__c       // 車輌総重量
                ,oppotunity__r.maximum_payload__c       // 最大積載量            
                ,ai_use_umu__c
                ,sv_sync_date__c
                ,suspended_flg__c
                ,damage_other__c
                ,store__c
                ,yard_kbn__c      //ヤード区分　pj2451033 追加
                ,LotNo_yard__c          // ロットNo　20220525 HANA_SF_SATEI-223
                ,asses_date__c
                ,asses_tanto__c
                ,tanto_manage_bumon__c
                ,asset_mngno__c
                ,car_number__c
                ,car_maker__c
                ,car_model__c
                // ,car_grade__c
                // ,car_type__c
                ,registerdAtGengo__c
                ,registerdAtYear__c
                // ,registerdAtMonth__c
                // ,engine_katasiki__c
                ,seizo_nensiki__c
                ,color_changed__c
                ,full_katasiki__c
                ,color_no__c
                ,color__c
                ,front_url__c
                ,right_front_url__c
                ,left_front_url__c
                ,left_back_url__c
                ,right_back_url__c
                ,shakensho_url__c
            	,shadai_no__c
            From
                Assessment__c
            Where
                Id = :assid
            Limit 1
        ];
    }

}