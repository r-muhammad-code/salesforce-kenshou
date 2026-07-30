@isTest
public class TestDataFactory {
    public TestDataFactory() {

    }

    private Account acc = createAccountData();
    private Mst_Makers__c mkr = createMakerData();
    private Mst_Models__c mdl = createModelData();
    // 中古車部（コミュニティ上位取引先）を作成 20210128
    private Account acc2 = createAccountData2();

    public static final String RECORD_TYPE_SALES = 'sales'; //レコードタイプ「営業」 20211027 HANA_SF_SATEI-205
    public static final String RECORD_TYPE_ID 
    = Schema.SObjectType.Assessment__c.getRecordTypeInfosByDeveloperName().get(RECORD_TYPE_SALES).getRecordTypeId(); //レコードタイプID  20211027 HANA_SF_SATEI-205


    /**
     * 取引先作成
     */
    public Account createAccountData(){
        Account sobj = new Account(
            Name = 'ヴァイタルインフォメーション株式会社',           // 取引先名
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
            CustomerCompass__CClongitude__c = null  // CClongitude
        );
        insert sobj;
        return sobj;
    }


    /**
     * 取引先責任者作成
     */
    public Contact createContactData(){
        Contact sobj = new Contact(
            LastName = '武',
            FirstName = '久山',
            Department = 'ソリューション営業部',  // 部署
            Retirement__c = false,      // 退職
            AccountId = acc.Id
        );
        insert sobj;
        return sobj;
    }

    /**
     * 査定ユーザ作成
     */
    public Mst_Assess_Users__c createAssessUser(){
        Mst_Assess_Users__c sobj = new Mst_Assess_Users__c(
            Name = '久山自動車',
            emp_kind__c = '1',
            manage_org__c = '横浜支店',
            sinjin_flg__c = false,
            login_user__c = 't-kuyama@vitals.co.jp',
            pass__c = 'kuyama',
            first_login_date__c = null,
            last_login_date__c = null
        );
        insert sobj;
        return sobj;
    }

    /**
     * 買取商談作成
     */
    public PurchaseOpportunity__c createPurchaseOppData(){
        PurchaseOpportunity__c sobj = new PurchaseOpportunity__c(
            OpportunityType__c = '既存',        // 商談種別
            Phase__c = '受付',      // フェーズ
            RequestDate__c = Date.newInstance(2018,6,5),      // 査定依頼日
            Account__c = acc.Id,      // 取引先
            Contact__c = createContactData().Id,      // 取引先担当者
            ModelYear__c = '2019'       // 年式
        );
        insert sobj;
        return sobj;
    }

    /**
     * メーカ作成
     */
    public Mst_Makers__c  createMakerData(){
        Mst_Makers__c sobj = new Mst_Makers__c(
            Name = 'トヨタ',        // メーカ名
            maker_name_eizi__c = 'TOYOTA',        // メーカー名（英語）
            maker__c = '1',        // メーカー（数字）
            row_num__c = 1,        // 表示順
            country__c = '1',        // 国種別（数字）
            country_name__c = '国産車',        // 国種別（文字）
            reserve1__c = null,        // 予備1
            reserve2__c = '',        // 予備2
            inum__c = '3'        // INUM
        );
        insert sobj;
        return sobj;
    }

    /**
     * 車種作成
     */
    public Mst_Models__c  createModelData(){
        Mst_Models__c sobj = new Mst_Models__c(
            Name = 'アクア',        // 車種名
            maker__c = mkr.Id,        // メーカ
            model_name_eizi__c = 'AQUA',        // 車種名英字
            maker_code__c = '1',        // メーカコード
            row_num__c = 150,        // 並び替え用
            disp_flg__c = '1',        // 表示区分
            reserve1__c = null,        // 予備1
            reserve2__c = '',        // 予備2
            inum__c = '34124'        // INUM
        );
        insert sobj;
        return sobj;
    }

    /**
     * グレード作成
     */
    public Mst_Grades__c createGradeData(){
        Mst_Grades__c sobj = new Mst_Grades__c(
            Name = 'G',        // グレード名
            inum__c = '123456',        // INUM
            maker__c = mkr.Id,        // メーカ
            maker_code__c = '1',        // メーカコード
            model__c = mdl.Id,        // 車種
            model_code__c = '34124',        // 車種コード
            row_num__c = 1,        // 並び替え用
            disp_flg__c = '1',        // 表示区分
            reserve1__c = null,        // 予備1
            reserve2__c = ''        // 予備2
        );
        insert sobj;
        return sobj;
    }

