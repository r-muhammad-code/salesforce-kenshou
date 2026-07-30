public without sharing class AssessmentDetailHelper {

    AssetCommonUtility util = new AssetCommonUtility();

    // コンストラクタ
    public AssessmentDetailHelper() {
    }

    /*
     * オークションサイトへ送信する査定表情報のJSONを作成する
     */
    public String createAssJson(Assessment__c ass){

        String joinedTokki = getJoinTokki(ass);
        JSONGenerator gen = JSON.createGenerator(true);

        // 開始マーカー
        gen.writeStartObject();

        writeStringField2(gen, 'Name', ass.Name);        // 査定表名

        writeStringField2(gen, 'account__c', ass.account__r.Name);        // ★取引先名
        writeStringField2(gen, 'SalesDataListing__c', ass.SalesDataListing__c);       //営業データ出品  20211027 HANA_SF_SATEI-205 


        writeStringField2(gen, 'store__c', ass.store__c);        // 依頼店
        writeStringField2(gen, 'yard_kbn__c', ass.yard_kbn__c);         //ヤード区分　pj2451033 追加
        writeStringField2(gen, 'LotNo_yard__c', ass.LotNo_yard__c);        // ロットNo　20220525 HANA_SF_SATEI-223
        writeStringField2(gen, 'ana_tacho__c', ass.ana_tacho__c);        // アナタコ
        writeStringField2(gen, 'car_number__c', ass.car_number__c);        // ナンバー記入欄

        writeStringField2(gen, 'asses_tanto__c', ass.asses_tanto__r.Name);        // ★査定担当者名

        writeStringField2(gen, 'maker__c', ass.car_maker__r.maker__c);        // ★メーカー（数字）
        writeStringField2(gen, 'car_maker__c', ass.car_maker__r.Name);        // ★メーカ名
        writeStringField2(gen, 'maker_name_eizi__c', ass.car_maker__r.maker_name_eizi__c);        // ★メーカー名（英語）

        writeStringField2(gen, 'model_inum__c', ass.car_model__r.inum__c);        // ★車種（INUM）
        writeStringField2(gen, 'car_model__c', ass.car_model__r.Name);        // ★車種名
        writeStringField2(gen, 'model_name_eizi__c', ass.car_model__r.model_name_eizi__c);        // ★車種名英字

        // writeStringField2(gen, 'grade_inum__c', ass.car_grade__r.inum__c);        // ★グレード（INUM）
        // writeStringField2(gen, 'car_grade__c', ass.car_grade__r.Name);        // ★グレード名
        // writeStringField2(gen, 'grade_name_en__c', ass.car_grade__r.name_en__c);        // ★グレード名英字

        writeStringField2(gen, 'damage_other__c', ass.damage_other__c);        // ダメ―ジその他
        writeStringField2(gen, 'registerdAtYear__c', ass.registerdAtYear__c);        // 初年度登録（年）
        // writeStringField2(gen, 'registerdAtMonth__c', ass.registerdAtMonth__c);        // 初年度登録（月）
        // writeStringField2(gen, 'engine_katasiki__c', ass.engine_katasiki__c);        // エンジン形式
        writeStringField2(gen, 'seizo_nensiki__c', ass.seizo_nensiki__c);        // 製造年式

        writeStringField2(gen, 'color_no__c', ass.color_no__c);        // カラーNo.
        writeStringField2(gen, 'color__c', (String)ass.get('color__c_label'));        // ★カラー（ラベル）
        writeStringField2(gen, 'color_eizi__c', util.getTranslation(ass.color__c, 'color__c', Constants.LANG_ENGLISH));        // ★★カラー（英語）

        writeStringField2(gen, 'handle__c', ass.handle__c);        // ハンドル 20210823追加

        writeStringField2(gen, 'shift__c', (String)ass.get('shift__c_label'));        // ★シフト（ラベル）

        // writeStringField2(gen, 'katasiki_sitei_no__c', ass.katasiki_sitei_no__c);        // 型式指定番号
        writeStringField2(gen, 'room_url__c', ass.room_url__c);        // 室内URL
        writeStringField2(gen, 'key__c', ass.key__c);        // アナタコカギ
        writeStringField2(gen, 'seizo_getu__c', ass.seizo_getu__c);        // 製造年式（月）
        // writeStringField2(gen, 'rui_kbn_no__c', ass.rui_kbn_no__c);        // 類別区分番号
        writeNumberField2(gen, 'run_dist__c', ass.run_dist__c);        // 走行距離
        writeStringField2(gen, 'run_dist_unit__c', ass.run_dist_unit__c);        // 走行距離単位
        writeStringField2(gen, 'run_kakunin__c', ass.run_kakunin__c);        // 実走確認
        // writeNumberField2(gen, 'haiki_ryo__c', ass.haiki_ryo__c);        // 排気量（CC）
        // writeStringField2(gen, 'meter_disp__c', ass.meter_disp__c);        // メーター表示
        // writeStringField2(gen, 'fuel__c', ass.fuel__c);        // 燃料
        writeStringField2(gen, 'fuel_ohter__c', ass.fuel_ohter__c);        // 燃料その他
        //writeNumberField2(gen, 'teiin__c', ass.teiin__c);        // 定員
        writeStringField2(gen, 'okiba__c', ass.okiba__c);        // 置場（自由入力）
//        writeStringField2(gen, 'okiba_select__c', ass.okiba_select__c);        // 置場
        writeStringField2(gen, 'okiba_select__c', (String)ass.get('okiba_select__c_label'));        // ★置場（ラベル）
        writeStringField2(gen, 'shaken_inf__c', ass.shaken_inf__c);        // 車検情報
        writeStringField2(gen, 'shaken_nen__c', ass.shaken_nen__c);        // 車検付き年
        writeStringField2(gen, 'shaken_getu__c', ass.shaken_getu__c);        // 車検付き月
        writeStringField2(gen, 'jiso__c', ass.jiso__c);        // 自走
        writeStringField2(gen, 'kudo__c', ass.kudo__c);        // 駆動
        writeStringField2(gen, 'engine_url__c', ass.engine_url__c);        // エンジンルームURL

        writeStringField2(gen, 'UsedcarEvaluationpoints__c', ass.UsedcarEvaluationpoints__c);        // 中古車査定時評価点 20210823追加
        writeStringField2(gen, 'UsedcarInnerEvaluationpoints__c', ass.UsedcarInnerEvaluationpoints__c);        // 中古車査定時内装評価点 20210823追加

        writeStringField2(gen, 'damage__c', (String)ass.get('damage__c_label'));        // ★ダメージ（ラベル）
        writeStringField2(gen, 'damage_eizi__c', util.getTranslatedMulti(ass.damage__c, 'damage__c', Constants.LANG_ENGLISH));        // ★★ダメージ（英語）
        writeStringField2(gen, 'damage_russian__c', util.getTranslatedMulti(ass.damage__c, 'damage__c', Constants.LANG_RUSSIAN));        // ★★ダメージ（ロシア語）

        writeStringField2(gen, 'cell__c', ass.cell__c);        // セル
        writeStringField2(gen, 'engine__c', ass.engine__c);        // エンジン
        writeStringField2(gen, 'engine_back__c', ass.engine_back__c);        // エンジン後退
        writeStringField2(gen, 'engine_ng__c', ass.engine_ng__c);        // エンジンNG
        writeStringField2(gen, 'mission__c', ass.mission__c);        // ミッション
        writeStringField2(gen, 'radiator__c', ass.radiator__c);        // ラジエター
        writeStringField2(gen, 'condenser__c', ass.condenser__c);        // コンデンサー
        writeStringField2(gen, 'rent_register__c', ass.rent_register__c);        // レンタ登録
        writeStringField2(gen, 'owner_right__c', ass.owner_right__c);        // 所有権
        writeStringField2(gen, 'zansai__c', ass.zansai__c);        // 残債
        writeStringField2(gen, 'inner_dust__c', ass.inner_dust__c);        // 室内ゴミ

        writeStringField2(gen, 'shanai_tumikomi_parts__c', getShanaiTumikomiParts(ass.shanai_tumikomi_parts__c));        // ★社内積込パーツ（ラベル）

        writeStringField2(gen, 'tanto_manage_bumon__c', ass.tanto_manage_bumon__c);        // 統括部門
        writeStringField2(gen, 'sobi_seat__c', ass.sobi_seat__c);        // シート
        writeStringField2(gen, 'cotion_url__c', ass.cotion_url__c);        // コーションURL
        writeStringField2(gen, 'key_url__c', ass.key_url__c);        // カギURL
        writeStringField2(gen, 'meter_url__c', ass.meter_url__c);        // メーターURL  
        writeStringField2(gen, 'steering_url__c', ass.steering_url__c);        // ステアリングURL  pj2451033　追加
        writeStringField2(gen, 'center_console_url__c', ass.center_console_url__c);        // センターコンソールURL  pj2451033　追加
        writeStringField2(gen, 'front_seat_url__c', ass.front_seat_url__c);        // 前席シートURL  pj2451033　追加
        writeStringField2(gen, 'switch1_url__c', ass.switch1_url__c);        // スイッチ類➀URL  pj2451033　追加
        writeStringField2(gen, 'switch2_url__c', ass.switch2_url__c);        // スイッチ類➁URL  pj2451033　追加
        
        writeStringField2(gen, 'other_url_01__c', ass.other_url_01__c);        // その他URL1
        writeStringField2(gen, 'other_url_02__c', ass.other_url_02__c);        // その他URL2
        writeStringField2(gen, 'other_url_03__c', ass.other_url_03__c);        // その他URL3

        writeStringField2(gen, 'sobi_pawer_slide_door_right__c', getSobiPawerSlideDoor(ass.sobi_pawer_slide_door_right__c));        // ★パワースライドドア右

        writeStringField2(gen, 'sobi_navi_select__c', ass.sobi_navi_select__c);        // ナビ
        writeStringField2(gen, 'sobi_navi_other__c', ass.sobi_navi_other__c);        // ナビその他
        writeStringField2(gen, 'absb_driver__c', ass.absb_driver__c);        // 運転席
        writeStringField2(gen, 'absb_sub__c', ass.absb_sub__c);        // 助手席
        writeStringField2(gen, 'absb_side_right__c', ass.absb_side_right__c);        // サイド右
        writeStringField2(gen, 'absb_side_left__c', ass.absb_side_left__c);        // サイド左
        writeStringField2(gen, 'absb_driver_knee__c', ass.absb_driver_knee__c);        // 運転席ニー
        writeStringField2(gen, 'absb_sub_knee__c', ass.absb_sub_knee__c);        // 助手席ニー
        writeStringField2(gen, 'absb_curtain_right__c', ass.absb_curtain_right__c);        // カーテン右
        writeStringField2(gen, 'absb_curtain_left__c', ass.absb_curtain_left__c);        // カーテン左
        writeStringField2(gen, 'absb_driver_seat__c', ass.absb_driver_seat__c);        // 運転席シート
        writeStringField2(gen, 'absb_sub_seat__c', ass.absb_sub_seat__c);        // 助手席シート
        writeStringField2(gen, 'absb_airbag_right_back__c', ass.absb_airbag_right_back__c);        // 後部座席右エアバッグ 20210823追加
        writeStringField2(gen, 'absb_airbag_left_back__c', ass.absb_airbag_left_back__c);        // 後部座席左エアバッグ 20210823追加
        writeStringField2(gen, 'absb_belt_right__c', ass.absb_belt_right__c);        // シートベルト右
        writeStringField2(gen, 'absb_belt_right_back__c', ass.absb_belt_right_back__c);        // 後部座席シートベルト右 20210823追加
        writeStringField2(gen, 'absb_belt_left__c', ass.absb_belt_left__c);        // シートベルト左
        writeStringField2(gen, 'absb_belt_left_back__c', ass.absb_belt_left_back__c);        // 後部座席シートベルト左 20210823追加
        writeStringField2(gen, 'absb_active_headrest__c', ass.absb_active_headrest__c);        // アクティブヘッドレスト 20210823追加
        writeStringField2(gen, 'absb_popup_hood__c', ass.absb_popup_hood__c);        // ポップアップフード 20210823追加
        writeStringField2(gen, 'asset_mngno__c', ass.asset_mngno__c);        // 査定表管理No.
        writeStringField2(gen, 'seizo_nen__c', ass.seizo_nen__c);        // 製造年式（年）

        writeStringField2(gen, 'oppotunity__c', ass.oppotunity__r.Name);        // ★買取商談
        writeStringField2(gen, 'type_inum__c', ass.oppotunity__r.Mst_Types__r.inum__c);             // 型式（INUM）　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'car_type__c', ass.oppotunity__r.Mst_Types__r.Name);             // 型式名　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'engine_form__c', ass.oppotunity__r.engine_form__c);             // エンジン型式　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'form_num__c', ass.oppotunity__r.form_num__c);             // 型式指定番号　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'bunrui_num__c', ass.oppotunity__r.bunrui_num__c);             // 類別区分番号　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'CarNo__c', ass.oppotunity__r.CarNo__c);             // 車台番号　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'run_contents__c', ass.oppotunity__r.run_contents__c);             // メーター状態　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'ModelYearPickList__c', (ass.oppotunity__r.ModelYearPickList__c == '不明' ? NULL : ass.oppotunity__r.ModelYearPickList__c ));             // 年式　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'First_year_registration__c', ass.oppotunity__r.First_year_registration__c);             // 初年度登録月　  HANA_SF_SATEI-272　20241115追加
        writeBooleanField2(gen, 'Except_First_year_registration__c', ass.oppotunity__r.Except_First_year_registration__c);             // 初年度月除外　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'fuel__c', ass.oppotunity__r.fuel__c);             // 燃料　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'teiin__c', ass.oppotunity__r.teiin__c);             // 定員　  HANA_SF_SATEI-272　20241115追加
        writeNumberField2(gen, 'dis_volume__c', ass.oppotunity__r.dis_volume__c);             // 排気量　  HANA_SF_SATEI-272　20241115追加
        writeNumberField2(gen, 'vehicle_length__c', ass.oppotunity__r.vehicle_length__c);             // 長さ　  HANA_SF_SATEI-272　20241115追加
        writeNumberField2(gen, 'vehicle_width__c', ass.oppotunity__r.vehicle_width__c);             // 幅　  HANA_SF_SATEI-272　20241115追加
        writeNumberField2(gen, 'vehicle_height__c', ass.oppotunity__r.vehicle_height__c);             // 高さ　  HANA_SF_SATEI-272　20241115追加
        writeNumberField2(gen, 'vehicle_weight__c', ass.oppotunity__r.vehicle_weight__c);             // 車輌重量　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'shaken_erase_year__c', ass.oppotunity__r.shaken_erase_year__c);             // 車検期限年　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'shaken_erase_month__c', ass.oppotunity__r.shaken_erase_month__c);             // 車検期限月　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'grade_inum__c', ass.oppotunity__r.Mst_Grades__r.inum__c);             // グレード（INUM）　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'car_grade__c', ass.oppotunity__r.Mst_Grades__r.Name);             // グレード名　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'OpportunityID_18__c', ass.oppotunity__r.OpportunityID_18__c);             // 買取商談ID（18ケタ）　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'exhibit_memo__c', ass.oppotunity__r.exhibit_memo__c);             // 注意事項　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'alert_memo__c', ass.oppotunity__r.alert_memo__c);             // 警告設定　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'setting_content__c', ass.oppotunity__r.setting_content__c);             // 取・メン・保・スペア　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'auc_area__c', ass.oppotunity__r.auc_area__c);             // 出品先　  HANA_SF_SATEI-272　20241115追加
        writeNumberField2(gen, 'nyu_price__c', ass.oppotunity__r.nyu_price__c);             // 入札希望価格　  HANA_SF_SATEI-272　20241115追加
        writeNumberField2(gen, 'expected_price__c', ass.oppotunity__r.expected_price__c);             // 仕入希望価格　  HANA_SF_SATEI-272　20241115追加
        writeNumberField2(gen, 'auc_sprice__c', ass.oppotunity__r.auc_sprice__c);             // ライブ開始価格　  HANA_SF_SATEI-272　20241115追加
        writeStringField2(gen, 'Vehicle_Gross_Weight__c', ass.oppotunity__r.Vehicle_Gross_Weight__c);             // 車輌総重量
        writeStringField2(gen, 'maximum_payload__c', ass.oppotunity__r.maximum_payload__c);             // 最大積載量

        writeStringField2(gen, 'manage_bumon__c', ass.manage_bumon__c);        // 統括部門(テキスト)
        writeStringField2(gen, 'ai_use_umu__c', ass.ai_use_umu__c);        // AI判定使用有無
        writeDateTimeField2(gen, 'sv_sync_date__c', ass.sv_sync_date__c);        // サーバ同期日時
        writeDateTimeField2(gen, 'asses_date__c', ass.asses_date__c);        // 査定年月日

        // writeStringField2(gen, 'car_type__c', ass.car_type__r.Name);        // ★型式
        // writeStringField2(gen, 'type_inum__c', ass.car_type__r.inum__c);     // ★型式（INUM）

        writeStringField2(gen, 'full_katasiki__c', ass.full_katasiki__c);        // フル型式
        writeStringField2(gen, 'shadai_no__c', ass.shadai_no__c);        // 車台番号
        writeStringField2(gen, 'turbo__c', ass.turbo__c);        // ターボ
        writeStringField2(gen, 'color_changed__c', ass.color_changed__c);        // 色替え
        writeStringField2(gen, 'no_lift_use__c', ass.no_lift_use__c);        // リフト使用なし
        writeStringField2(gen, 'manual__c', ass.manual__c);        // 取説
        writeStringField2(gen, 'reserve1__c', ass.reserve1__c);        // 保証書
        writeStringField2(gen, 'dmg_pillar_right_A__c', ass.dmg_pillar_right_A__c);        // ピラー右A
        writeStringField2(gen, 'sobi_aw__c', ass.sobi_aw__c);        // AW
        writeStringField2(gen, 'sobi_sunloof__c', ass.sobi_sunloof__c);        // サンルーフ
        writeStringField2(gen, 'sobi_tv__c', ass.sobi_tv__c);        // TV
        writeStringField2(gen, 'sobi_navi__c', ass.sobi_navi__c);        // NAVI
        writeStringField2(gen, 'sobi_ps__c', ass.sobi_ps__c);        // PS
        writeStringField2(gen, 'sobi_pw__c', ass.sobi_pw__c);        // PW
        writeStringField2(gen, 'sobi_ac__c', ass.sobi_ac__c);        // A/C 20210823追加

        writeStringField2(gen, 'sobi_pawer_slide_door_left__c', getSobiPawerSlideDoor(ass.sobi_pawer_slide_door_left__c));        // パワースライドドア左

        writeStringField2(gen, 'dmg_front_glass__c', ass.dmg_front_glass__c);        // フロントガラス
        writeStringField2(gen, 'dmg_front_glass_y__c', ass.dmg_front_glass_y__c);        // フロントガラス座標Y
        writeStringField2(gen, 'dmg_front_glass_x__c', ass.dmg_front_glass_x__c);        // フロントガラス座標X
        writeStringField2(gen, 'dmg_front_glass_height__c', ass.dmg_front_glass_height__c);        // フロントガラス座標高さ
        writeStringField2(gen, 'dmg_front_glass_width__c', ass.dmg_front_glass_width__c);        // フロントガラス座標横幅
        writeStringField2(gen, 'dmg_front_glass_reason__c', ass.dmg_front_glass_reason__c);        // フロントガラス再学習理由
        writeStringField2(gen, 'dmg_front_bumper__c', ass.dmg_front_bumper__c);        // フロントバンパー
        writeStringField2(gen, 'dmg_front_bumper_y__c', ass.dmg_front_bumper_y__c);        // フロントバンパー座標Y
        writeStringField2(gen, 'dmg_front_bumper_x__c', ass.dmg_front_bumper_x__c);        // フロントバンパー座標X
        writeStringField2(gen, 'dmg_front_bumper_height__c', ass.dmg_front_bumper_height__c);        // フロントバンパー座標高さ
        writeStringField2(gen, 'dmg_front_bumper_width__c', ass.dmg_front_bumper_width__c);        // フロントバンパー座標横幅
        writeStringField2(gen, 'dmg_front_bumper_reason__c', ass.dmg_front_bumper_reason__c);        // フロントバンパー再学習理由
        writeStringField2(gen, 'dmg_bonnet__c', ass.dmg_bonnet__c);        // ボンネット
        writeStringField2(gen, 'dmg_bonnet_y__c', ass.dmg_bonnet_y__c);        // ボンネット座標Y
        writeStringField2(gen, 'dmg_bonnet_x__c', ass.dmg_bonnet_x__c);        // ボンネット座標X
        writeStringField2(gen, 'dmg_bonnet_height__c', ass.dmg_bonnet_height__c);        // ボンネット座標高さ
        writeStringField2(gen, 'dmg_bonnet_width__c', ass.dmg_bonnet_width__c);        // ボンネット座標横幅
        writeStringField2(gen, 'dmg_bonnet_reason__c', ass.dmg_bonnet_reason__c);        // ボンネット再学習理由
        writeStringField2(gen, 'dmg_loof_glass__c', ass.dmg_loof_glass__c);        // ルーフガラス
        writeStringField2(gen, 'dmg_rear_glass__c', ass.dmg_rear_glass__c);        // リアガラス
        writeStringField2(gen, 'dmg_rear_glass_y__c', ass.dmg_rear_glass_y__c);        // リアガラス座標Y
        writeStringField2(gen, 'dmg_rear_glass_x__c', ass.dmg_rear_glass_x__c);        // リアガラス座標X
        writeStringField2(gen, 'dmg_rear_glass_height__c', ass.dmg_rear_glass_height__c);        // リアガラス座標高さ
        writeStringField2(gen, 'dmg_rear_glass_width__c', ass.dmg_rear_glass_width__c);        // リアガラス座標横幅
        writeStringField2(gen, 'dmg_rear_glass_reason__c', ass.dmg_rear_glass_reason__c);        // リアガラス再学習理由
        writeStringField2(gen, 'dmg_rear_bumper__c', ass.dmg_rear_bumper__c);        // リアバンパー
        writeStringField2(gen, 'dmg_rear_bumper_y__c', ass.dmg_rear_bumper_y__c);        // リアバンパー座標Y
        writeStringField2(gen, 'dmg_rear_bumper_x__c', ass.dmg_rear_bumper_x__c);        // リアバンパー座標X
        writeStringField2(gen, 'dmg_rear_bumper_height__c', ass.dmg_rear_bumper_height__c);        // リアバンパー座標高さ
        writeStringField2(gen, 'dmg_rear_bumper_width__c', ass.dmg_rear_bumper_width__c);        // リアバンパー座標横幅
        writeStringField2(gen, 'dmg_rear_bumper_reason__c', ass.dmg_rear_bumper_reason__c);        // リアバンパー再学習理由
        writeStringField2(gen, 'dmg_trunk__c', ass.dmg_trunk__c);        // トランク／リアゲート
        writeStringField2(gen, 'dmg_trunk_y__c', ass.dmg_trunk_y__c);        // トランク／リアゲート座標Y
        writeStringField2(gen, 'dmg_trunk_x__c', ass.dmg_trunk_x__c);        // トランク／リアゲート座標X
        writeStringField2(gen, 'dmg_trunk_height__c', ass.dmg_trunk_height__c);        // トランク／リアゲート座標高さ
        writeStringField2(gen, 'dmg_trunk_width__c', ass.dmg_trunk_width__c);        // トランク／リアゲート座標横幅
        writeStringField2(gen, 'dmg_trunk_reason__c', ass.dmg_trunk_reason__c);        // トランク／リアゲート再学習理由
        writeStringField2(gen, 'dmg_dash_panel__c', ass.dmg_dash_panel__c);        // ダッシュパネル
        writeStringField2(gen, 'dmg_back_panel__c', ass.dmg_back_panel__c);        // バックパネル
        writeStringField2(gen, 'dmg_room_floor__c', ass.dmg_room_floor__c);        // ルームフロア
        writeStringField2(gen, 'dmg_trunc_floor__c', ass.dmg_trunc_floor__c);        // トランクフロア
        writeStringField2(gen, 'dmg_head_light_right__c', ass.dmg_head_light_right__c);        // ヘッドライト右
        writeStringField2(gen, 'dmg_head_light_right_y__c', ass.dmg_head_light_right_y__c);        // ヘッドライト右座標Y
        writeStringField2(gen, 'dmg_head_light_right_x__c', ass.dmg_head_light_right_x__c);        // ヘッドライト右座標X
        writeStringField2(gen, 'dmg_head_light_right_height__c', ass.dmg_head_light_right_height__c);        // ヘッドライト右座標高さ
        writeStringField2(gen, 'dmg_head_light_right_width__c', ass.dmg_head_light_right_width__c);        // ヘッドライト右座標横幅
        writeStringField2(gen, 'dmg_head_light_right_reason__c', ass.dmg_head_light_right_reason__c);        // ヘッドライト右再学習理由
        writeStringField2(gen, 'dmg_fender_right_front__c', ass.dmg_fender_right_front__c);        // フェンダー右前
        writeStringField2(gen, 'dmg_fender_right_front_y__c', ass.dmg_fender_right_front_y__c);        // フェンダー右前座標Y
        writeStringField2(gen, 'dmg_fender_right_front_x__c', ass.dmg_fender_right_front_x__c);        // フェンダー右前座標X
        writeStringField2(gen, 'dmg_fender_right_front_height__c', ass.dmg_fender_right_front_height__c);        // フェンダー右前座標高さ
        writeStringField2(gen, 'dmg_fender_right_front_width__c', ass.dmg_fender_right_front_width__c);        // フェンダー右前座標横幅
        writeStringField2(gen, 'dmg_fender_right_front_reason__c', ass.dmg_fender_right_front_reason__c);        // フェンダー右前再学習理由
        writeStringField2(gen, 'dmg_fender_right_back__c', ass.dmg_fender_right_back__c);        // フェンダー右後
        writeStringField2(gen, 'dmg_fender_right_back_y__c', ass.dmg_fender_right_back_y__c);        // フェンダー右後座標Y
        writeStringField2(gen, 'dmg_fender_right_back_x__c', ass.dmg_fender_right_back_x__c);        // フェンダー右後座標X
        writeStringField2(gen, 'dmg_fender_right_back_height__c', ass.dmg_fender_right_back_height__c);        // フェンダー右後座標高さ
        writeStringField2(gen, 'dmg_fender_right_back_width__c', ass.dmg_fender_right_back_width__c);        // フェンダー右後座標横幅
        writeStringField2(gen, 'dmg_fender_right_back_reason__c', ass.dmg_fender_right_back_reason__c);        // フェンダー右後再学習理由
        writeStringField2(gen, 'dmg_door_right_front__c', ass.dmg_door_right_front__c);        // ドア右前
        writeStringField2(gen, 'dmg_door_right_front_y__c', ass.dmg_door_right_front_y__c);        // ドア右前座標Y
        writeStringField2(gen, 'dmg_door_right_front_x__c', ass.dmg_door_right_front_x__c);        // ドア右前座標X
        writeStringField2(gen, 'dmg_door_right_front_height__c', ass.dmg_door_right_front_height__c);        // ドア右前座標高さ
        writeStringField2(gen, 'dmg_door_right_front_width__c', ass.dmg_door_right_front_width__c);        // ドア右前座標横幅
        writeStringField2(gen, 'dmg_door_right_front_reason__c', ass.dmg_door_right_front_reason__c);        // ドア右前再学習理由
        writeStringField2(gen, 'dmg_door_right_back__c', ass.dmg_door_right_back__c);        // ドア右後
        writeStringField2(gen, 'dmg_door_right_back_y__c', ass.dmg_door_right_back_y__c);        // ドア右後座標Y
        writeStringField2(gen, 'dmg_door_right_back_x__c', ass.dmg_door_right_back_x__c);        // ドア右後座標X
        writeStringField2(gen, 'dmg_door_right_back_height__c', ass.dmg_door_right_back_height__c);        // ドア右後座標高さ
        writeStringField2(gen, 'dmg_door_right_back_width__c', ass.dmg_door_right_back_width__c);        // ドア右後座標横幅
        writeStringField2(gen, 'dmg_door_right_back_reason__c', ass.dmg_door_right_back_reason__c);        // ドア右後再学習理由
        writeStringField2(gen, 'dmg_side_step_right__c', ass.dmg_side_step_right__c);        // サイドステップ右
        writeStringField2(gen, 'dmg_front_side_mem_right__c', ass.dmg_front_side_mem_right__c);        // フロントサイドメンバー右
        writeStringField2(gen, 'dmg_rear_side_mem_right__c', ass.dmg_rear_side_mem_right__c);        // リアサイドメンバー右
        writeStringField2(gen, 'dmg_head_light_left__c', ass.dmg_head_light_left__c);        // ヘッドライト左
        writeStringField2(gen, 'dmg_head_light_left_y__c', ass.dmg_head_light_left_y__c);        // ヘッドライト左座標Y
        writeStringField2(gen, 'dmg_head_light_left_x__c', ass.dmg_head_light_left_x__c);        // ヘッドライト左座標X
        writeStringField2(gen, 'dmg_head_light_left_height__c', ass.dmg_head_light_left_height__c);        // ヘッドライト左座標高さ
        writeStringField2(gen, 'dmg_head_light_left_width__c', ass.dmg_head_light_left_width__c);        // ヘッドライト左座標横幅
        writeStringField2(gen, 'dmg_head_light_left_reason__c', ass.dmg_head_light_left_reason__c);        // ヘッドライト左再学習理由
        writeStringField2(gen, 'dmg_fender_left_front__c', ass.dmg_fender_left_front__c);        // フェンダー左前
        writeStringField2(gen, 'dmg_fender_left_front_y__c', ass.dmg_fender_left_front_y__c);        // フェンダー左前座標Y
        writeStringField2(gen, 'dmg_fender_left_front_x__c', ass.dmg_fender_left_front_x__c);        // フェンダー左前座標X
        writeStringField2(gen, 'dmg_fender_left_front_height__c', ass.dmg_fender_left_front_height__c);        // フェンダー左前座標高さ
        writeStringField2(gen, 'dmg_fender_left_front_width__c', ass.dmg_fender_left_front_width__c);        // フェンダー左前座標横幅
        writeStringField2(gen, 'dmg_fender_left_front_reason__c', ass.dmg_fender_left_front_reason__c);        // フェンダー左前再学習理由
        writeStringField2(gen, 'dmg_fender_left_back__c', ass.dmg_fender_left_back__c);        // フェンダー左後
        writeStringField2(gen, 'dmg_fender_left_back_y__c', ass.dmg_fender_left_back_y__c);        // フェンダー左後座標Y
        writeStringField2(gen, 'dmg_fender_left_back_x__c', ass.dmg_fender_left_back_x__c);        // フェンダー左後座標X
        writeStringField2(gen, 'dmg_fender_left_back_height__c', ass.dmg_fender_left_back_height__c);        // フェンダー左後座標高さ
        writeStringField2(gen, 'dmg_fender_left_back_width__c', ass.dmg_fender_left_back_width__c);        // フェンダー左後座標横幅
        writeStringField2(gen, 'dmg_fender_left_back_reason__c', ass.dmg_fender_left_back_reason__c);        // フェンダー左後再学習理由
        writeStringField2(gen, 'dmg_door_left_front__c', ass.dmg_door_left_front__c);        // ドア左前
        writeStringField2(gen, 'dmg_door_left_front_y__c', ass.dmg_door_left_front_y__c);        // ドア左前座標Y
        writeStringField2(gen, 'dmg_door_left_front_x__c', ass.dmg_door_left_front_x__c);        // ドア左前座標X
        writeStringField2(gen, 'dmg_door_left_front_height__c', ass.dmg_door_left_front_height__c);        // ドア左前座標高さ
        writeStringField2(gen, 'dmg_door_left_front_width__c', ass.dmg_door_left_front_width__c);        // ドア左前座標横幅
        writeStringField2(gen, 'dmg_door_left_front_reason__c', ass.dmg_door_left_front_reason__c);        // ドア左前再学習理由
        writeStringField2(gen, 'dmg_door_left_back__c', ass.dmg_door_left_back__c);        // ドア左後
        writeStringField2(gen, 'dmg_door_left_back_y__c', ass.dmg_door_left_back_y__c);        // ドア左後座標Y
        writeStringField2(gen, 'dmg_door_left_back_x__c', ass.dmg_door_left_back_x__c);        // ドア左後座標X
        writeStringField2(gen, 'dmg_door_left_back_height__c', ass.dmg_door_left_back_height__c);        // ドア左後座標高さ
        writeStringField2(gen, 'dmg_door_left_back_width__c', ass.dmg_door_left_back_width__c);        // ドア左後座標横幅
        writeStringField2(gen, 'dmg_door_left_back_reason__c', ass.dmg_door_left_back_reason__c);        // ドア左後再学習理由
        writeStringField2(gen, 'dmg_side_step_left__c', ass.dmg_side_step_left__c);        // サイドステップ左
        writeStringField2(gen, 'dmg_front_side_mem_left__c', ass.dmg_front_side_mem_left__c);        // フロントサイドメンバー左
        writeStringField2(gen, 'dmg_rear_side_mem_left__c', ass.dmg_rear_side_mem_left__c);        // リアサイドメンバー左
        writeStringField2(gen, 'dmg_asi_right_front__c', ass.dmg_asi_right_front__c);        // 足回り右前
        writeStringField2(gen, 'dmg_asi_right_front_y__c', ass.dmg_asi_right_front_y__c);        // 足回り右前座標Y
        writeStringField2(gen, 'dmg_asi_right_front_x__c', ass.dmg_asi_right_front_x__c);        // 足回り右前座標X
        writeStringField2(gen, 'dmg_asi_right_front_height__c', ass.dmg_asi_right_front_height__c);        // 足回り右前座標高さ
        writeStringField2(gen, 'dmg_asi_right_front_width__c', ass.dmg_asi_right_front_width__c);        // 足回り右前標横幅
        writeStringField2(gen, 'dmg_asi_right_front_reason__c', ass.dmg_asi_right_front_reason__c);        // 足回り右前再学習理由
        writeStringField2(gen, 'dmg_asi_right_back__c', ass.dmg_asi_right_back__c);        // 足回り右後
        writeStringField2(gen, 'dmg_asi_right_back_y__c', ass.dmg_asi_right_back_y__c);        // 足回り右後座標Y
        writeStringField2(gen, 'dmg_asi_right_back_x__c', ass.dmg_asi_right_back_x__c);        // 足回り右後座標X
        writeStringField2(gen, 'dmg_asi_right_back_height__c', ass.dmg_asi_right_back_height__c);        // 足回り右後座標高さ
        writeStringField2(gen, 'dmg_asi_right_back_width__c', ass.dmg_asi_right_back_width__c);        // 足回り右後標横幅
        writeStringField2(gen, 'dmg_asi_right_back_reason__c', ass.dmg_asi_right_back_reason__c);        // 足回り右後再学習理由
        writeStringField2(gen, 'dmg_asi_left_front__c', ass.dmg_asi_left_front__c);        // 足回り左前
        writeStringField2(gen, 'dmg_asi_left_front_y__c', ass.dmg_asi_left_front_y__c);        // 足回り左前座標Y
        writeStringField2(gen, 'dmg_asi_left_front_x__c', ass.dmg_asi_left_front_x__c);        // 足回り左前座標X
        writeStringField2(gen, 'dmg_asi_left_front_height__c', ass.dmg_asi_left_front_height__c);        // 足回り左前座標高さ
        writeStringField2(gen, 'dmg_asi_left_front_width__c', ass.dmg_asi_left_front_width__c);        // 足回り左前標横幅
        writeStringField2(gen, 'dmg_asi_left_front_reason__c', ass.dmg_asi_left_front_reason__c);        // 足回り左前再学習理由
        writeStringField2(gen, 'dmg_asi_left_back__c', ass.dmg_asi_left_back__c);        // 足回り左後
        writeStringField2(gen, 'dmg_asi_left_back_y__c', ass.dmg_asi_left_back_y__c);        // 足回り左後座標Y
        writeStringField2(gen, 'dmg_asi_left_back_x__c', ass.dmg_asi_left_back_x__c);        // 足回り左後座標X
        writeStringField2(gen, 'dmg_asi_left_back_height__c', ass.dmg_asi_left_back_height__c);        // 足回り左後座標高さ
        writeStringField2(gen, 'dmg_asi_left_back_width__c', ass.dmg_asi_left_back_width__c);        // 足回り左後標横幅
        writeStringField2(gen, 'dmg_asi_left_back_reason__c', ass.dmg_asi_left_back_reason__c);        // 足回り左後再学習理由
        writeStringField2(gen, 'dmg_tail_lense_right__c', ass.dmg_tail_lense_right__c);        // テールレンズ右
        writeStringField2(gen, 'dmg_tail_lense_right_y__c', ass.dmg_tail_lense_right_y__c);        // テールレンズ右座標Y
        writeStringField2(gen, 'dmg_tail_lense_right_x__c', ass.dmg_tail_lense_right_x__c);        // テールレンズ右座標X
        writeStringField2(gen, 'dmg_tail_lense_right_height__c', ass.dmg_tail_lense_right_height__c);        // テールレンズ右座標高さ
        writeStringField2(gen, 'dmg_tail_lense_right_width__c', ass.dmg_tail_lense_right_width__c);        // テールレンズ右標横幅
        writeStringField2(gen, 'dmg_tail_lense_right_reason__c', ass.dmg_tail_lense_right_reason__c);        // テールレンズ右再学習理由
        writeStringField2(gen, 'dmg_tail_lense_left__c', ass.dmg_tail_lense_left__c);        // テールレンズ左
        writeStringField2(gen, 'dmg_tail_lense_left_y__c', ass.dmg_tail_lense_left_y__c);        // テールレンズ左座標Y
        writeStringField2(gen, 'dmg_tail_lense_left_x__c', ass.dmg_tail_lense_left_x__c);        // テールレンズ左座標X
        writeStringField2(gen, 'dmg_tail_lense_left_height__c', ass.dmg_tail_lense_left_height__c);        // テールレンズ左座標高さ
        writeStringField2(gen, 'dmg_tail_lense_left_width__c', ass.dmg_tail_lense_left_width__c);        // テールレンズ左標横幅
        writeStringField2(gen, 'dmg_tail_lense_left_reason__c', ass.dmg_tail_lense_left_reason__c);        // テールレンズ左再学習理由
        writeStringField2(gen, 'change_sobi__c', ass.change_sobi__c);        // 装備変更
        writeDateField2(gen, 'shaken_date_1__c', ass.shaken_date_1__c);        // 車検日１
        writeNumberField2(gen, 'shaken_run_dist_1__c', ass.shaken_run_dist_1__c);        // 車検証の走行距離１
        writeDateField2(gen, 'shaken_date_2__c', ass.shaken_date_2__c);        // 車検日２
        writeNumberField2(gen, 'shaken_run_dist_2__c', ass.shaken_run_dist_2__c);        // 車検証の走行距離２
        writeDateField2(gen, 'shaken_date_3__c', ass.shaken_date_3__c);        // 車検日３
        writeNumberField2(gen, 'shaken_run_dist_3__c', ass.shaken_run_dist_3__c);        // 車検証の走行距離３
        writeStringField2(gen, 'no_run_dist__c', ass.no_run_dist__c);        // 距離記載なし
        writeStringField2(gen, 'gaihin_meter__c', ass.gaihin_meter__c);        // 外品メーター
        writeStringField2(gen, 'abnormal_dist__c', ass.abnormal_dist__c);        // 車検証上記載の距離異常
        writeStringField2(gen, 'mentenance_note__c', ass.mentenance_note__c);        // メンテナンスノート
        writeStringField2(gen, 'changed_kisai__c', ass.changed_kisai__c);        // 交換歴の記載
        writeStringField2(gen, 'changed_conpany_stamp__c', ass.changed_conpany_stamp__c);        // 交換業者の社印
        writeStringField2(gen, 'assess_tokki__c', ass.assess_tokki__c);        // 査定時特記事項等記入欄
        writeStringField2(gen, 'front_url__c', ass.front_url__c);        // 正面URL
        writeStringField2(gen, 'right_front_url__c', ass.right_front_url__c);        // 右前URL
        writeStringField2(gen, 'left_front_url__c', ass.left_front_url__c);        // 左前URL
        writeStringField2(gen, 'left_back_url__c', ass.left_back_url__c);        // 左後ろURL
        writeStringField2(gen, 'right_back_url__c', ass.right_back_url__c);        // 右後ろURL
        writeStringField2(gen, 'other_url_04__c', ass.other_url_04__c);        // その他URL4
        writeStringField2(gen, 'other_url_05__c', ass.other_url_05__c);        // その他URL5
        writeStringField2(gen, 'other_url_06__c', ass.other_url_06__c);        // その他URL6
        writeStringField2(gen, 'other_url_07__c', ass.other_url_07__c);        // その他URL7
        writeStringField2(gen, 'other_url_08__c', ass.other_url_08__c);        // その他URL8
        writeStringField2(gen, 'other_url_09__c', ass.other_url_09__c);        // その他URL9
        writeStringField2(gen, 'other_url_10__c', ass.other_url_10__c);        // その他URL10
        writeStringField2(gen, 'other_url_11__c', ass.other_url_11__c);        // その他URL11
        writeStringField2(gen, 'other_url_12__c', ass.other_url_12__c);        // その他URL12
        writeStringField2(gen, 'other_url_13__c', ass.other_url_13__c);        // その他URL13
        writeStringField2(gen, 'other_url_14__c', ass.other_url_14__c);        // その他URL14
        writeStringField2(gen, 'other_url_15__c', ass.other_url_15__c);        // その他URL15
        writeStringField2(gen, 'other_url_16__c', ass.other_url_16__c);        // その他URL16
        writeStringField2(gen, 'other_url_17__c', ass.other_url_17__c);        // その他URL17
        writeStringField2(gen, 'other_url_18__c', ass.other_url_18__c);        // その他URL18
        writeStringField2(gen, 'other_url_19__c', ass.other_url_19__c);        // その他URL19
        writeStringField2(gen, 'other_url_20__c', ass.other_url_20__c);        // その他URL20
        writeStringField2(gen, 'other_url_21__c', ass.other_url_21__c);        // その他URL21　pj2451033　追加
        writeStringField2(gen, 'other_url_22__c', ass.other_url_22__c);        // その他URL22　pj2451033　追加
        writeStringField2(gen, 'other_url_23__c', ass.other_url_23__c);        // その他URL23　pj2451033　追加
        writeStringField2(gen, 'other_url_24__c', ass.other_url_24__c);        // その他URL24　pj2451033　追加
        writeStringField2(gen, 'other_url_25__c', ass.other_url_25__c);        // その他URL25　pj2451033　追加
        writeStringField2(gen, 'other_url_26__c', ass.other_url_26__c);        // その他URL26　pj2451033　追加
        writeStringField2(gen, 'other_url_27__c', ass.other_url_27__c);        // その他URL27　pj2451033　追加
        writeStringField2(gen, 'other_url_28__c', ass.other_url_28__c);        // その他URL28　pj2451033　追加
        writeStringField2(gen, 'other_url_29__c', ass.other_url_29__c);        // その他URL29　pj2451033　追加
        writeStringField2(gen, 'other_url_30__c', ass.other_url_30__c);        // その他URL30　pj2451033　追加
        writeStringField2(gen, 'other_url_31__c', ass.other_url_31__c);        // その他URL31　pj2451033　追加
        writeStringField2(gen, 'other_url_32__c', ass.other_url_32__c);        // その他URL32　pj2451033　追加
        writeStringField2(gen, 'other_url_33__c', ass.other_url_33__c);        // その他URL33　pj2451033　追加
        writeStringField2(gen, 'other_url_34__c', ass.other_url_34__c);        // その他URL34　pj2451033　追加
        writeStringField2(gen, 'other_url_35__c', ass.other_url_35__c);        // その他URL35　pj2451033　追加
        writeStringField2(gen, 'other_url_36__c', ass.other_url_36__c);        // その他URL36　pj2451033　追加
        writeStringField2(gen, 'other_url_37__c', ass.other_url_37__c);        // その他URL37　pj2451033　追加
        writeStringField2(gen, 'other_url_38__c', ass.other_url_38__c);        // その他URL38　pj2451033　追加
        writeStringField2(gen, 'other_url_39__c', ass.other_url_39__c);        // その他URL39　pj2451033　追加
        writeStringField2(gen, 'other_url_40__c', ass.other_url_40__c);        // その他URL40　pj2451033　追加
        writeStringField2(gen, 'shakensho_url__c', ass.shakensho_url__c);        // 車検証URL
        writeNumberField2(gen, 'auc_market_price__c', ass.auc_market_price__c);        // オークション相場
        writeNumberField2(gen, 'auc_repair_market_price__c', ass.auc_repair_market_price__c);        // 修復歴相場
        writeNumberField2(gen, 'auc_repair_price__c', ass.auc_repair_price__c);        // 修理金額
        writeNumberField2(gen, 'auc_sales_price__c', ass.auc_sales_price__c);        // 売り金額
        writeNumberField2(gen, 'auc_kibo_price__c', ass.auc_kibo_price__c);        // 先方希望額
        writeNumberField2(gen, 'auc_competitor__c', ass.auc_competitor__c);        // 競合数
        writeNumberField2(gen, 'auc_compe_price__c', ass.auc_compe_price__c);        // 競合額
        writeNumberField2(gen, 'auc_submit_price__c', ass.auc_submit_price__c);        // 提示金額
        writeDateField2(gen, 'auc_kettei_yoteibi__c', ass.auc_kettei_yoteibi__c);        // 決定予定日
        writeStringField2(gen, 'auc_hanbai_date__c', ass.auc_hanbai_date__c);        // 販売月
        writeStringField2(gen, 'auc_buy_condition__c', ass.auc_buy_condition__c);        // 買取条件
        writeStringField2(gen, 'auc_meigi_henko_date__c', ass.auc_meigi_henko_date__c);        // 名義変更年月
        writeStringField2(gen, 'auc_tax_price__c', ass.auc_tax_price__c);        // 消費税
        writeStringField2(gen, 'auc_other__c', ass.auc_other__c);        // その他

        writeStringField2(gen, 'tokki_other__c', (String)ass.get('tokki_other__c_label'));        // 特記事項（その他）
        writeStringField2(gen, 'tokki_engine__c', (String)ass.get('tokki_engine__c_label'));        // 特記事項（エンジン）
        writeStringField2(gen, 'tokki_oil__c', (String)ass.get('tokki_oil__c_label'));        // 特記事項（オイル）
        writeStringField2(gen, 'tokki_check_rump__c', (String)ass.get('tokki_check_rump__c_label'));        // 特記事項（チェックランプ）
        writeStringField2(gen, 'tokki_bug__c', (String)ass.get('tokki_bug__c_label'));        // 特記事項（不具合）
        writeStringField2(gen, 'tokki_inner__c', (String)ass.get('tokki_inner__c_label'));        // 特記事項（内装）
        writeStringField2(gen, 'tokki_torihazusi__c', (String)ass.get('tokki_torihazusi__c_label'));        // 特記事項（取り外し）
        writeStringField2(gen, 'tokki_outer__c', (String)ass.get('tokki_outer__c_label'));        // 特記事項（外装）
        writeStringField2(gen, 'tokki_keppin__c', (String)ass.get('tokki_keppin__c_label'));        // 特記事項（欠品／備品不具合）
        writeStringField2(gen, 'tokki_sobi__c', (String)ass.get('tokki_sobi__c_label'));        // 特記事項（装備）

        writeStringField2(gen, 'dmg_pillar_right_B__c', ass.dmg_pillar_right_B__c);        // ピラー右B
        writeStringField2(gen, 'dmg_pillar_right_C__c', ass.dmg_pillar_right_C__c);        // ピラー右C
        writeStringField2(gen, 'dmg_pillar_left_A__c', ass.dmg_pillar_left_A__c);        // ピラー左A
        writeStringField2(gen, 'dmg_pillar_left_B__c', ass.dmg_pillar_left_B__c);        // ピラー左B
        writeStringField2(gen, 'dmg_pillar_left_C__c', ass.dmg_pillar_left_C__c);        // ピラー左C
        writeStringField2(gen, 'tokki__c', ass.tokki__c);        // 特記事項

        writeStringField2(gen, 'tokki_japanese__c', util.getTranslatedMulti(joinedTokki,'tokki__c', Constants.LANG_JAPANESE));        // 特記事項（日本語）
        writeStringField2(gen, 'tokki_eizi__c', util.getTranslatedMulti(joinedTokki, 'tokki__c', Constants.LANG_ENGLISH));        // 特記事項（英語）
        writeStringField2(gen, 'tokki_russian__c', util.getTranslatedMulti(joinedTokki, 'tokki__c', Constants.LANG_RUSSIAN));        // 特記事項（ロシア語）
        writeStringField2(gen, 'tokki_chinese__c', util.getTranslatedMulti(joinedTokki, 'tokki__c', Constants.LANG_CHINESE));        // 特記事項（中国語）
        writeStringField2(gen, 'tokki_spanish__c', util.getTranslatedMulti(joinedTokki, 'tokki__c', Constants.LANG_SPANISH));        // 特記事項（スペイン語）

        writeStringField2(gen, 'dmg_oil_pam__c', ass.dmg_oil_pam__c);        // オイルパン
        writeStringField2(gen, 'dmg_core_support__c', ass.dmg_core_support__c);        // コアサポート
        writeStringField2(gen, 'dmg_first_mem__c', ass.dmg_first_mem__c);        // ファーストメンバー
        writeStringField2(gen, 'dmg_close_mem__c', ass.dmg_close_mem__c);        // クロスメンバー
        writeStringField2(gen, 'dmg_engine_mem__c', ass.dmg_engine_mem__c);        // エンジンメンバー

        writeStringField2(gen, 'truck_type__c', ass.truck_type__c);        // トラックの種類
        writeStringField2(gen, 'truck_cabin__c', ass.truck_cabin__c);        // キャビン
        writeStringField2(gen, 'truck_bed__c', ass.truck_bed__c);        // ベッド
        writeStringField2(gen, 'truck_suspension_front__c', ass.truck_suspension_front__c);        // サスペンション（前）
        writeStringField2(gen, 'truck_suspension_back__c', ass.truck_suspension_back__c);        // サスペンション（後）
        writeStringField2(gen, 'truck_brake__c', ass.truck_brake__c);        // ブレーキ
        writeNumberField2(gen, 'truck_aori_height__c', ass.truck_aori_height__c);        // あおり高さ
        writeNumberField2(gen, 'truck_bed_length__c', ass.truck_bed_length__c);        // 荷台長
        writeStringField2(gen, 'truck_pto__c', ass.truck_pto__c);        // PTO
        writeStringField2(gen, 'truck_hydraulic_fluid__c', ass.truck_hydraulic_fluid__c);        // 作動油
        writeNumberField2(gen, 'truck_freezer_temp__c', ass.truck_freezer_temp__c);        // 冷凍機設定温度
        writeStringField2(gen, 'truck_freezer__c', ass.truck_freezer__c);        // 冷凍機
        writeNumberField2(gen, 'truck_insulation_thick__c', ass.truck_insulation_thick__c);        // 断熱材厚み
        writeStringField2(gen, 'truck_wing__c', ass.truck_wing__c);        // ウイング動作確認
        writeStringField2(gen, 'truck_dump__c', ass.truck_dump__c);        // ダンプ動作確認
        writeStringField2(gen, 'truck_dump_type__c', ass.truck_dump_type__c);        // ダンプ方式
        writeStringField2(gen, 'truck_aerial_work__c', ass.truck_aerial_work__c);        // 高所作業車作動確認
        writeStringField2(gen, 'truck_crane_boom__c', ass.truck_crane_boom__c);        // クレーン段数
        writeStringField2(gen, 'truck_crane__c', ass.truck_crane__c);        // クレーン動作確認
        writeStringField2(gen, 'truck_outrigger__c', ass.truck_outrigger__c);        // アウトリガー動作確認
        writeStringField2(gen, 'truck_radicon__c', ass.truck_radicon__c);        // ラジコン
        writeStringField2(gen, 'truck_bucket_material__c', ass.truck_bucket_material__c);        // バケット材質
        writeStringField2(gen, 'truck_loader_dump__c', ass.truck_loader_dump__c);        // ローダーダンプ確認
        writeStringField2(gen, 'truck_loader__c', ass.truck_loader__c);        // ローダー動作確認

        writeStringField2(gen, 'referer', 'hanamaru870.lightning.force.com');        // リファラー

        // 終了マーカー
        gen.writeEndObject();

//        system.debug('JSON : ' + gen.getAsString());
        system.debug('★★★★★JSON出力　スタート★★★★★');
        CommonUtility.logDivString(gen.getAsString());
        system.debug('★★★★★JSON出力　エンド★★★★★');
        return gen.getAsString();
    }


    /*
     * String項目の空白対応JSON文字列追加
     */
    public static void writeStringField2(JSONGenerator gen, String fieldName, String fieldValue) {
        if(String.isEmpty(fieldValue)) {
//          gen.writeNullField(fieldName); // Could be replaced with writeStringField(...,'') if you prefer an empty string over a null field
            gen.writeStringField(fieldName, '');
        } else {
            gen.writeStringField(fieldName, fieldValue);
        }
    }


    /*
     * Decimal項目の空白対応JSON文字列追加
     */
    public static void writeNumberField2(JSONGenerator gen, String fieldName, Decimal fieldValue) {
        if(fieldValue == null) {
            gen.writeNullField(fieldName); // Could be replaced with writeStringField(...,'') if you prefer an empty string over a null field
        } else {
            gen.writeNumberField(fieldName, fieldValue);
        }
    }

    /*
     * Boolean項目の空白対応JSON文字列追加 HANA_SF_SATEI-272　20241115追加
     */
    public static void writeBooleanField2(JSONGenerator gen, String fieldName, Boolean fieldValue) {
        if(fieldValue == null) {
            gen.writeNullField(fieldName);
        }else{
            gen.writeBooleanField(fieldName, fieldValue);
        }
    }

    /*
     * Date項目の空白対応JSON文字列追加
     */
    public static void writeDateField2(JSONGenerator gen, String fieldName, Date fieldValue) {
        if(fieldValue == null) {
            gen.writeNullField(fieldName); // Could be replaced with writeStringField(...,'') if you prefer an empty string over a null field
        } else {
            gen.writeDateField(fieldName, fieldValue);
        }
    }


    /*
     * Datetime項目の空白対応JSON文字列追加
     */
    public static void writeDateTimeField2(JSONGenerator gen, String fieldName, Datetime fieldValue) {
        if(fieldValue == null) {
            gen.writeNullField(fieldName); // Could be replaced with writeStringField(...,'') if you prefer an empty string over a null field
        } else {
            gen.writeDateTimeField(fieldName, fieldValue);
        }
    }


    /*
     * 各特記事項を結合した文字列を返す
     */
    private String getJoinTokki(Assessment__c ass){
        String joinedTokki;
        List<String> tokkiList = new List<String>();

        tokkiList.add(ass.tokki_sobi__c);
        tokkiList.add(ass.tokki_inner__c);
        tokkiList.add(ass.tokki_outer__c);
        tokkiList.add(ass.tokki_engine__c);
        tokkiList.add(ass.tokki_check_rump__c);
        tokkiList.add(ass.tokki_oil__c);
        tokkiList.add(ass.tokki_bug__c);
        tokkiList.add(ass.tokki_torihazusi__c);
        tokkiList.add(ass.tokki_keppin__c);
        tokkiList.add(ass.tokki_other__c);

        joinedTokki = String.join(tokkiList, ';');

        return joinedTokki;
    }

    /*
     * 社内積込パーツの文字列を返す
     */
    private String getShanaiTumikomiParts(String numStr){
        if(numStr == '0'){
            return 'なし';
        }
        else if(numStr == '1'){
            return 'あり';
        }
        else{
            return '';
        }
    }


    /*
     * パワースライドドアの文字列を返す
     */
    private String getSobiPawerSlideDoor(String numStr){
        if(numStr == '1'){
            return '〇';
        }
        else{
            return '';
        }
    }

    public HttpResponse PostAssessmentInfoHelper(Assessment__c ass){
        final String ENDPOINT = Constants.AUCTIONSITE_URL;

        Http http = new http();
        HttpRequest httpReq = new HttpRequest();

        // リクエスト作成
        // Todo 暫定エンドポイント
        httpReq.setEndpoint(ENDPOINT);
        httpReq.setMethod('POST');
        httpReq.setHeader('Content-Type', 'application/json;charset=UTF-8');
        httpReq.setBody(createAssJson(ass));
        httpReq.setTimeout(Integer.ValueOf(System.Label.AuctionSendTimeout));

        // 査定表データ ログ出力
        System.debug('査定表データ：' + ass);

        // リクエスト ログ出力
        System.debug('リクエストヘッダ : ' + httpReq.getHeader('Content-Type'));
        System.debug('リクエストエンドポイント : ' + httpReq.getEndpoint());
        System.debug('リクエストメソッド : ' + httpReq.getMethod());
        System.debug('リクエストボディ : ' + httpReq.getBody());
        System.debug('リクエスト : ' + httpReq.toString());

        // リクエスト送信＆レスポンス受信
        HttpResponse httpRes = http.send(httpReq);

        // レスポンス ログ出力
        System.debug('レスポンスヘッダ : ' + httpRes.getHeader('Content-Type'));
        System.debug('レスポンスステータス : ' + httpRes.getStatusCode() + ',' + httpRes.getStatus());
        System.debug('レスポンスボディ : ' + httpres.getBody());
        return httpRes;
    }
}