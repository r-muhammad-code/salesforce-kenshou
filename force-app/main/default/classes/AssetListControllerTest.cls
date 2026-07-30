@isTest
public class AssetListControllerTest {
    public static TestDataFactory tdf;
    public static PageReference PageRef;
    public static AssetListController alCtrl;

    // 全条件を指定して検索
    static testMethod void testAssetListSearchAll() {

        // テスト用VFページ初期化
        initTestPage();
        setSearchConditionAsset();

        Test.startTest();

        alCtrl.sortInitSearch();

        System.assertEquals(1, alCtrl.assetResults.size());

        Test.stopTest();
    }


    // 条件を指定せずに検索
    static testMethod void testAssetListSearchNull() {

        // テスト用VFページ初期化
        initTestPage();
        setSearchConditionAssetNull();

        Test.startTest();

        alCtrl.sortInitSearch();

        System.assertEquals(1, alCtrl.assetResults.size());

        Test.stopTest();
    }


    // 検索結果が2000件以上
    static testMethod void testAssetListSearch2001() {

        // テスト用VFページ初期化
        initTestPage2001();
        setSearchConditionAsset();

        Test.startTest();

        alCtrl.sortInitSearch();

        Test.stopTest();
    }


    // クリアボタンのテスト
    static testMethod void testAssetListClear() {

        // テスト用VFページ初期化
        initTestPage();
        setSearchConditionAsset();

        Test.startTest();

        alCtrl.clear();

        System.assertEquals('asset_mngno__c', alCtrl.condition.sortkey);
        System.assertEquals('DESC', alCtrl.condition.order);
        System.assertEquals(new List<String>(), alCtrl.condition.Maker);
        System.assertEquals(new List<String>(), alCtrl.condition.Model);
        System.assertEquals(new List<String>(), alCtrl.condition.ManageBumon);
        System.assertEquals(new List<String>(), alCtrl.condition.AssessTanto);

        Test.stopTest();
    }


    // ソートのテスト
    static testMethod void testAssetListSort() {

        // テスト用VFページ初期化
        initTestPage();
        setSearchConditionAsset();

        Test.startTest();

        // ソートキー不明
        alCtrl.sortingField = null;
        alCtrl.sort();
        System.assertEquals('asset_mngno__c', alCtrl.condition.sortkey);
        System.assertEquals('DESC', alCtrl.condition.order);
        System.assertEquals('asset_mngno__c', alCtrl.getSortkey());
        System.assertEquals('▼', alCtrl.getSortOrder());

        // ソートするフィールドが現在ソートしているフィールドと同じ場合、ソート順を逆転
        alCtrl.sortingField = 'asset_mngno__c';
        alCtrl.sort();
        System.assertEquals('asset_mngno__c', alCtrl.condition.sortkey);
        System.assertEquals('ASC', alCtrl.condition.order);
        System.assertEquals('asset_mngno__c', alCtrl.getSortkey());
        System.assertEquals('▲', alCtrl.getSortOrder());

        // ソートするフィールドが現在ソートしているフィールドと同じ場合、ソート順を逆転
        alCtrl.sortingField = 'asset_mngno__c';
        alCtrl.sort();
        System.assertEquals('asset_mngno__c', alCtrl.condition.sortkey);
        System.assertEquals('DESC', alCtrl.condition.order);
        System.assertEquals('asset_mngno__c', alCtrl.getSortkey());
        System.assertEquals('▼', alCtrl.getSortOrder());

        // ソートするフィールドが現在ソートしているフィールドと異なる場合、ソートフィールドを変更し昇順で並び替え
        alCtrl.sortingField = 'asses_date__c';
        alCtrl.sort();
        System.assertEquals('asses_date__c', alCtrl.condition.sortkey);
        System.assertEquals('ASC', alCtrl.condition.order);
        System.assertEquals('asses_date__c', alCtrl.getSortkey());
        System.assertEquals('▲', alCtrl.getSortOrder());

        Test.stopTest();
    }

    // メーカーリスト
    static testMethod void testAssetListGetMakerList() {

        // テスト用VFページ初期化
        initTestPage();
        setSearchConditionAsset();

        Test.startTest();

        List<SelectOption> makerListExpected = new List<SelectOption>();
        makerListExpected.add(new SelectOption('blank',''));
        makerListExpected.add(new SelectOption('3','トヨタ'));

        System.assertEquals(makerListExpected, alCtrl.getMakerList());

        Test.stopTest();
    }

    // 車種リスト
    static testMethod void testAssetListGetModelList() {

        // テスト用VFページ初期化
        initTestPage();
        setSearchConditionAsset();

        Test.startTest();

        alCtrl.condition.Maker = new List<String>{'3'};

        List<SelectOption> modelListExpected = new List<SelectOption>();
        modelListExpected.add(new SelectOption('blank',''));
        modelListExpected.add(new SelectOption('34124','アクア'));

        System.assertEquals(modelListExpected, alCtrl.getModelList());

        Test.stopTest();
    }