    /**
     * 型式作成
     */
    public Mst_Types__c  createTypeData(){
        Mst_Types__c sobj = new Mst_Types__c(
            Name = 'GH-450335',        // グレード名
            inum__c = '13725',        // INUM
            maker__c = mkr.Id,        // メーカ
            maker_code__c = '11',        // メーカコード
            model__c = mdl.Id,        // 車種
            model_code__c = '34124',        // 車種コード
            row_num__c = 1,        // 並び替え用
            disp_flg__c = '1',        // 表示区分
            reserve1__c = null,        // 予備1
            reserve2__c = ''        // 予備2
        );
        insert sobj;
        return sobj;
    }

    /**
     * 査定表作成
     */
    public Assessment__c  createAssessmentData(){
        Assessment__c sobj = new Assessment__c(
            account__c = acc.Id,        // 取引先
            SalesDataListing__c = '1',        //営業データ出品  20211028 HANA_SF_SATEI-205
            oppotunity__c = createPurchaseOppData().Id,        // 買取商談
            ai_use_umu__c = '0',        // AI判定使用有無
            sv_sync_date__c = DateTime.newInstance(2019,5,8,23,45,00),        // サーバ同期日時
            suspended_flg__c = true,        // 中断フラグ
            damage_other__c = '特になし',        // ダメ―ジその他

            store__c = '',        // 依頼店
            asses_date__c = DateTime.newInstance(2019,5,8,23,45,00),        // 査定年月日
            asses_tanto__c = createAssessUser().Id,        // 査定担当者
            asset_mngno__c = '20190509-001',        // 査定表管理No.
            car_number__c = '鳥取531 は125',        // ナンバー記入欄

            car_maker__c = mkr.Id,        // メーカ
            car_model__c = mdl.Id,        // 車種
            car_grade__c = createGradeData().Id,        // グレード
            car_type__c = createTypeData().Id,        // 型式
            registerdAtGengo__c = '2',        // 初年度登録（元号）
            registerdAtYear__c = '2001',        // 初年度登録（年）
            registerdAtMonth__c = '12',        // 初年度登録（月）
            engine_katasiki__c = '',        // エンジン形式
            seizo_nensiki__c = '',        // 製造年式
            color_changed__c = '0',        // 色替え
            full_katasiki__c = '',        // フル型式
            color_no__c = '2',        // カラーNo.
            color__c = '1',        // カラー

            front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555339.jpg',        // 正面URL
            right_front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736384/assessment/aqua_white/S__3555340.jpg',        // 右前URL
            left_front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736384/assessment/aqua_white/S__3555341.jpg',        // 左前URL
            left_back_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555342.jpg',        // 左後ろURL
            right_back_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555343.jpg',        // 右後ろURL
            shakensho_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1556254681/assessment/20190409_195300_000001/syakensyo.jpg'        // 車検証URL
        );
        insert sobj;
        return sobj;
    }

    /**
     * 査定表作成　（営業レコードタイプかつ「営業データ出品」項目選択無し）
     * 20211028 HANA_SF_SATEI-205
     */
    public Assessment__c  createAssessmentDataSalesNotSelected(){
        Assessment__c sobj = new Assessment__c(
            account__c = acc.Id,        // 取引先
            RecordTypeId = RECORD_TYPE_ID, //レコードタイプID  20211028 HANA_SF_SATEI-205
            SalesDataListing__c = null,        //営業データ出品  20211028 HANA_SF_SATEI-205

            oppotunity__c = createPurchaseOppData().Id,        // 買取商談
            ai_use_umu__c = '0',        // AI判定使用有無
            sv_sync_date__c = DateTime.newInstance(2019,5,8,23,45,00),        // サーバ同期日時
            suspended_flg__c = true,        // 中断フラグ
            damage_other__c = '特になし',        // ダメ―ジその他

            store__c = '',        // 依頼店
            asses_date__c = DateTime.newInstance(2019,5,8,23,45,00),        // 査定年月日
            asses_tanto__c = createAssessUser().Id,        // 査定担当者
            asset_mngno__c = '20190509-001',        // 査定表管理No.
            car_number__c = '鳥取531 は125',        // ナンバー記入欄

            car_maker__c = mkr.Id,        // メーカ
            car_model__c = mdl.Id,        // 車種
            car_grade__c = createGradeData().Id,        // グレード
            car_type__c = createTypeData().Id,        // 型式
            registerdAtGengo__c = '2',        // 初年度登録（元号）
            registerdAtYear__c = '2001',        // 初年度登録（年）
            registerdAtMonth__c = '12',        // 初年度登録（月）
            engine_katasiki__c = '',        // エンジン形式
            seizo_nensiki__c = '',        // 製造年式
            color_changed__c = '0',        // 色替え
            full_katasiki__c = '',        // フル型式
            color_no__c = '2',        // カラーNo.
            color__c = '1',        // カラー

            front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555339.jpg',        // 正面URL
            right_front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736384/assessment/aqua_white/S__3555340.jpg',        // 右前URL
            left_front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736384/assessment/aqua_white/S__3555341.jpg',        // 左前URL
            left_back_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555342.jpg',        // 左後ろURL
            right_back_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555343.jpg',        // 右後ろURL
            shakensho_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1556254681/assessment/20190409_195300_000001/syakensyo.jpg'        // 車検証URL
        );
        insert sobj;
        return sobj;
    }


