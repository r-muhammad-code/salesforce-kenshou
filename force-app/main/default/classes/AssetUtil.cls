public without sharing class AssetUtil {

    private AssetCommonUtility cmUtil;      // 査定表ユーティリティ

    // コンストラクタ
    public AssetUtil() {
        this.cmUtil = new AssetCommonUtility();
    }

    /**************************************************************/
    /* 査定表取得
    /**************************************************************/
    // 抽出対象となるフィールドリスト
    static List<String> ASEESS_TARGET_FIELDS = new List<String>{
         'id'               // sfid
        ,'asset_mngno__c'               // 査定表管理No.
        // ,'account__c'                // 取引先
        // ,'oppotunity__c'             // 買取商談
        // ,'RecordTypeId'              // レコードタイプ ID
        ,'manage_bumon__c'              // 統括部門
        // ,'ai_use_umu__c'             // AI判定使用有無
        // ,'sv_sync_date__c'               // サーバ同期日時
        // ,'suspended_flg__c'              // 中断フラグ
        // ,'store__c'              // 依頼店
        ,'asses_date__c'                // 査定年月日
        ,'car_number__c'                // ナンバー記入欄
        //,'asses_tanto__c'             // 査定担当者
        ,'asses_tanto__r.Name'              // 査定担当者
        ,'asses_tanto__r.manage_org__c'       // 査定担当者統括部門
        // ,'asses_tanto__r.login_user__c'       // 査定担当者ログインID
        ,'car_maker__r.Name'                // メーカ
        // ,'car_maker__r.inum__c'              // メーカinum
        ,'car_model__r.Name'                // 車種
        // ,'car_model__r.inum__c'              // 車種inum
        ,'car_grade__r.Name'                // グレード
        ,'car_type__r.Name'             // 型式
        // ,'car_hist__c'               // 車歴
        // ,'car_hist_other__c'             // 車歴その他
        // ,'point__c'              // 評価点
        // ,'inner_point__c'                // 内装評価
        // ,'registerdAtGengo__c'               // 初年度登録（元号）
        // ,'registerdAtYear__c'                // 初年度登録（年）
        // ,'registerdAtMonth__c'               // 初年度登録（月）
        // ,'assess_regisit_no__c'              // 査定時登録No
        // ,'owner_regisit_no__c'               // 名義変更時登録No
        // ,'engine_katasiki__c'                // エンジン形式
        // ,'seizo_nensiki__c'              // 製造年式
        // ,'color_changed__c'              // 色替え
        // ,'full_katasiki__c'              // フル型式
        // ,'color_no__c'               // カラーNo.
        // ,'color__c'              // カラー
        // ,'inner_color__c'                // 内装色
        // ,'air_condition__c'              // 冷房
        // ,'seibi_techo_umu__c'                // 整備手帳有無
        // ,'shift__c'              // シフト
        // ,'katasiki_sitei_no__c'              // 型式指定番号
        // ,'ana_tacho__c'              // アナタコ
        // ,'key__c'                // カギ
        // ,'seizo_nen__c'              // 製造年式（年）
        // ,'seizo_getu__c'             // 製造年式（月）
        // ,'rui_kbn_no__c'             // 類別区分番号
        // ,'run_dist__c'               // 走行距離
        // ,'run_dist_unit__c'              // 走行距離単位
        // ,'run_kakunin__c'                // 実走確認
        // ,'haiki_ryo__c'              // 排気量（CC）
        // ,'sekisai_ryo__c'                // 積載量
        // ,'meter_disp__c'             // メーター表示
        // ,'fuel__c'               // 燃料
        // ,'fuel_ohter__c'             // 燃料その他
        // ,'shadai_no__c'              // 車台番号
        // ,'serial_no__c'              // シリアルNo
        // ,'teiin__c'              // 定員
        // ,'okiba__c'              // 置場
        // ,'shaken_inf__c'             // 車検情報
        // ,'shaken_nen__c'             // 車検付き年
        // ,'shaken_getu__c'                // 車検付き月
        // ,'jiso__c'               // 自走
        // ,'kudo__c'               // 駆動
        // ,'turbo__c'              // ターボ
        // ,'damage__c'             // ダメージ
        // ,'damage_other__c'               // ダメージその他
        // ,'cell__c'               // セル
        // ,'engine__c'             // エンジン
        // ,'engine_back__c'                // エンジン後退
        // ,'mission__c'                // ミッション
        // ,'radiator__c'               // ラジエター
        // ,'condenser__c'              // コンデンサー
        // ,'no_lift_use__c'                // リフト使用なし
        // ,'import_nen__c'             // 輸入車年式
        // ,'import_kbn__c'             // 輸入区分
        // ,'handle__c'             // ハンドル
        // ,'one_owner_kakunin__c'              // ワンオーナー確認
        // ,'prime_corner_shuppin__c'               // プライムコーナー出品
        // ,'sales_point__c'                // セールスポイント
        // ,'recycle_cost__c'               // リサイクル料金
        // ,'gojitu_okurihin__c'                // 後日送り品
        // ,'gojitu_okurihin_other__c'              // 後日送り品その他
        // ,'sobihin__c'                // 装備品等
        // ,'inspector_report__c'               // 検査員報告（修復不具合等）
        // ,'assess_warning__c'             // 査定時注意事項（取り外し部品、買取条件等）
        // ,'track_shatai_no_dakoku__c'             // トラック車体番号打刻確認
        // ,'rent_register__c'              // レンタ登録
        // ,'owner_right__c'                // 所有権
        // ,'zansai__c'             // 残債
        // ,'inner_dust__c'             // 室内ゴミ
        // ,'shanai_tumikomi_parts__c'              // 社内積込パーツ
        // ,'tokki_sobi__c'             // 特記事項（装備）
        // ,'tokki_inner__c'                // 特記事項（内装）
        // ,'tokki_outer__c'                // 特記事項（外装）
        // ,'tokki_engine__c'               // 特記事項（エンジン）
        // ,'tokki_check_rump__c'               // 特記事項（チェックランプ）
        // ,'tokki_oil__c'              // 特記事項（オイル）
        // ,'tokki_bug__c'              // 特記事項（不具合）
        // ,'tokki_torihazusi__c'               // 特記事項（取り外し）
        // ,'tokki_keppin__c'               // 特記事項（欠品／備品不具合）
        // ,'tokki_other__c'                // 特記事項（その他）
        // ,'sobi_seat__c'              // シート
        // ,'sobi_aw__c'                // AW
        // ,'sobi_sunloof__c'               // サンルーフ
        // ,'sobi_tv__c'                // TV
        // ,'sobi_navi__c'              // NAVI
        // ,'sobi_ps__c'                // PS
        // ,'sobi_pw__c'                // PW
        // ,'sobi_pawer_slide_door_right__c'                // パワースライドドア右
        // ,'sobi_pawer_slide_door_left__c'             // パワースライドドア左
        // ,'sobi_navi_select__c'               // ナビ
        // ,'sobi_navi_other__c'                // ナビその他
        // ,'absb_driver__c'                // 運転席
        // ,'absb_sub__c'               // 助手席
        // ,'absb_side_right__c'                // サイド右
        // ,'absb_side_left__c'             // サイド左
        // ,'absb_driver_knee__c'               // 運転席ニー
        // ,'absb_sub_knee__c'              // 助手席ニー
        // ,'absb_curtain_right__c'             // カーテン右
        // ,'absb_curtain_left__c'              // カーテン左
        // ,'absb_driver_seat__c'               // 運転席シート
        // ,'absb_sub_seat__c'              // 助手席シート
        // ,'absb_belt_right__c'                // シートベルト右
        // ,'absb_belt_left__c'             // シートベルト左
        // ,'dmg_front_glass__c'                // フロントガラス
        // ,'dmg_front_glass_y__c'              // フロントガラス座標Y
        // ,'dmg_front_glass_x__c'              // フロントガラス座標X
        // ,'dmg_front_glass_height__c'             // フロントガラス座標高さ
        // ,'dmg_front_glass_width__c'              // フロントガラス座標横幅
        // ,'dmg_front_glass_reason__c'             // フロントガラス再学習理由
        // ,'dmg_front_bumper__c'               // フロントバンパー
        // ,'dmg_front_bumper_y__c'             // フロントバンパー座標Y
        // ,'dmg_front_bumper_x__c'             // フロントバンパー座標X
        // ,'dmg_front_bumper_height__c'                // フロントバンパー座標高さ
        // ,'dmg_front_bumper_width__c'             // フロントバンパー座標横幅
        // ,'dmg_front_bumper_reason__c'                // フロントバンパー再学習理由
        // ,'dmg_bonnet__c'             // ボンネット
        // ,'dmg_bonnet_y__c'               // ボンネット座標Y
        // ,'dmg_bonnet_x__c'               // ボンネット座標X
        // ,'dmg_bonnet_height__c'              // ボンネット座標高さ
        // ,'dmg_bonnet_width__c'               // ボンネット座標横幅
        // ,'dmg_bonnet_reason__c'              // ボンネット再学習理由
        // ,'dmg_loof_glass__c'             // ルーフガラス
        // ,'dmg_rear_glass__c'             // リアガラス
        // ,'dmg_rear_glass_y__c'               // リアガラス座標Y
        // ,'dmg_rear_glass_x__c'               // リアガラス座標X
        // ,'dmg_rear_glass_height__c'              // リアガラス座標高さ
        // ,'dmg_rear_glass_width__c'               // リアガラス座標横幅
        // ,'dmg_rear_glass_reason__c'              // リアガラス再学習理由
        // ,'dmg_rear_bumper__c'                // リアバンパー
        // ,'dmg_rear_bumper_y__c'              // リアバンパー座標Y
        // ,'dmg_rear_bumper_x__c'              // リアバンパー座標X
        // ,'dmg_rear_bumper_height__c'             // リアバンパー座標高さ
        // ,'dmg_rear_bumper_width__c'              // リアバンパー座標横幅
        // ,'dmg_rear_bumper_reason__c'             // リアバンパー再学習理由
        // ,'dmg_trunk__c'              // トランク／リアゲート
        // ,'dmg_trunk_y__c'                // トランク／リアゲート座標Y
        // ,'dmg_trunk_x__c'                // トランク／リアゲート座標X
        // ,'dmg_trunk_height__c'               // トランク／リアゲート座標高さ
        // ,'dmg_trunk_width__c'                // トランク／リアゲート座標横幅
        // ,'dmg_trunk_reason__c'               // トランク／リアゲート再学習理由
        // ,'dmg_dash_panel__c'             // ダッシュパネル
        // ,'dmg_back_panel__c'             // バックパネル
        // ,'dmg_room_floor__c'             // ルームフロア
        // ,'dmg_trunc_floor__c'                // トランクフロア
        // ,'dmg_head_light_right__c'               // ヘッドライト右
        // ,'dmg_head_light_right_y__c'             // ヘッドライト右座標Y
        // ,'dmg_head_light_right_x__c'             // ヘッドライト右座標X
        // ,'dmg_head_light_right_height__c'                // ヘッドライト右座標高さ
        // ,'dmg_head_light_right_width__c'             // ヘッドライト右座標横幅
        // ,'dmg_head_light_right_reason__c'                // ヘッドライト右再学習理由
        // ,'dmg_fender_right_front__c'             // フェンダー右前
        // ,'dmg_fender_right_front_y__c'               // フェンダー右前座標Y
        // ,'dmg_fender_right_front_x__c'               // フェンダー右前座標X
        // ,'dmg_fender_right_front_height__c'              // フェンダー右前座標高さ
        // ,'dmg_fender_right_front_width__c'               // フェンダー右前座標横幅
        // ,'dmg_fender_right_front_reason__c'              // フェンダー右前再学習理由
        // ,'dmg_fender_right_back__c'              // フェンダー右後
        // ,'dmg_fender_right_back_y__c'                // フェンダー右後座標Y
        // ,'dmg_fender_right_back_x__c'                // フェンダー右後座標X
        // ,'dmg_fender_right_back_height__c'               // フェンダー右後座標高さ
        // ,'dmg_fender_right_back_width__c'                // フェンダー右後座標横幅
        // ,'dmg_fender_right_back_reason__c'               // フェンダー右後再学習理由
        // ,'dmg_door_right_front__c'               // ドア右前
        // ,'dmg_door_right_front_y__c'             // ドア右前座標Y
        // ,'dmg_door_right_front_x__c'             // ドア右前座標X
        // ,'dmg_door_right_front_height__c'                // ドア右前座標高さ
        // ,'dmg_door_right_front_width__c'             // ドア右前座標横幅
        // ,'dmg_door_right_front_reason__c'                // ドア右前再学習理由
        // ,'dmg_door_right_back__c'                // ドア右後
        // ,'dmg_door_right_back_y__c'              // ドア右後座標Y
        // ,'dmg_door_right_back_x__c'              // ドア右後座標X
        // ,'dmg_door_right_back_height__c'             // ドア右後座標高さ
        // ,'dmg_door_right_back_width__c'              // ドア右後座標横幅
        // ,'dmg_door_right_back_reason__c'             // ドア右後再学習理由
        // ,'dmg_pillar_right_A__c'             // ピラー右A
        // ,'dmg_pillar_right_B__c'             // ピラー右B
        // ,'dmg_pillar_right_C__c'             // ピラー右C
        // ,'dmg_side_step_right__c'                // サイドステップ右
        // ,'dmg_front_side_mem_right__c'               // フロントサイドメンバー右
        // ,'dmg_rear_side_mem_right__c'                // リアサイドメンバー右
        // ,'dmg_head_light_left__c'                // ヘッドライト左
        // ,'dmg_head_light_left_y__c'              // ヘッドライト左座標Y
        // ,'dmg_head_light_left_x__c'              // ヘッドライト左座標X
        // ,'dmg_head_light_left_height__c'             // ヘッドライト左座標高さ
        // ,'dmg_head_light_left_width__c'              // ヘッドライト左座標横幅
        // ,'dmg_head_light_left_reason__c'             // ヘッドライト左再学習理由
        // ,'dmg_fender_left_front__c'              // フェンダー左前
        // ,'dmg_fender_left_front_y__c'                // フェンダー左前座標Y
        // ,'dmg_fender_left_front_x__c'                // フェンダー左前座標X
        // ,'dmg_fender_left_front_height__c'               // フェンダー左前座標高さ
        // ,'dmg_fender_left_front_width__c'                // フェンダー左前座標横幅
        // ,'dmg_fender_left_front_reason__c'               // フェンダー左前再学習理由
        // ,'dmg_fender_left_back__c'               // フェンダー左後
        // ,'dmg_fender_left_back_y__c'             // フェンダー左後座標Y
        // ,'dmg_fender_left_back_x__c'             // フェンダー左後座標X
        // ,'dmg_fender_left_back_height__c'                // フェンダー左後座標高さ
        // ,'dmg_fender_left_back_width__c'             // フェンダー左後座標横幅
        // ,'dmg_fender_left_back_reason__c'                // フェンダー左後再学習理由
        // ,'dmg_door_left_front__c'                // ドア左前
        // ,'dmg_door_left_front_y__c'              // ドア左前座標Y
        // ,'dmg_door_left_front_x__c'              // ドア左前座標X
        // ,'dmg_door_left_front_height__c'             // ドア左前座標高さ
        // ,'dmg_door_left_front_width__c'              // ドア左前座標横幅
        // ,'dmg_door_left_front_reason__c'             // ドア左前再学習理由
        // ,'dmg_door_left_back__c'             // ドア左後
        // ,'dmg_door_left_back_y__c'               // ドア左後座標Y
        // ,'dmg_door_left_back_x__c'               // ドア左後座標X
        // ,'dmg_door_left_back_height__c'              // ドア左後座標高さ
        // ,'dmg_door_left_back_width__c'               // ドア左後座標横幅
        // ,'dmg_door_left_back_reason__c'              // ドア左後再学習理由
        // ,'dmg_pillar_left_A__c'              // ピラー左A
        // ,'dmg_pillar_left_B__c'              // ピラー左B
        // ,'dmg_pillar_left_C__c'              // ピラー左C
        // ,'dmg_side_step_left__c'             // サイドステップ左
        // ,'dmg_front_side_mem_left__c'                // フロントサイドメンバー左
        // ,'dmg_rear_side_mem_left__c'             // リアサイドメンバー左
        // ,'dmg_asi_right_front__c'                // 足回り右前
        // ,'dmg_asi_right_front_y__c'              // 足回り右前座標Y
        // ,'dmg_asi_right_front_x__c'              // 足回り右前座標X
        // ,'dmg_asi_right_front_height__c'             // 足回り右前座標高さ
        // ,'dmg_asi_right_front_width__c'              // 足回り右前標横幅
        // ,'dmg_asi_right_front_reason__c'             // 足回り右前再学習理由
        // ,'dmg_asi_right_back__c'             // 足回り右後
        // ,'dmg_asi_right_back_y__c'               // 足回り右後座標Y
        // ,'dmg_asi_right_back_x__c'               // 足回り右後座標X
        // ,'dmg_asi_right_back_height__c'              // 足回り右後座標高さ
        // ,'dmg_asi_right_back_width__c'               // 足回り右後標横幅
        // ,'dmg_asi_right_back_reason__c'              // 足回り右後再学習理由
        // ,'dmg_asi_left_front__c'             // 足回り左前
        // ,'dmg_asi_left_front_y__c'               // 足回り左前座標Y
        // ,'dmg_asi_left_front_x__c'               // 足回り左前座標X
        // ,'dmg_asi_left_front_height__c'              // 足回り左前座標高さ
        // ,'dmg_asi_left_front_width__c'               // 足回り左前標横幅
        // ,'dmg_asi_left_front_reason__c'              // 足回り左前再学習理由
        // ,'dmg_asi_left_back__c'              // 足回り左後
        // ,'dmg_asi_left_back_y__c'                // 足回り左後座標Y
        // ,'dmg_asi_left_back_x__c'                // 足回り左後座標X
        // ,'dmg_asi_left_back_height__c'               // 足回り左後座標高さ
        // ,'dmg_asi_left_back_width__c'                // 足回り左後標横幅
        // ,'dmg_asi_left_back_reason__c'               // 足回り左後再学習理由
        // ,'dmg_oil_pam__c'                // オイルパン
        // ,'dmg_core_support__c'               // コアサポート
        // ,'dmg_first_mem__c'              // ファーストメンバー
        // ,'dmg_close_mem__c'              // クロスメンバー
        // ,'dmg_engine_mem__c'             // エンジンメンバー
        // ,'dmg_tail_lense_right__c'               // テールレンズ右
        // ,'dmg_tail_lense_right_y__c'             // テールレンズ右座標Y
        // ,'dmg_tail_lense_right_x__c'             // テールレンズ右座標X
        // ,'dmg_tail_lense_right_height__c'                // テールレンズ右座標高さ
        // ,'dmg_tail_lense_right_width__c'             // テールレンズ右標横幅
        // ,'dmg_tail_lense_right_reason__c'                // テールレンズ右再学習理由
        // ,'dmg_tail_lense_left__c'                // テールレンズ左
        // ,'dmg_tail_lense_left_y__c'              // テールレンズ左座標Y
        // ,'dmg_tail_lense_left_x__c'              // テールレンズ左座標X
        // ,'dmg_tail_lense_left_height__c'             // テールレンズ左座標高さ
        // ,'dmg_tail_lense_left_width__c'              // テールレンズ左標横幅
        // ,'dmg_tail_lense_left_reason__c'             // テールレンズ左再学習理由
        // ,'change_sobi__c'                // 装備変更
        // ,'shaken_date_1__c'              // 車検日１
        // ,'shaken_run_dist_1__c'              // 車検証の走行距離１
        // ,'shaken_date_2__c'              // 車検日２
        // ,'shaken_run_dist_2__c'              // 車検証の走行距離２
        // ,'shaken_date_3__c'              // 車検日３
        // ,'shaken_run_dist_3__c'              // 車検証の走行距離３
        // ,'no_run_dist__c'                // 距離記載なし
        // ,'gaihin_meter__c'               // 外品メーター
        // ,'abnormal_dist__c'              // 車検証上記載の距離異常
        // ,'mentenance_note__c'                // メンテナンスノート
        // ,'changed_kisai__c'              // 交換歴の記載
        // ,'changed_conpany_stamp__c'              // 交換業者の社印
        // ,'assess_tokki__c'               // 査定時特記事項等記入欄
        // ,'front_url__c'              // 正面URL
        // ,'right_front_url__c'                // 右前URL
        // ,'left_front_url__c'             // 左前URL
        // ,'left_back_url__c'              // 左後ろURL
        // ,'right_back_url__c'             // 右後ろURL
        // ,'room_url__c'               // 室内URL
        // ,'engine_url__c'             // エンジンルームURL
        // ,'cotion_url__c'             // コーションURL
        // ,'key_url__c'                // カギURL
        // ,'meter_url__c'              // メーターURL
        // ,'other_url_01__c'               // その他URL1
        // ,'other_url_02__c'               // その他URL2
        // ,'other_url_03__c'               // その他URL3
        // ,'other_url_04__c'               // その他URL4
        // ,'other_url_05__c'               // その他URL5
        // ,'other_url_06__c'               // その他URL6
        // ,'other_url_07__c'               // その他URL7
        // ,'other_url_08__c'               // その他URL8
        // ,'other_url_09__c'               // その他URL9
        // ,'other_url_10__c'               // その他URL10
        // ,'other_url_11__c'               // その他URL11
        // ,'other_url_12__c'               // その他URL12
        // ,'other_url_13__c'               // その他URL13
        // ,'other_url_14__c'               // その他URL14
        // ,'other_url_15__c'               // その他URL15
        // ,'other_url_16__c'               // その他URL16
        // ,'other_url_17__c'               // その他URL17
        // ,'other_url_18__c'               // その他URL18
        // ,'other_url_19__c'               // その他URL19
        // ,'other_url_20__c'               // その他URL20
        // ,'shakensho_url__c'              // 車検証URL
        // ,'shuppin_url_01__c'             // 出品用URL1
        // ,'shuppin_url_02__c'             // 出品用URL2
        // ,'shuppin_url_03__c'             // 出品用URL3
        // ,'shuppin_url_04__c'             // 出品用URL4
        // ,'shuppin_url_05__c'             // 出品用URL5
        // ,'shuppin_url_06__c'             // 出品用URL6
        // ,'shuppin_url_07__c'             // 出品用URL7
        // ,'shuppin_url_08__c'             // 出品用URL8
        // ,'shuppin_url_09__c'             // 出品用URL9
        // ,'shuppin_url_10__c'             // 出品用URL10
        // ,'shuppin_url_11__c'             // 出品用URL11
        // ,'shuppin_url_12__c'             // 出品用URL12
        // ,'shuppin_url_13__c'             // 出品用URL13
        // ,'shuppin_url_14__c'             // 出品用URL14
        // ,'shuppin_url_15__c'             // 出品用URL15
        // ,'shuppin_url_16__c'             // 出品用URL16
        // ,'shuppin_url_17__c'             // 出品用URL17
        // ,'shuppin_url_18__c'             // 出品用URL18
        // ,'shuppin_url_19__c'             // 出品用URL19
        // ,'shuppin_url_20__c'             // 出品用URL20
        // ,'shuppin_url_21__c'             // 出品用URL21
        // ,'shuppin_url_22__c'             // 出品用URL22
        // ,'shuppin_url_23__c'             // 出品用URL23
        // ,'shuppin_url_24__c'             // 出品用URL24
        // ,'shuppin_url_25__c'             // 出品用URL25
        // ,'shuppin_url_26__c'             // 出品用URL26
        // ,'shuppin_url_27__c'             // 出品用URL27
        // ,'shuppin_url_28__c'             // 出品用URL28
        // ,'shuppin_url_29__c'             // 出品用URL29
        // ,'shuppin_url_30__c'             // 出品用URL30
        // ,'auc_market_price__c'               // オークション相場
        // ,'auc_repair_market_price__c'                // 修復歴相場
        // ,'auc_repair_price__c'               // 修理金額
        // ,'auc_sales_price__c'                // 売り金額
        // ,'auc_kibo_price__c'             // 先方希望額
        // ,'auc_competitor__c'             // 競合数
        // ,'auc_compe_price__c'                // 競合額
        // ,'auc_submit_price__c'               // 提示金額
        // ,'auc_kettei_yoteibi__c'             // 決定予定日
        // ,'auc_hanbai_date__c'                // 販売月
        // ,'auc_buy_condition__c'              // 買取条件
        // ,'auc_meigi_henko_date__c'               // 名義変更年月
        // ,'auc_tax_price__c'              // 消費税
        // ,'auc_other__c'              // その他
        ,'front_url__c'                          // 正面画像URL  
        ,'right_front_url__c'                  // 右前画像URL  
        ,'right_back_url__c'                   // 右後画像URL  
        ,'left_front_url__c'                   // 左前画像URL  
        ,'left_back_url__c'                    // 左後画像URL  
        ,'shakensho_url__c'                    // 車検証画像URL  
    };

    // 抽出対象となるオブジェクトリスト
    static List<String> ASSESS_TARGET_OBJECTS = new List<String>{
        'Assessment__c assessment'
    };


    // 最初の査定表を取得するSOQLを作成
    public String getAssessQuery(AssetCondition sc){
        List<String> param = new String[]{ getAssessFieldList(), getAssessObjectList(), getAssessWhere(sc), getAssessOrder(sc) };
        System.debug('SOQL : ' + String.format('SELECT {0} FROM {1} {2} ORDER BY {3} ', param));
        return String.format('SELECT {0} FROM {1} {2} ORDER BY {3} ', param);
    }

    // SELECT対象フィールド
    private String getAssessFieldList(){
        System.debug('SELECT : ' + String.join(ASEESS_TARGET_FIELDS, ','));
        return String.join(ASEESS_TARGET_FIELDS, ',');
    }

    // FROM対象フィールド
    private String getAssessObjectList(){
        System.debug('FROM : ' + String.join(ASSESS_TARGET_OBJECTS, ','));
        return String.join(ASSESS_TARGET_OBJECTS, ',');
    }

    // WHERE句作成
    private String getAssessWhere(AssetCondition sc){
        List<String> param = new String[]{ };

        // 検索条件に応じたWHERE句
        getAssessConditionWhere(param, sc);

        if(param.isEmpty()){
            return '';
        }

        System.debug('WHERE : ' + String.join(param, ' AND '));
        return ' WHERE ' + String.join(param, ' AND ');
    }

    // 検索対象を決定するWHERE句を作成する。
    private void getAssessConditionWhere(List<String> param, AssetCondition sc){

        if(sc != null) {
            
            // 査定日(開始日)
            if( sc.AssessDateStart != ''){
                param.add('asses_date__c >= ' + sc.AssessDateStart.replaceAll('/','-') + 'T00:00:00.000+09:00');
            }
            // 査定日(終了日)
            if( sc.AssessDateEnd != ''){
                param.add('asses_date__c <= ' + sc.AssessDateEnd.replaceAll('/','-') + 'T23:59:59.999+09:00');
            }
            // メーカー
            if( sc.Maker != null && !sc.Maker.isEmpty() && sc.Maker != new List<String>{'blank'}){
                param.add('car_maker__r.inum__c IN ' + cmUtil.convertSingleQuote(sc.Maker));
            }
            // 車種
            if( sc.Model != null && !sc.Model.isEmpty() && sc.Model != new List<String>{'blank'}){
                param.add('car_model__r.inum__c IN ' + cmUtil.convertSingleQuote(sc.Model));
            }
            // 統括部門
            if( sc.ManageBumon != null && !sc.ManageBumon.isEmpty() && sc.ManageBumon != new List<String>{'blank'}){
                param.add('asses_tanto__r.manage_org__c IN ' + cmUtil.convertSingleQuote(sc.ManageBumon));
            }
            // 査定担当者
            if( sc.AssessTanto != null && !sc.AssessTanto.isEmpty() && sc.AssessTanto != new List<String>{'blank'}){
                param.add('asses_tanto__r.login_user__c IN ' + cmUtil.convertSingleQuote(sc.AssessTanto));
            }
        }
    }


    // ORDERBY句作成
    private String getAssessOrder(AssetCondition sc){
        System.debug('ORDERBY句作成 ' + sc.order);
        String ord = sc.order;
        if(sc.order == 'ASC'){
            ord += ' NULLS FIRST';
        }
        else if(sc.order == 'DESC'){
            ord += ' NULLS LAST';
        }

        List<String> param = new String[]{ sc.sortkey, ord };
        System.debug('ORDER BY : ' + String.format('{0} {1}', param));
        return String.format('{0} {1}', param);
    }


}