    // 査定担当者リスト
    static testMethod void testAssetListGetBumonList() {

        // テスト用VFページ初期化
        initTestPage();
        setSearchConditionAsset();

        Test.startTest();

        // 本番で支店が変更されるたびに改修が必要になるので、Assertをやめる 20210128
        // List<SelectOption> bumonListExpected = new List<SelectOption>();
        // bumonListExpected.add(new SelectOption('blank',''));
        // bumonListExpected.add(new SelectOption('仙台支店','仙台支店'));
        // bumonListExpected.add(new SelectOption('千葉支店','千葉支店'));
        // bumonListExpected.add(new SelectOption('名古屋支店','名古屋支店'));
        // bumonListExpected.add(new SelectOption('埼玉支店','埼玉支店'));
        // bumonListExpected.add(new SelectOption('大阪支店','大阪支店'));
        // bumonListExpected.add(new SelectOption('広島支店','広島支店'));
        // bumonListExpected.add(new SelectOption('新潟支店','新潟支店'));
        // bumonListExpected.add(new SelectOption('札幌支店','札幌支店'));
        // bumonListExpected.add(new SelectOption('東京支店','東京支店'));
        // bumonListExpected.add(new SelectOption('横浜支店','横浜支店'));
        // bumonListExpected.add(new SelectOption('水戸支店','水戸支店'));
        // bumonListExpected.add(new SelectOption('沖縄支店','沖縄支店'));
        // bumonListExpected.add(new SelectOption('法人営業部','法人営業部'));
        // bumonListExpected.add(new SelectOption('盛岡支店','盛岡支店'));
        // bumonListExpected.add(new SelectOption('神戸ヤード','神戸ヤード'));
        // bumonListExpected.add(new SelectOption('福岡支店','福岡支店'));
        // bumonListExpected.add(new SelectOption('販売部','販売部'));
        // bumonListExpected.add(new SelectOption('金沢支店','金沢支店'));
        // bumonListExpected.add(new SelectOption('長野支店','長野支店'));
        // bumonListExpected.add(new SelectOption('静岡支店','静岡支店'));
        // bumonListExpected.add(new SelectOption('高松支店','高松支店'));
        // bumonListExpected.add(new SelectOption('鳥取支店','鳥取支店'));
        // bumonListExpected.add(new SelectOption('鹿児島支店','鹿児島支店'));
        
        // System.assertEquals(bumonListExpected, alCtrl.getManageBumonList());
        System.assert(!alCtrl.getManageBumonList().isEmpty());

        Test.stopTest();
    }


    // 査定担当者リスト
    static testMethod void testAssetListGetTantoList() {

        // テスト用VFページ初期化
        initTestPage();
        setSearchConditionAsset();

        Test.startTest();

        alCtrl.condition.ManageBumon = new List<String>{'横浜支店'};

        List<SelectOption> tantoListExpected = new List<SelectOption>();
        tantoListExpected.add(new SelectOption('blank',''));
        tantoListExpected.add(new SelectOption('t-kuyama@vitals.co.jp','久山自動車'));

        System.assertEquals(tantoListExpected, alCtrl.getAssessTantoList());

        Test.stopTest();
    }


    // オフセット
    static testMethod void testAssetListGetOffset() {

        // テスト用VFページ初期化
        initTestPage();
        setSearchConditionAsset();

        Test.startTest();

        alCtrl.getOffset();

        Test.stopTest();
    }


    static testMethod void testAssetListPagenation() {
        
        // テスト用VFページ初期化
        initTestPage();

        // テスト開始
        Test.startTest();

        alCtrl.doFirst();
        alCtrl.doLast();
        alCtrl.doPrevious();
        alCtrl.doNext();

        alCtrl.pageNumber = 2;
        alCtrl.doMove();

        alCtrl.getPageSize();

        // テスト終了
        Test.stopTest();
    }




    static private void initTestPage() {
        // テストデータ作成
        tdf = new TestDataFactory();
        tdf.createAssessmentData();

        // VFページ作成（不要？）
        pageRef = Page.AssetList;
        Test.setCurrentPage(pageRef);

        // コントローラのインスタンス
        alCtrl = new AssetListController();
        alCtrl.init();
    }

    static private void initTestPage2001() {
        // テストデータ作成
        tdf = new TestDataFactory();
        tdf.createAssessmentData2001();

        // VFページ作成（不要？）
        pageRef = Page.AssetList;
        Test.setCurrentPage(pageRef);

        // コントローラのインスタンス
        alCtrl = new AssetListController();
        alCtrl.init();
    }


    static private void setSearchConditionAsset() {
        // 各検索項目に値をセット
        // 査定日（開始日）
        alCtrl.condition.AssessDateStart = '2019-05-08';
        // 査定日（終了日）
        alCtrl.condition.AssessDateEnd = '2019-05-08';
        // メーカー
        alCtrl.condition.Maker =  new List<String>{'3','ホンダ'};
        // 車種
        alCtrl.condition.Model =  new List<String>{'34124','シビック'};
        // 統括部門
        alCtrl.condition.ManageBumon =  new List<String>{'横浜支店','広島支店'};
        // 査定担当者
        alCtrl.condition.AssessTanto =  new List<String>{'t-kuyama@vitals.co.jp','はなまる次郎'};
    }


    static private void setSearchConditionAssetNull() {
        // 各検索項目に値をセット
        // 査定日（開始日）
        alCtrl.condition.AssessDateStart = '';
        // 査定日（終了日）
        alCtrl.condition.AssessDateEnd = '';
        // メーカー
        alCtrl.condition.Maker =  new List<String>{'blank'};
        // 車種
        alCtrl.condition.Model =  new List<String>{'blank'};
        // 統括部門
        alCtrl.condition.ManageBumon =  new List<String>{'blank'};
        // 査定担当者
        alCtrl.condition.AssessTanto =  new List<String>{'blank'};
    }
}