    /**
     * 査定表1001件作成
     */
    public List<Assessment__c>  createAssessmentData2001(){
        Assessment__c sobj;
        List<Assessment__c> assList = new List<Assessment__c>();

        Id oppId = createPurchaseOppData().Id;
        Id assUserId = createAssessUser().Id;
        Id gradeId = createGradeData().Id;
        Id typeId = createTypeData().Id;

        for(Integer i=0; i<1001; i++){
            sobj = new Assessment__c(
                // account__c = acc.Id,        // 取引先
                // oppotunity__c = oppId,        // 買取商談
                // ai_use_umu__c = '0',        // AI判定使用有無
                // sv_sync_date__c = DateTime.newInstance(2019,5,8,23,45,00),        // サーバ同期日時
                // suspended_flg__c = true,        // 中断フラグ
                // damage_other__c = '特になし',        // ダメ―ジその他

                // store__c = '',        // 依頼店
                asses_date__c = DateTime.newInstance(2019,5,8,23,45,00),        // 査定年月日
                asses_tanto__c = assUserId,        // 査定担当者
                asset_mngno__c = '20190509' + String.valueOf(i)        // 査定表管理No.
                // car_number__c = '鳥取531 は125',        // ナンバー記入欄

                // car_maker__c = mkr.Id,        // メーカ
                // car_model__c = mdl.Id,        // 車種
                // car_grade__c = gradeId,        // グレード
                // car_type__c = typeId,        // 型式
                // registerdAtGengo__c = '2',        // 初年度登録（元号）
                // registerdAtYear__c = '2001',        // 初年度登録（年）
                // registerdAtMonth__c = '12',        // 初年度登録（月）
                // engine_katasiki__c = '',        // エンジン形式
                // seizo_nensiki__c = '',        // 製造年式
                // color_changed__c = '0',        // 色替え
                // full_katasiki__c = '',        // フル型式
                // color_no__c = '2',        // カラーNo.
                // color__c = '1',        // カラー

                // front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555339.jpg',        // 正面URL
                // right_front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736384/assessment/aqua_white/S__3555340.jpg',        // 右前URL
                // left_front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736384/assessment/aqua_white/S__3555341.jpg',        // 左前URL
                // left_back_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555342.jpg',        // 左後ろURL
                // right_back_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555343.jpg',        // 右後ろURL
                // shakensho_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1556254681/assessment/20190409_195300_000001/syakensyo.jpg'        // 車検証URL
            );
            assList.add(sobj);
        }
        insert assList;
        return assList;
    }


    /* 以下、Community（取引先査定表）関係 */

    /**
     * 取引先査定ユーザ作成
     */
    public Mst_Assess_Users__c createAccountAssessUser(Contact con){
        Mst_Assess_Users__c sobj = new Mst_Assess_Users__c(
            Name = 'ヴァイタル自動車販売店',
            emp_kind__c = '2',
            manage_org__c = '横浜支店',
            sinjin_flg__c = false,
            login_user__c = 'vital-t',
            pass__c = 'vital-t',
            first_login_date__c = null,
            last_login_date__c = null,
            assess_user_type__c = '通常ユーザ',
            contact__c = con.Id
        );
        insert sobj;
        return sobj;
    }

    /**
     * コミュニティユーザ作成
     */
    public User  createCommunityUser(Contact con){
        User user = new User(
            Email = 'community-test-dealer@test.hanamaru-test.co.jp'
            ,UserName = 'community-test-dealer@test.hanamaru-test.co.jp'
            ,FirstName = 'community'
            ,LastName = 'test'
            ,Alias = 'comtest'
            ,ContactId = con.Id
            ,PortalRole = 'Worker' // 'Worker', 'Manager', 'Executive'
            ,ProfileId = getCommunityProfile().Id
            ,EmailEncodingKey = 'ISO-2022-JP'
            ,LanguageLocaleKey = 'ja'
            ,LocaleSidKey = 'ja_JP'
            ,TimeZoneSidKey = 'Asia/Tokyo'
        );
        insert user;
        return user;
    }

    /*
     * プロファイル情報を取得する
     */
    public static Profile getCommunityProfile() {
        return [
            Select
                Id
            From
                Profile
            Where
                Name = 'カスタムCustomer Community Plus User'
            Limit 1
        ];
    }

