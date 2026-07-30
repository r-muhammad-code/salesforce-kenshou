public class AssessmentGetBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {

    /**
     * コンストラクタ
     */
    public AssessmentGetBatch() {
    }

    /**
     * start method
     */
    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('AssessmentGetBatch start method');
        String getAssessmentStart = '';         
                    getAssessmentStart += ' SELECT ';
                    getAssessmentStart += ' Id ';
                    getAssessmentStart += ' ,Name ';      // 査定表名
                    getAssessmentStart += ' ,account__c ';        // 取引先
                    getAssessmentStart += ' ,account__r.Name ';        // ★取引先名
                    getAssessmentStart += ' ,SalesDataListing__c ';       //営業データ出品  20211027 HANA_SF_SATEI-205 
                    getAssessmentStart += ' ,store__c ';        // 依頼店
                    getAssessmentStart += ' ,yard_kbn__c ';       //ヤード区分 pj2451033 追加
                    getAssessmentStart += ' ,LotNo_yard__c ';        // ロットNo　20220525 HANA_SF_SATEI-223
                    getAssessmentStart += ' ,ana_tacho__c ';        // アナタコ
                    getAssessmentStart += ' ,car_number__c ';        // ナンバー記入欄
                    getAssessmentStart += ' ,asses_tanto__c ';        // 査定担当者
                    getAssessmentStart += ' ,asses_tanto__r.Name ';        // ★査定担当者名
                    getAssessmentStart += ' ,car_maker__c ';        // メーカ名
                    getAssessmentStart += ' ,car_maker__r.maker__c ';        // メーカー（数字）
                    getAssessmentStart += ' ,car_maker__r.Name ';        // メーカ名
                    getAssessmentStart += ' ,car_maker__r.maker_name_eizi__c ';        // メーカー名（英語）
                    getAssessmentStart += ' ,car_model__c ';        // 車種名
                    getAssessmentStart += ' ,car_model__r.inum__c ';        // 車種（INUM）
                    getAssessmentStart += ' ,car_model__r.Name ';        // 車種名
                    getAssessmentStart += ' ,car_model__r.model_name_eizi__c ';        // 車種名英字
                    // getAssessmentStart += ' ,car_grade__c ';        // グレード名
                    // getAssessmentStart += ' ,car_grade__r.inum__c ';        // グレード（INUM）
                    // getAssessmentStart += ' ,car_grade__r.Name ';        // グレード名
                    // getAssessmentStart += ' ,car_grade__r.name_en__c ';        // グレード名英字
                    getAssessmentStart += ' ,damage_other__c ';        // ダメ―ジその他
                    getAssessmentStart += ' ,registerdAtYear__c ';        // 初年度登録（年）
                    // getAssessmentStart += ' ,registerdAtMonth__c ';        // 初年度登録（月）
                    // getAssessmentStart += ' ,engine_katasiki__c ';        // エンジン形式
                    getAssessmentStart += ' ,seizo_nensiki__c ';        // 製造年式
                    getAssessmentStart += ' ,color_no__c ';        // カラーNo.
                    getAssessmentStart += ' ,color__c ';        // カラー
                    getAssessmentStart += ' ,tolabel(color__c) color__c_label ';        // カラー（ラベル）
                    //getAssessmentStart += ' ,color_eizi__c ';        // カラー（英語）
                    getAssessmentStart += ' ,handle__c ';        // ハンドル 20210823追加
                    getAssessmentStart += ' ,shift__c ';        // シフト
                    getAssessmentStart += ' ,tolabel(shift__c) shift__c_label ';        // シフト（ラベル）
                    // getAssessmentStart += ' ,katasiki_sitei_no__c ';        // 型式指定番号
                    getAssessmentStart += ' ,room_url__c ';        // 室内URL
                    getAssessmentStart += ' ,key__c ';        // アナタコカギ
                    getAssessmentStart += ' ,seizo_getu__c ';        // 製造年式（月）
                    // getAssessmentStart += ' ,rui_kbn_no__c ';        // 類別区分番号
                    getAssessmentStart += ' ,run_dist__c ';        // 走行距離
                    getAssessmentStart += ' ,run_dist_unit__c ';        // 走行距離単位
                    getAssessmentStart += ' ,run_kakunin__c ';        // 実走確認
                    // getAssessmentStart += ' ,haiki_ryo__c ';        // 排気量（CC）
                    // getAssessmentStart += ' ,meter_disp__c ';        // メーター表示
                    // getAssessmentStart += ' ,fuel__c ';        // 燃料
                    getAssessmentStart += ' ,fuel_ohter__c ';        // 燃料その他
                    // getAssessmentStart += ' ,teiin__c ';        // 定員
                    getAssessmentStart += ' ,okiba__c ';        // 置場（自由入力）
                    getAssessmentStart += ' ,okiba_select__c ';        // 置場
                    getAssessmentStart += ' ,tolabel(okiba_select__c) okiba_select__c_label ';        // 置場（ラベル）
                    getAssessmentStart += ' ,shaken_inf__c ';        // 車検情報
                    getAssessmentStart += ' ,shaken_nen__c ';        // 車検付き年
                    getAssessmentStart += ' ,shaken_getu__c ';        // 車検付き月
                    getAssessmentStart += ' ,jiso__c ';        // 自走
                    getAssessmentStart += ' ,kudo__c ';        // 駆動
                    getAssessmentStart += ' ,engine_url__c ';        // エンジンルームURL
                    getAssessmentStart += ' ,UsedcarEvaluationpoints__c ';        // 中古車査定時評価点 20210823追加
                    getAssessmentStart += ' ,UsedcarInnerEvaluationpoints__c ';        // 中古車査定時内装評価点 20210823追加
                    getAssessmentStart += ' ,damage__c ';        // ダメージ
                    getAssessmentStart += ' ,tolabel(damage__c) damage__c_label ';        // ダメージ（ラベル）
                    //getAssessmentStart += ' ,damage_eizi__c ';        // ダメージ（英語）
                    //getAssessmentStart += ' ,damage_russian__c ';        // ダメージ（ロシア語）
                    getAssessmentStart += ' ,cell__c ';        // セル
                    getAssessmentStart += ' ,engine__c ';        // エンジン
                    getAssessmentStart += ' ,engine_back__c ';        // エンジン後退
                    getAssessmentStart += ' ,engine_ng__c ';        // エンジンNG
                    getAssessmentStart += ' ,mission__c ';        // ミッション
                    getAssessmentStart += ' ,radiator__c ';        // ラジエター
                    getAssessmentStart += ' ,condenser__c ';        // コンデンサー
                    getAssessmentStart += ' ,rent_register__c ';        // レンタ登録
                    getAssessmentStart += ' ,owner_right__c ';        // 所有権
                    getAssessmentStart += ' ,zansai__c ';        // 残債
                    getAssessmentStart += ' ,inner_dust__c ';        // 室内ゴミ
                    getAssessmentStart += ' ,shanai_tumikomi_parts__c ';        // 社内積込パーツ
                    //getAssessmentStart += ' ,tolabel(shanai_tumikomi_parts__c) shanai_tumikomi_parts__c_label ';         // 社内積込パーツ（ラベル）
                    getAssessmentStart += ' ,tanto_manage_bumon__c ';        // 統括部門
                    getAssessmentStart += ' ,sobi_seat__c ';        // シート
                    getAssessmentStart += ' ,cotion_url__c ';        // コーションURL
                    getAssessmentStart += ' ,key_url__c ';        // カギURL
                    getAssessmentStart += ' ,meter_url__c ';        // メーターURL
                    getAssessmentStart += ' ,steering_url__c ';        // ステアリングURL  pj2451033　追加
                    getAssessmentStart += ' ,center_console_url__c ';    // センターコンソールURL  pj2451033　追加
                    getAssessmentStart += ' ,front_seat_url__c ';    // 前席シートURL  pj2451033　追加
                    getAssessmentStart += ' ,switch1_url__c ';        // スイッチ類➀URL  pj2451033　追加
                    getAssessmentStart += ' ,switch2_url__c ';        // スイッチ類➁URL  pj2451033　追加
                    getAssessmentStart += ' ,other_url_01__c ';        // その他URL1
                    getAssessmentStart += ' ,other_url_02__c ';        // その他URL2
                    getAssessmentStart += ' ,other_url_03__c ';        // その他URL3
                    getAssessmentStart += ' ,sobi_pawer_slide_door_right__c ';        // パワースライドドア右
                    //getAssessmentStart += ' ,tolabel(sobi_pawer_slide_door_right__c) sobi_pawer_slide_door_right__c_label ';         // パワースライドドア右（ラベル）
                    getAssessmentStart += ' ,sobi_navi_select__c ';        // ナビ
                    getAssessmentStart += ' ,sobi_navi_other__c ';        // ナビその他
                    getAssessmentStart += ' ,absb_driver__c ';        // 運転席
                    getAssessmentStart += ' ,absb_sub__c ';        // 助手席
                    getAssessmentStart += ' ,absb_side_right__c ';        // サイド右
                    getAssessmentStart += ' ,absb_side_left__c ';        // サイド左
                    getAssessmentStart += ' ,absb_driver_knee__c ';        // 運転席ニー
                    getAssessmentStart += ' ,absb_sub_knee__c ';        // 助手席ニー
                    getAssessmentStart += ' ,absb_curtain_right__c ';        // カーテン右
                    getAssessmentStart += ' ,absb_curtain_left__c ';        // カーテン左
                    getAssessmentStart += ' ,absb_driver_seat__c ';        // 運転席シート
                    getAssessmentStart += ' ,absb_sub_seat__c ';        // 助手席シート
                    getAssessmentStart += ' ,absb_airbag_right_back__c ';        // 後部座席右エアバッグ 20210823追加
                    getAssessmentStart += ' ,absb_airbag_left_back__c ';        // 後部座席左エアバッグ 20210823追加
                    getAssessmentStart += ' ,absb_belt_right__c ';        // シートベルト右
                    getAssessmentStart += ' ,absb_belt_right_back__c ';        // 後部座席シートベルト右 20210823追加
                    getAssessmentStart += ' ,absb_belt_left__c ';        // シートベルト左
                    getAssessmentStart += ' ,absb_belt_left_back__c ';        // 後部座席シートベルト左 20210823追加
                    getAssessmentStart += ' ,absb_active_headrest__c ';        // アクティブヘッドレスト 20210823追加
                    getAssessmentStart += ' ,absb_popup_hood__c ';        // ポップアップフード 20210823追加
                    getAssessmentStart += ' ,asset_mngno__c ';        // 査定表管理No.
                    getAssessmentStart += ' ,seizo_nen__c ';        // 製造年式（年）
                    getAssessmentStart += ' ,oppotunity__c ';        // 買取商談
                    getAssessmentStart += ' ,oppotunity__r.Name ';        // ★買取商談名
                    getAssessmentStart += ' ,oppotunity__r.Mst_Types__r.inum__c ';        // 型式（INUM）　  HANA_SF_SATEI-272　20241115追加
                    getAssessmentStart += ' ,oppotunity__r.Mst_Types__r.Name ';        // 型式名　  HANA_SF_SATEI-272　20241116追加
                    getAssessmentStart += ' ,oppotunity__r.engine_form__c ';        // エンジン型式　  HANA_SF_SATEI-272　20241117追加
                    getAssessmentStart += ' ,oppotunity__r.form_num__c ';        // 型式指定番号　  HANA_SF_SATEI-272　20241118追加
                    getAssessmentStart += ' ,oppotunity__r.bunrui_num__c ';        // 類別区分番号　  HANA_SF_SATEI-272　20241119追加
                    getAssessmentStart += ' ,oppotunity__r.CarNo__c ';        // 車台番号　  HANA_SF_SATEI-272　20241120追加
                    getAssessmentStart += ' ,oppotunity__r.run_contents__c ';        // メーター状態　  HANA_SF_SATEI-272　20241121追加
                    getAssessmentStart += ' ,oppotunity__r.ModelYearPickList__c ';        // 年式　  HANA_SF_SATEI-272　20241122追加
                    getAssessmentStart += ' ,oppotunity__r.First_year_registration__c ';        // 初年度登録月　  HANA_SF_SATEI-272　20241123追加
                    getAssessmentStart += ' ,oppotunity__r.Except_First_year_registration__c ';        // 初年度月除外　  HANA_SF_SATEI-272　20241124追加
                    getAssessmentStart += ' ,oppotunity__r.fuel__c ';        // 燃料　  HANA_SF_SATEI-272　20241125追加
                    getAssessmentStart += ' ,oppotunity__r.teiin__c ';        // 定員　  HANA_SF_SATEI-272　20241126追加
                    getAssessmentStart += ' ,oppotunity__r.dis_volume__c ';        // 排気量　  HANA_SF_SATEI-272　20241127追加
                    getAssessmentStart += ' ,oppotunity__r.vehicle_length__c ';        // 長さ　  HANA_SF_SATEI-272　20241128追加
                    getAssessmentStart += ' ,oppotunity__r.vehicle_width__c ';        // 幅　  HANA_SF_SATEI-272　20241129追加
                    getAssessmentStart += ' ,oppotunity__r.vehicle_height__c ';        // 高さ　  HANA_SF_SATEI-272　20241130追加
                    getAssessmentStart += ' ,oppotunity__r.vehicle_weight__c ';        // 車輌重量　  HANA_SF_SATEI-272　20241131追加
                    getAssessmentStart += ' ,oppotunity__r.shaken_erase_year__c ';        // 車検期限年　  HANA_SF_SATEI-272　20241132追加
                    getAssessmentStart += ' ,oppotunity__r.shaken_erase_month__c ';        // 車検期限月　  HANA_SF_SATEI-272　20241133追加
                    getAssessmentStart += ' ,oppotunity__r.Mst_Grades__r.inum__c ';        // グレード（INUM）　  HANA_SF_SATEI-272　20241134追加
                    getAssessmentStart += ' ,oppotunity__r.Mst_Grades__r.Name ';        // グレード名　  HANA_SF_SATEI-272　20241135追加
                    getAssessmentStart += ' ,oppotunity__r.OpportunityID_18__c ';        // 買取商談ID（18ケタ）　  HANA_SF_SATEI-272　20241136追加
                    getAssessmentStart += ' ,oppotunity__r.exhibit_memo__c ';        // 注意事項　  HANA_SF_SATEI-272　20241137追加
                    getAssessmentStart += ' ,oppotunity__r.alert_memo__c ';        // 警告設定　  HANA_SF_SATEI-272　20241138追加
                    getAssessmentStart += ' ,oppotunity__r.setting_content__c ';        // 取・メン・保・スペア　  HANA_SF_SATEI-272　20241139追加
                    getAssessmentStart += ' ,oppotunity__r.auc_area__c ';        // 出品先　  HANA_SF_SATEI-272　20241140追加
                    getAssessmentStart += ' ,oppotunity__r.nyu_price__c ';        // 入札希望価格　  HANA_SF_SATEI-272　20241141追加
                    getAssessmentStart += ' ,oppotunity__r.expected_price__c ';        // 仕入希望価格　  HANA_SF_SATEI-272　20241142追加
                    getAssessmentStart += ' ,oppotunity__r.auc_sprice__c ';        // ライブ開始価格　  HANA_SF_SATEI-272　20241143追加
                    getAssessmentStart += ' ,oppotunity__r.Vehicle_Gross_Weight__c ';        // 車輌総重量
                    getAssessmentStart += ' ,oppotunity__r.maximum_payload__c ';        // 最大積載量
                    getAssessmentStart += ' ,manage_bumon__c ';        // 統括部門(テキスト)
                    getAssessmentStart += ' ,ai_use_umu__c ';        // AI判定使用有無
                    getAssessmentStart += ' ,sv_sync_date__c ';        // サーバ同期日時
                    getAssessmentStart += ' ,asses_date__c ';        // 査定年月日
                    // getAssessmentStart += ' ,car_type__c ';        // 型式
                    // getAssessmentStart += ' ,car_type__r.inum__c ';  // 型式（INUM）
                    // getAssessmentStart += ' ,car_type__r.Name ';        // 型式名
                    getAssessmentStart += ' ,full_katasiki__c ';        // フル型式
                    getAssessmentStart += ' ,shadai_no__c ';        // 車台番号
                    getAssessmentStart += ' ,turbo__c ';        // ターボ
                    getAssessmentStart += ' ,color_changed__c ';        // 色替え
                    getAssessmentStart += ' ,no_lift_use__c ';        // リフト使用なし
                    getAssessmentStart += ' ,manual__c ';        // 取説
                    getAssessmentStart += ' ,reserve1__c ';        // 保証書
                    getAssessmentStart += ' ,dmg_pillar_right_A__c ';        // ピラー右A
                    getAssessmentStart += ' ,sobi_aw__c ';        // AW
                    getAssessmentStart += ' ,sobi_sunloof__c ';        // サンルーフ
                    getAssessmentStart += ' ,sobi_tv__c ';        // TV
                    getAssessmentStart += ' ,sobi_navi__c ';        // NAVI
                    getAssessmentStart += ' ,sobi_ps__c ';        // PS
                    getAssessmentStart += ' ,sobi_pw__c ';        // PW
                    getAssessmentStart += ' ,sobi_ac__c ';        // A/C 20210823追加
                    getAssessmentStart += ' ,sobi_pawer_slide_door_left__c ';        // パワースライドドア左
                    //getAssessmentStart += ' ,tolabel(sobi_pawer_slide_door_left__c) sobi_pawer_slide_door_left__c_label ';        // パワースライドドア左（ラベル）
                    getAssessmentStart += ' ,dmg_front_glass__c ';        // フロントガラス
                    getAssessmentStart += ' ,dmg_front_glass_y__c ';        // フロントガラス座標Y
                    getAssessmentStart += ' ,dmg_front_glass_x__c ';        // フロントガラス座標X
                    getAssessmentStart += ' ,dmg_front_glass_height__c ';        // フロントガラス座標高さ
                    getAssessmentStart += ' ,dmg_front_glass_width__c ';        // フロントガラス座標横幅
                    getAssessmentStart += ' ,dmg_front_glass_reason__c ';        // フロントガラス再学習理由
                    getAssessmentStart += ' ,dmg_front_bumper__c ';        // フロントバンパー
                    getAssessmentStart += ' ,dmg_front_bumper_y__c ';        // フロントバンパー座標Y
                    getAssessmentStart += ' ,dmg_front_bumper_x__c ';        // フロントバンパー座標X
                    getAssessmentStart += ' ,dmg_front_bumper_height__c ';        // フロントバンパー座標高さ
                    getAssessmentStart += ' ,dmg_front_bumper_width__c ';        // フロントバンパー座標横幅
                    getAssessmentStart += ' ,dmg_front_bumper_reason__c ';        // フロントバンパー再学習理由
                    getAssessmentStart += ' ,dmg_bonnet__c ';        // ボンネット
                    getAssessmentStart += ' ,dmg_bonnet_y__c ';        // ボンネット座標Y
                    getAssessmentStart += ' ,dmg_bonnet_x__c ';        // ボンネット座標X
                    getAssessmentStart += ' ,dmg_bonnet_height__c ';        // ボンネット座標高さ
                    getAssessmentStart += ' ,dmg_bonnet_width__c ';        // ボンネット座標横幅
                    getAssessmentStart += ' ,dmg_bonnet_reason__c ';        // ボンネット再学習理由
                    getAssessmentStart += ' ,dmg_loof_glass__c ';        // ルーフガラス
                    getAssessmentStart += ' ,dmg_rear_glass__c ';        // リアガラス
                    getAssessmentStart += ' ,dmg_rear_glass_y__c ';        // リアガラス座標Y
                    getAssessmentStart += ' ,dmg_rear_glass_x__c ';        // リアガラス座標X
                    getAssessmentStart += ' ,dmg_rear_glass_height__c ';        // リアガラス座標高さ
                    getAssessmentStart += ' ,dmg_rear_glass_width__c ';        // リアガラス座標横幅
                    getAssessmentStart += ' ,dmg_rear_glass_reason__c ';        // リアガラス再学習理由
                    getAssessmentStart += ' ,dmg_rear_bumper__c ';        // リアバンパー
                    getAssessmentStart += ' ,dmg_rear_bumper_y__c ';        // リアバンパー座標Y
                    getAssessmentStart += ' ,dmg_rear_bumper_x__c ';        // リアバンパー座標X
                    getAssessmentStart += ' ,dmg_rear_bumper_height__c ';        // リアバンパー座標高さ
                    getAssessmentStart += ' ,dmg_rear_bumper_width__c ';        // リアバンパー座標横幅
                    getAssessmentStart += ' ,dmg_rear_bumper_reason__c ';        // リアバンパー再学習理由
                    getAssessmentStart += ' ,dmg_trunk__c ';        // トランク／リアゲート
                    getAssessmentStart += ' ,dmg_trunk_y__c ';        // トランク／リアゲート座標Y
                    getAssessmentStart += ' ,dmg_trunk_x__c ';        // トランク／リアゲート座標X
                    getAssessmentStart += ' ,dmg_trunk_height__c ';        // トランク／リアゲート座標高さ
                    getAssessmentStart += ' ,dmg_trunk_width__c ';        // トランク／リアゲート座標横幅
                    getAssessmentStart += ' ,dmg_trunk_reason__c ';        // トランク／リアゲート再学習理由
                    getAssessmentStart += ' ,dmg_dash_panel__c ';        // ダッシュパネル
                    getAssessmentStart += ' ,dmg_back_panel__c ';        // バックパネル
                    getAssessmentStart += ' ,dmg_room_floor__c ';        // ルームフロア
                    getAssessmentStart += ' ,dmg_trunc_floor__c ';        // トランクフロア
                    getAssessmentStart += ' ,dmg_head_light_right__c ';        // ヘッドライト右
                    getAssessmentStart += ' ,dmg_head_light_right_y__c ';        // ヘッドライト右座標Y
                    getAssessmentStart += ' ,dmg_head_light_right_x__c ';        // ヘッドライト右座標X
                    getAssessmentStart += ' ,dmg_head_light_right_height__c ';        // ヘッドライト右座標高さ
                    getAssessmentStart += ' ,dmg_head_light_right_width__c ';        // ヘッドライト右座標横幅
                    getAssessmentStart += ' ,dmg_head_light_right_reason__c ';        // ヘッドライト右再学習理由
                    getAssessmentStart += ' ,dmg_fender_right_front__c ';        // フェンダー右前
                    getAssessmentStart += ' ,dmg_fender_right_front_y__c ';        // フェンダー右前座標Y
                    getAssessmentStart += ' ,dmg_fender_right_front_x__c ';        // フェンダー右前座標X
                    getAssessmentStart += ' ,dmg_fender_right_front_height__c ';        // フェンダー右前座標高さ
                    getAssessmentStart += ' ,dmg_fender_right_front_width__c ';        // フェンダー右前座標横幅
                    getAssessmentStart += ' ,dmg_fender_right_front_reason__c ';        // フェンダー右前再学習理由
                    getAssessmentStart += ' ,dmg_fender_right_back__c ';        // フェンダー右後
                    getAssessmentStart += ' ,dmg_fender_right_back_y__c ';        // フェンダー右後座標Y
                    getAssessmentStart += ' ,dmg_fender_right_back_x__c ';        // フェンダー右後座標X
                    getAssessmentStart += ' ,dmg_fender_right_back_height__c ';        // フェンダー右後座標高さ
                    getAssessmentStart += ' ,dmg_fender_right_back_width__c ';        // フェンダー右後座標横幅
                    getAssessmentStart += ' ,dmg_fender_right_back_reason__c ';        // フェンダー右後再学習理由
                    getAssessmentStart += ' ,dmg_door_right_front__c ';        // ドア右前
                    getAssessmentStart += ' ,dmg_door_right_front_y__c ';        // ドア右前座標Y
                    getAssessmentStart += ' ,dmg_door_right_front_x__c ';        // ドア右前座標X
                    getAssessmentStart += ' ,dmg_door_right_front_height__c ';        // ドア右前座標高さ
                    getAssessmentStart += ' ,dmg_door_right_front_width__c ';        // ドア右前座標横幅
                    getAssessmentStart += ' ,dmg_door_right_front_reason__c ';        // ドア右前再学習理由
                    getAssessmentStart += ' ,dmg_door_right_back__c ';        // ドア右後
                    getAssessmentStart += ' ,dmg_door_right_back_y__c ';        // ドア右後座標Y
                    getAssessmentStart += ' ,dmg_door_right_back_x__c ';        // ドア右後座標X
                    getAssessmentStart += ' ,dmg_door_right_back_height__c ';        // ドア右後座標高さ
                    getAssessmentStart += ' ,dmg_door_right_back_width__c ';        // ドア右後座標横幅
                    getAssessmentStart += ' ,dmg_door_right_back_reason__c ';        // ドア右後再学習理由
                    getAssessmentStart += ' ,dmg_side_step_right__c ';        // サイドステップ右
                    getAssessmentStart += ' ,dmg_front_side_mem_right__c ';        // フロントサイドメンバー右
                    getAssessmentStart += ' ,dmg_rear_side_mem_right__c ';        // リアサイドメンバー右
                    getAssessmentStart += ' ,dmg_head_light_left__c ';        // ヘッドライト左
                    getAssessmentStart += ' ,dmg_head_light_left_y__c ';        // ヘッドライト左座標Y
                    getAssessmentStart += ' ,dmg_head_light_left_x__c ';        // ヘッドライト左座標X
                    getAssessmentStart += ' ,dmg_head_light_left_height__c ';        // ヘッドライト左座標高さ
                    getAssessmentStart += ' ,dmg_head_light_left_width__c ';        // ヘッドライト左座標横幅
                    getAssessmentStart += ' ,dmg_head_light_left_reason__c ';        // ヘッドライト左再学習理由
                    getAssessmentStart += ' ,dmg_fender_left_front__c ';        // フェンダー左前
                    getAssessmentStart += ' ,dmg_fender_left_front_y__c ';        // フェンダー左前座標Y
                    getAssessmentStart += ' ,dmg_fender_left_front_x__c ';        // フェンダー左前座標X
                    getAssessmentStart += ' ,dmg_fender_left_front_height__c ';        // フェンダー左前座標高さ
                    getAssessmentStart += ' ,dmg_fender_left_front_width__c ';        // フェンダー左前座標横幅
                    getAssessmentStart += ' ,dmg_fender_left_front_reason__c ';        // フェンダー左前再学習理由
                    getAssessmentStart += ' ,dmg_fender_left_back__c ';        // フェンダー左後
                    getAssessmentStart += ' ,dmg_fender_left_back_y__c ';        // フェンダー左後座標Y
                    getAssessmentStart += ' ,dmg_fender_left_back_x__c ';        // フェンダー左後座標X
                    getAssessmentStart += ' ,dmg_fender_left_back_height__c ';        // フェンダー左後座標高さ
                    getAssessmentStart += ' ,dmg_fender_left_back_width__c ';        // フェンダー左後座標横幅
                    getAssessmentStart += ' ,dmg_fender_left_back_reason__c ';        // フェンダー左後再学習理由
                    getAssessmentStart += ' ,dmg_door_left_front__c ';        // ドア左前
                    getAssessmentStart += ' ,dmg_door_left_front_y__c ';        // ドア左前座標Y
                    getAssessmentStart += ' ,dmg_door_left_front_x__c ';        // ドア左前座標X
                    getAssessmentStart += ' ,dmg_door_left_front_height__c ';        // ドア左前座標高さ
                    getAssessmentStart += ' ,dmg_door_left_front_width__c ';        // ドア左前座標横幅
                    getAssessmentStart += ' ,dmg_door_left_front_reason__c ';        // ドア左前再学習理由
                    getAssessmentStart += ' ,dmg_door_left_back__c ';        // ドア左後
                    getAssessmentStart += ' ,dmg_door_left_back_y__c ';        // ドア左後座標Y
                    getAssessmentStart += ' ,dmg_door_left_back_x__c ';        // ドア左後座標X
                    getAssessmentStart += ' ,dmg_door_left_back_height__c ';        // ドア左後座標高さ
                    getAssessmentStart += ' ,dmg_door_left_back_width__c ';        // ドア左後座標横幅
                    getAssessmentStart += ' ,dmg_door_left_back_reason__c ';        // ドア左後再学習理由
                    getAssessmentStart += ' ,dmg_side_step_left__c ';        // サイドステップ左
                    getAssessmentStart += ' ,dmg_front_side_mem_left__c ';        // フロントサイドメンバー左
                    getAssessmentStart += ' ,dmg_rear_side_mem_left__c ';        // リアサイドメンバー左
                    getAssessmentStart += ' ,dmg_asi_right_front__c ';        // 足回り右前
                    getAssessmentStart += ' ,dmg_asi_right_front_y__c ';        // 足回り右前座標Y
                    getAssessmentStart += ' ,dmg_asi_right_front_x__c ';        // 足回り右前座標X
                    getAssessmentStart += ' ,dmg_asi_right_front_height__c ';        // 足回り右前座標高さ
                    getAssessmentStart += ' ,dmg_asi_right_front_width__c ';        // 足回り右前標横幅
                    getAssessmentStart += ' ,dmg_asi_right_front_reason__c ';        // 足回り右前再学習理由
                    getAssessmentStart += ' ,dmg_asi_right_back__c ';        // 足回り右後
                    getAssessmentStart += ' ,dmg_asi_right_back_y__c ';        // 足回り右後座標Y
                    getAssessmentStart += ' ,dmg_asi_right_back_x__c ';        // 足回り右後座標X
                    getAssessmentStart += ' ,dmg_asi_right_back_height__c ';        // 足回り右後座標高さ
                    getAssessmentStart += ' ,dmg_asi_right_back_width__c ';        // 足回り右後標横幅
                    getAssessmentStart += ' ,dmg_asi_right_back_reason__c ';        // 足回り右後再学習理由
                    getAssessmentStart += ' ,dmg_asi_left_front__c ';        // 足回り左前
                    getAssessmentStart += ' ,dmg_asi_left_front_y__c ';        // 足回り左前座標Y
                    getAssessmentStart += ' ,dmg_asi_left_front_x__c ';        // 足回り左前座標X
                    getAssessmentStart += ' ,dmg_asi_left_front_height__c ';        // 足回り左前座標高さ
                    getAssessmentStart += ' ,dmg_asi_left_front_width__c ';        // 足回り左前標横幅
                    getAssessmentStart += ' ,dmg_asi_left_front_reason__c ';        // 足回り左前再学習理由
                    getAssessmentStart += ' ,dmg_asi_left_back__c ';        // 足回り左後
                    getAssessmentStart += ' ,dmg_asi_left_back_y__c ';        // 足回り左後座標Y
                    getAssessmentStart += ' ,dmg_asi_left_back_x__c ';        // 足回り左後座標X
                    getAssessmentStart += ' ,dmg_asi_left_back_height__c ';        // 足回り左後座標高さ
                    getAssessmentStart += ' ,dmg_asi_left_back_width__c ';        // 足回り左後標横幅
                    getAssessmentStart += ' ,dmg_asi_left_back_reason__c ';        // 足回り左後再学習理由
                    getAssessmentStart += ' ,dmg_tail_lense_right__c ';        // テールレンズ右
                    getAssessmentStart += ' ,dmg_tail_lense_right_y__c ';        // テールレンズ右座標Y
                    getAssessmentStart += ' ,dmg_tail_lense_right_x__c ';        // テールレンズ右座標X
                    getAssessmentStart += ' ,dmg_tail_lense_right_height__c ';        // テールレンズ右座標高さ
                    getAssessmentStart += ' ,dmg_tail_lense_right_width__c ';        // テールレンズ右標横幅
                    getAssessmentStart += ' ,dmg_tail_lense_right_reason__c ';        // テールレンズ右再学習理由
                    getAssessmentStart += ' ,dmg_tail_lense_left__c ';        // テールレンズ左
                    getAssessmentStart += ' ,dmg_tail_lense_left_y__c ';        // テールレンズ左座標Y
                    getAssessmentStart += ' ,dmg_tail_lense_left_x__c ';        // テールレンズ左座標X
                    getAssessmentStart += ' ,dmg_tail_lense_left_height__c ';        // テールレンズ左座標高さ
                    getAssessmentStart += ' ,dmg_tail_lense_left_width__c ';        // テールレンズ左標横幅
                    getAssessmentStart += ' ,dmg_tail_lense_left_reason__c ';        // テールレンズ左再学習理由
                    getAssessmentStart += ' ,change_sobi__c ';        // 装備変更
                    getAssessmentStart += ' ,shaken_date_1__c ';        // 車検日１
                    getAssessmentStart += ' ,shaken_run_dist_1__c ';        // 車検証の走行距離１
                    getAssessmentStart += ' ,shaken_date_2__c ';        // 車検日２
                    getAssessmentStart += ' ,shaken_run_dist_2__c ';        // 車検証の走行距離２
                    getAssessmentStart += ' ,shaken_date_3__c ';        // 車検日３
                    getAssessmentStart += ' ,shaken_run_dist_3__c ';        // 車検証の走行距離３
                    getAssessmentStart += ' ,no_run_dist__c ';        // 距離記載なし
                    getAssessmentStart += ' ,gaihin_meter__c ';        // 外品メーター
                    getAssessmentStart += ' ,abnormal_dist__c ';        // 車検証上記載の距離異常
                    getAssessmentStart += ' ,mentenance_note__c ';        // メンテナンスノート
                    getAssessmentStart += ' ,changed_kisai__c ';        // 交換歴の記載
                    getAssessmentStart += ' ,changed_conpany_stamp__c ';        // 交換業者の社印
                    getAssessmentStart += ' ,assess_tokki__c ';        // 査定時特記事項等記入欄
                    getAssessmentStart += ' ,front_url__c ';        // 正面URL
                    getAssessmentStart += ' ,right_front_url__c ';        // 右前URL
                    getAssessmentStart += ' ,left_front_url__c ';        // 左前URL
                    getAssessmentStart += ' ,left_back_url__c ';        // 左後ろURL
                    getAssessmentStart += ' ,right_back_url__c ';        // 右後ろURL
                    getAssessmentStart += ' ,other_url_04__c ';        // その他URL4
                    getAssessmentStart += ' ,other_url_05__c ';        // その他URL5
                    getAssessmentStart += ' ,other_url_06__c ';        // その他URL6
                    getAssessmentStart += ' ,other_url_07__c ';        // その他URL7
                    getAssessmentStart += ' ,other_url_08__c ';        // その他URL8
                    getAssessmentStart += ' ,other_url_09__c ';        // その他URL9
                    getAssessmentStart += ' ,other_url_10__c ';        // その他URL10
                    getAssessmentStart += ' ,other_url_11__c ';        // その他URL11
                    getAssessmentStart += ' ,other_url_12__c ';        // その他URL12
                    getAssessmentStart += ' ,other_url_13__c ';        // その他URL13
                    getAssessmentStart += ' ,other_url_14__c ';        // その他URL14
                    getAssessmentStart += ' ,other_url_15__c ';        // その他URL15
                    getAssessmentStart += ' ,other_url_16__c ';        // その他URL16
                    getAssessmentStart += ' ,other_url_17__c ';        // その他URL17
                    getAssessmentStart += ' ,other_url_18__c ';        // その他URL18
                    getAssessmentStart += ' ,other_url_19__c ';        // その他URL19
                    getAssessmentStart += ' ,other_url_20__c ';        // その他URL20
                    getAssessmentStart += ' ,other_url_21__c ';        // その他URL21  pj2451033　追加
                    getAssessmentStart += ' ,other_url_22__c ';        // その他URL22  pj2451033　追加
                    getAssessmentStart += ' ,other_url_23__c ';        // その他URL23  pj2451033　追加
                    getAssessmentStart += ' ,other_url_24__c ';        // その他URL24  pj2451033　追加
                    getAssessmentStart += ' ,other_url_25__c ';        // その他URL25  pj2451033　追加
                    getAssessmentStart += ' ,other_url_26__c ';        // その他URL26  pj2451033　追加
                    getAssessmentStart += ' ,other_url_27__c ';        // その他URL27  pj2451033　追加
                    getAssessmentStart += ' ,other_url_28__c ';        // その他URL28  pj2451033　追加
                    getAssessmentStart += ' ,other_url_29__c ';        // その他URL29  pj2451033　追加
                    getAssessmentStart += ' ,other_url_30__c ';        // その他URL30  pj2451033　追加
                    getAssessmentStart += ' ,other_url_31__c ';        // その他URL31  pj2451033　追加
                    getAssessmentStart += ' ,other_url_32__c ';        // その他URL32  pj2451033　追加
                    getAssessmentStart += ' ,other_url_33__c ';        // その他URL33  pj2451033　追加
                    getAssessmentStart += ' ,other_url_34__c ';        // その他URL34  pj2451033　追加
                    getAssessmentStart += ' ,other_url_35__c ';        // その他URL35  pj2451033　追加
                    getAssessmentStart += ' ,other_url_36__c ';        // その他URL36  pj2451033　追加
                    getAssessmentStart += ' ,other_url_37__c ';        // その他URL37  pj2451033　追加
                    getAssessmentStart += ' ,other_url_38__c ';        // その他URL38  pj2451033　追加
                    getAssessmentStart += ' ,other_url_39__c ';        // その他URL39  pj2451033　追加
                    getAssessmentStart += ' ,other_url_40__c ';        // その他URL40  pj2451033　追加
                    getAssessmentStart += ' ,shakensho_url__c ';        // 車検証URL
                    getAssessmentStart += ' ,auc_market_price__c ';        // オークション相場
                    getAssessmentStart += ' ,auc_repair_market_price__c ';        // 修復歴相場
                    getAssessmentStart += ' ,auc_repair_price__c ';        // 修理金額
                    getAssessmentStart += ' ,auc_sales_price__c ';        // 売り金額
                    getAssessmentStart += ' ,auc_kibo_price__c ';        // 先方希望額
                    getAssessmentStart += ' ,auc_competitor__c ';        // 競合数
                    getAssessmentStart += ' ,auc_compe_price__c ';        // 競合額
                    getAssessmentStart += ' ,auc_submit_price__c ';        // 提示金額
                    getAssessmentStart += ' ,auc_kettei_yoteibi__c ';        // 決定予定日
                    getAssessmentStart += ' ,auc_hanbai_date__c ';        // 販売月
                    getAssessmentStart += ' ,auc_buy_condition__c ';        // 買取条件
                    getAssessmentStart += ' ,auc_meigi_henko_date__c ';        // 名義変更年月
                    getAssessmentStart += ' ,auc_tax_price__c ';        // 消費税
                    getAssessmentStart += ' ,auc_other__c ';        // その他
                    getAssessmentStart += ' ,tokki_other__c ';        // 特記事項（その他）
                    getAssessmentStart += ' ,tolabel(tokki_other__c) tokki_other__c_label ';         // 特記事項（その他）（ラベル）
                    getAssessmentStart += ' ,tokki_engine__c ';        // 特記事項（エンジン）
                    getAssessmentStart += ' ,tolabel(tokki_engine__c) tokki_engine__c_label ';        // 特記事項（エンジン）（ラベル）
                    getAssessmentStart += ' ,tokki_oil__c ';        // 特記事項（オイル）
                    getAssessmentStart += ' ,tolabel(tokki_oil__c) tokki_oil__c_label ';        // 特記事項（オイル）（ラベル）
                    getAssessmentStart += ' ,tokki_check_rump__c ';        // 特記事項（チェックランプ）
                    getAssessmentStart += ' ,tolabel(tokki_check_rump__c) tokki_check_rump__c_label ';        // 特記事項（チェックランプ）（ラベル）
                    getAssessmentStart += ' ,tokki_bug__c ';        // 特記事項（不具合）
                    getAssessmentStart += ' ,tolabel(tokki_bug__c) tokki_bug__c_label ';        // 特記事項（不具合）（ラベル）
                    getAssessmentStart += ' ,tokki_inner__c ';        // 特記事項（内装）
                    getAssessmentStart += ' ,tolabel(tokki_inner__c) tokki_inner__c_label ';        // 特記事項（内装）（ラベル）
                    getAssessmentStart += ' ,tokki_torihazusi__c ';        // 特記事項（取り外し）
                    getAssessmentStart += ' ,tolabel(tokki_torihazusi__c) tokki_torihazusi__c_label ';        // 特記事項（取り外し）（ラベル）
                    getAssessmentStart += ' ,tokki_outer__c ';        // 特記事項（外装）
                    getAssessmentStart += ' ,tolabel(tokki_outer__c) tokki_outer__c_label ';        // 特記事項（外装）（ラベル）
                    getAssessmentStart += ' ,tokki_keppin__c ';        // 特記事項（欠品／備品不具合）
                    getAssessmentStart += ' ,tolabel(tokki_keppin__c) tokki_keppin__c_label ';        // 特記事項（欠品／備品不具合）（ラベル）
                    getAssessmentStart += ' ,tokki_sobi__c ';        // 特記事項（装備）
                    getAssessmentStart += ' ,tolabel(tokki_sobi__c) tokki_sobi__c_label ';        // 特記事項（装備）（ラベル）
                    getAssessmentStart += ' ,dmg_pillar_right_B__c ';        // ピラー右B
                    getAssessmentStart += ' ,dmg_pillar_right_C__c ';        // ピラー右C
                    getAssessmentStart += ' ,dmg_pillar_left_A__c ';        // ピラー左A
                    getAssessmentStart += ' ,dmg_pillar_left_B__c ';        // ピラー左B
                    getAssessmentStart += ' ,dmg_pillar_left_C__c ';        // ピラー左C
                    getAssessmentStart += ' ,tokki__c ';        // 特記事項
                    //getAssessmentStart += ' ,tokki_japanese__c ';        // 特記事項（日本語）
                    //getAssessmentStart += ' ,tokki_eizi__c ';        // 特記事項（英語）
                    //getAssessmentStart += ' ,tokki_russian__c ';        // 特記事項（ロシア語）
                    //getAssessmentStart += ' ,tokki_chinese__c ';        // 特記事項（中国語）
                    //getAssessmentStart += ' ,tokki_spanish__c ';        // 特記事項（スペイン語）
                    getAssessmentStart += ' ,dmg_oil_pam__c ';        // オイルパン
                    getAssessmentStart += ' ,dmg_core_support__c ';        // コアサポート
                    getAssessmentStart += ' ,dmg_first_mem__c ';        // ファーストメンバー
                    getAssessmentStart += ' ,dmg_close_mem__c ';        // クロスメンバー
                    getAssessmentStart += ' ,dmg_engine_mem__c ';        // エンジンメンバー
                    getAssessmentStart += ' ,SendDateToAuctionSite__c ';       // オークションサイトへの送信日時
                    getAssessmentStart += ' ,truck_type__c ';        // トラックの種類
                    getAssessmentStart += ' ,truck_cabin__c ';        // キャビン
                    getAssessmentStart += ' ,truck_bed__c ';        // ベッド
                    getAssessmentStart += ' ,truck_suspension_front__c ';        // サスペンション（前）
                    getAssessmentStart += ' ,truck_suspension_back__c ';        // サスペンション（後）
                    getAssessmentStart += ' ,truck_brake__c ';        // ブレーキ
                    getAssessmentStart += ' ,truck_aori_height__c ';        // あおり高さ
                    getAssessmentStart += ' ,truck_bed_length__c ';        // 荷台長
                    getAssessmentStart += ' ,truck_pto__c ';        // PTO
                    getAssessmentStart += ' ,truck_hydraulic_fluid__c ';        // 作動油
                    getAssessmentStart += ' ,truck_freezer_temp__c ';        // 冷凍機設定温度
                    getAssessmentStart += ' ,truck_freezer__c ';        // 冷凍機
                    getAssessmentStart += ' ,truck_insulation_thick__c ';        // 断熱材厚み
                    getAssessmentStart += ' ,truck_wing__c ';        // ウイング動作確認
                    getAssessmentStart += ' ,truck_dump__c ';        // ダンプ動作確認
                    getAssessmentStart += ' ,truck_dump_type__c ';        // ダンプ方式
                    getAssessmentStart += ' ,truck_aerial_work__c ';        // 高所作業車作動確認
                    getAssessmentStart += ' ,truck_crane_boom__c ';        // クレーン段数
                    getAssessmentStart += ' ,truck_crane__c ';        // クレーン動作確認
                    getAssessmentStart += ' ,truck_outrigger__c ';        // アウトリガー動作確認
                    getAssessmentStart += ' ,truck_radicon__c ';        // ラジコン
                    getAssessmentStart += ' ,truck_bucket_material__c ';        // バケット材質
                    getAssessmentStart += ' ,truck_loader_dump__c ';        // ローダーダンプ確認
                    getAssessmentStart += ' ,truck_loader__c ';        // ローダー動作確認
                    getAssessmentStart += ' ,postAuctionErrReason__c ';  // オークション連携エラー理由
                    getAssessmentStart += ' FROM ';
                    getAssessmentStart += ' Assessment__c ';
                    getAssessmentStart += ' WHERE ';
                    getAssessmentStart += ' suspended_flg__c  = false And ';
                    getAssessmentStart += ' error_flg__c  = false And ';
                    getAssessmentStart += ' SendDateToAuctionSite__c  = null And';
                    getAssessmentStart += ' RecordType.DeveloperName = \'yard\' ';
            
        System.debug('getAssessmentStart : ' + getAssessmentStart);
        return Database.getQueryLocator(getAssessmentStart);
   }
    /**
     * execute method
     */
    public void execute(Database.BatchableContext bc, List<Assessment__c> scope){

        System.debug('AssessmentGetBatch execute method Start');
        System.debug('scope.size() : ' + scope.size());
        PostAssessmentBatchHelper batchHelper = new PostAssessmentBatchHelper();

        try{
            System.debug('Call PostAssessmentBatchHelper From Batch');
            batchHelper.postBatch(scope);
        }
        catch(Exception e){
            System.debug('AssessmentGetBatch Error : ' + e);
            //エラーメール送信先を取得
            List<String> mailList = new List<String>();
            String mailAddress = System.Label.SnedErrMailAddress;

            if(String.isNotBlank(mailAddress)){
                mailList.add(mailAddress);
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                // 送信先(String[])
                mail.setToAddresses(mailList);
                // 件名(String)
                mail.setSubject(AssetConstants.MSG_AUCTION_SENDBATCH_EXCEPTION_SUBJECT);
                // 本文(String)
                String mailBody = AssetConstants.MSG_EXCEPTION_ERROR + e.getMessage();
                mail.setPlainTextBody(mailBody);
                // 送信者表示名。組織のメールアドレス使用時は設定不可。
                mail.setSenderDisplayName(AssetConstants.MSG_AUCTION_SENDBATCH_EXCEPTION_DISPLAYNAME);
                // 著名の有無。デフォルトはtrue。
                mail.setUseSignature(false);
                // メール送信
                List<Messaging.SendEmailResult> results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail}, false);
                System.debug('ERR : ' + mail);
                System.debug('エラーメッセージ' + results[0].getErrors());
            if (!results[0].isSuccess()) {
                    // メール送信に失敗した場合はロールバックさせないためにExceptionを発生させない
                } 
            }
            else{
                throw(e);
            }
        }
        System.debug('AssessmentGetBatch execute method End');
    }

    /**
     * finish method
     */
    public void finish(Database.BatchableContext bc){
        System.debug('AssessmentGetBatch finish method');
    }
}