    /**
     * 取引先査定表作成
     */
    public AccountAssessment__c  createAccountAssessmentData(Mst_Assess_Users__c assUser){
        AccountAssessment__c sobj = new AccountAssessment__c(
            account__c = acc.Id,        // 取引先
            oppotunity__c = createPurchaseOppData().Id,        // 買取商談
            ai_use_umu__c = '0',        // AI判定使用有無
            sv_sync_date__c = DateTime.newInstance(2019,5,8,23,45,00),        // サーバ同期日時
            suspended_flg__c = true,        // 中断フラグ
            damage_other__c = '特になし',        // ダメ―ジその他

            store__c = '',        // 依頼店
            asses_date__c = DateTime.newInstance(2019,5,8,23,45,00),        // 査定年月日
            asses_tanto__c = assUser.Id,        // 査定担当者
            asset_mngno__c = '20190509-001',        // 査定表管理No.
            car_number__c = '鳥取531 は125',        // ナンバー記入欄

            car_maker__c = mkr.Id,        // メーカ
            car_model__c = mdl.Id,        // 車種
            car_grade__c = createGradeData().Id,        // グレード
            car_type__c = createTypeData().Id,        // 型式
            registerdAtGengo__c = '2',        // 初年度登録（元号）
            registerdAtYear__c = '2001',        // 初年度登録（年）
            registerdAtMonth__c = '12',        // 初年度登録（月）
            engine_katasiki__c = '',        // エンジン形式
            seizo_nensiki__c = '',        // 製造年式
            color_changed__c = '0',        // 色替え
            full_katasiki__c = '',        // フル型式
            color_no__c = '2',        // カラーNo.
            color__c = '1',        // カラー

            front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555339.jpg',        // 正面URL
            right_front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736384/assessment/aqua_white/S__3555340.jpg',        // 右前URL
            left_front_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736384/assessment/aqua_white/S__3555341.jpg',        // 左前URL
            left_back_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555342.jpg',        // 左後ろURL
            right_back_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1557736385/assessment/aqua_white/S__3555343.jpg',        // 右後ろURL
            shakensho_url__c = 'https://res.cloudinary.com/haga99oyi/image/upload/v1556254681/assessment/20190409_195300_000001/syakensyo.jpg'        // 車検証URL
        );
        insert sobj;
        return sobj;
    }


    /**
     * 中古車部（コミュニティ上位取引先）作成
     */
    public Account createAccountData2(){
        Account sobj = new Account(
            Name = 'ヴァイタル株式会社中古車部',           // 取引先名
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
            CustomerCompass__CClongitude__c = null  // CClongitude
        );
        insert sobj;
        return sobj;
    }

    /**
     * 中古車部（コミュニティ上位取引先）作成
     */
//    public void createExAccountHierarchy(Account acc2){
        // 中古車部（上位）
        // ExternalAccountHierarchy h1 = new ExternalAccountHierarchy(
        //     AccountId = acc2.Id,
        //     Name = '中古車部',
        //     IsActive = true,
        //     HierarchyType = '顧客'
        // );
        // insert h1;
//    }


    /**
     * ディーラの上位取引先に中古車部をひもつけ
     */
    public void relAcc(Account acc2){
        acc.CommunityTopBusinessAccount__c = acc2.Id;
        update acc;
    }

    /**
     * 中古車部　取引先責任者作成
     */
    public Contact createContactData2(Account acc2){
        Contact sobj = new Contact(
            LastName = '雄一',
            FirstName = '河野',
            Department = 'ソリューション営業部',  // 部署
            Retirement__c = false,      // 退職
            AccountId = acc2.Id
        );
        insert sobj;
        return sobj;
    }


    /**
     * コミュニティユーザ作成
     */
    public User  createCommunityUser2(Contact con2){
        User user = new User(
            Email = 'community-test2-cyukosyabu@test.hanamaru-test.co.jp'
            ,UserName = 'community-test2-cyukosyabu@test.hanamaru-test.co.jp'
            ,FirstName = 'community2'
            ,LastName = 'test2'
            ,Alias = 'comtest2'
            ,ContactId = con2.Id
            ,PortalRole = 'Worker' // 'Worker', 'Manager', 'Executive'
            ,ProfileId = getCommunityProfile().Id
            ,EmailEncodingKey = 'ISO-2022-JP'
            ,LanguageLocaleKey = 'ja'
            ,LocaleSidKey = 'ja_JP'
            ,TimeZoneSidKey = 'Asia/Tokyo'
        );
        insert user;
        return user;
    }

    /**
     * 中古車部に通知先担当者を設定
     */
    public void relAccNotifier(Account acc2, User comUser2){
        acc2.Notifier__c = comUser2.Id;
        update acc2;
    }

}