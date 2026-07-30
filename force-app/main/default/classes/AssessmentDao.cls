public with sharing class AssessmentDao {
    public AssessmentDao() {

    }

    public List<Assessment__c> getAssessmentInfo(Id assId){
        return [
            SELECT
                Id
                ,Name        // 査定表名
                ,RecordtypeId      //レコードタイプID 20211027 HANA_SF_SATEI-205

                ,account__c        // 取引先
                ,account__r.Name        // ★取引先名
                ,SalesDataListing__c  //営業データ出品  20211027 HANA_SF_SATEI-205 

                ,store__c        // 依頼店
                ,yard_kbn__c         //ヤード区分 pj2451033追加
                ,LotNo_yard__c        // ロットNo　20220525 HANA_SF_SATEI-223
                ,ana_tacho__c        // アナタコ
                ,car_number__c        // ナンバー記入欄

                ,asses_tanto__c        // 査定担当者
                ,asses_tanto__r.Name        // ★査定担当者名

                ,car_maker__c        // メーカ名
                ,car_maker__r.maker__c        // メーカー（数字）
                ,car_maker__r.Name        // メーカ名
                ,car_maker__r.maker_name_eizi__c        // メーカー名（英語）

                ,car_model__c        // 車種名
                ,car_model__r.inum__c        // 車種（INUM）
                ,car_model__r.Name        // 車種名
                ,car_model__r.model_name_eizi__c        // 車種名英字

                // ,car_grade__c        // グレード名
                // ,car_grade__r.inum__c        // グレード（INUM）
                // ,car_grade__r.Name        // グレード名
                // ,car_grade__r.name_en__c        // グレード名英字

                ,damage_other__c        // ダメ―ジその他
                ,registerdAtYear__c        // 初年度登録（年）
                // ,registerdAtMonth__c        // 初年度登録（月）
                // ,engine_katasiki__c        // エンジン形式
                ,seizo_nensiki__c        // 製造年式
                ,color_no__c        // カラーNo.
                ,color__c        // カラー
                ,tolabel(color__c) color__c_label        // カラー（ラベル）
//                ,color_eizi__c        // カラー（英語）
                ,handle__c        // ハンドル 20210823追加
                ,shift__c        // シフト
                ,tolabel(shift__c) shift__c_label        // シフト（ラベル）
                // ,katasiki_sitei_no__c        // 型式指定番号
                ,room_url__c        // 室内URL
                ,key__c        // アナタコカギ
                ,seizo_getu__c        // 製造年式（月）
                // ,rui_kbn_no__c        // 類別区分番号
                ,run_dist__c        // 走行距離
                ,run_dist_unit__c        // 走行距離単位
                ,run_kakunin__c        // 実走確認
                // ,haiki_ryo__c        // 排気量（CC）
                // ,meter_disp__c        // メーター表示
                // ,fuel__c        // 燃料
                ,fuel_ohter__c        // 燃料その他
                //,teiin__c        // 定員
                ,okiba__c        // 置場（自由入力）
                ,okiba_select__c        // 置場
                ,tolabel(okiba_select__c) okiba_select__c_label        // 置場（ラベル）
                ,shaken_inf__c        // 車検情報
                ,shaken_nen__c        // 車検付き年
                ,shaken_getu__c        // 車検付き月
                ,jiso__c        // 自走
                ,kudo__c        // 駆動
                ,engine_url__c        // エンジンルームURL
                ,UsedcarEvaluationpoints__c        // 中古車査定時評価点 20210823追加
                ,UsedcarInnerEvaluationpoints__c        // 中古車査定時内装評価点 20210823追加
                ,damage__c        // ダメージ
                ,tolabel(damage__c) damage__c_label        // ダメージ（ラベル）
//                ,damage_eizi__c        // ダメージ（英語）
//                ,damage_russian__c        // ダメージ（ロシア語）
                ,cell__c        // セル
                ,engine__c        // エンジン
                ,engine_back__c        // エンジン後退
                ,engine_ng__c        // エンジンNG
                ,mission__c        // ミッション
                ,radiator__c        // ラジエター
                ,condenser__c        // コンデンサー
                ,rent_register__c        // レンタ登録
                ,owner_right__c        // 所有権
                ,zansai__c        // 残債
                ,inner_dust__c        // 室内ゴミ
                ,shanai_tumikomi_parts__c        // 社内積込パーツ
//                ,tolabel(shanai_tumikomi_parts__c) shanai_tumikomi_parts__c_label         // 社内積込パーツ（ラベル）
                ,tanto_manage_bumon__c        // 統括部門
                ,sobi_seat__c        // シート
                ,cotion_url__c        // コーションURL
                ,key_url__c        // カギURL
                ,meter_url__c        // メーターURL
                ,steering_url__c        // ステアリングURL　pj2451033　追加
                ,center_console_url__c   // センターコンソールURL　pj2451033　追加
                ,front_seat_url__c        // 前席シートURL　pj2451033　追加
                ,switch1_url__c        // スイッチ類➀URL　pj2451033　追加
                ,switch2_url__c        // スイッチ類➁URL　pj2451033　追加
                ,other_url_01__c        // その他URL1
                ,other_url_02__c        // その他URL2
                ,other_url_03__c        // その他URL3
                ,sobi_pawer_slide_door_right__c        // パワースライドドア右
//                ,tolabel(sobi_pawer_slide_door_right__c) sobi_pawer_slide_door_right__c_label         // パワースライドドア右（ラベル）
                ,sobi_navi_select__c        // ナビ
                ,sobi_navi_other__c        // ナビその他
                ,absb_driver__c        // 運転席
                ,absb_sub__c        // 助手席
                ,absb_side_right__c        // サイド右
                ,absb_side_left__c        // サイド左
                ,absb_driver_knee__c        // 運転席ニー
                ,absb_sub_knee__c        // 助手席ニー
                ,absb_curtain_right__c        // カーテン右
                ,absb_curtain_left__c        // カーテン左
                ,absb_driver_seat__c        // 運転席シート
                ,absb_sub_seat__c        // 助手席シート
                ,absb_airbag_right_back__c        // 後部座席右エアバッグ 20210823追加
                ,absb_airbag_left_back__c        // 後部座席左エアバッグ 20210823追加
                ,absb_belt_right__c        // シートベルト右
                ,absb_belt_right_back__c        // 後部座席シートベルト右 20210823追加
                ,absb_belt_left__c        // シートベルト左
                ,absb_belt_left_back__c        // 後部座席シートベルト左 20210823追加
                ,absb_active_headrest__c        // アクティブヘッドレスト 20210823追加
                ,absb_popup_hood__c        // ポップアップフード 20210823追加
                ,asset_mngno__c        // 査定表管理No.
                ,seizo_nen__c        // 製造年式（年）

                ,oppotunity__c        // 買取商談
                ,oppotunity__r.Name        // ★買取商談名
                ,oppotunity__r.Mst_Types__r.inum__c        // 型式（INUM）　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Mst_Types__r.Name        // 型式名　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.engine_form__c        // エンジン型式　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.form_num__c        // 型式指定番号　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.bunrui_num__c        // 類別区分番号　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.CarNo__c        // 車台番号　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.run_contents__c        // メーター状態　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.ModelYearPickList__c    // 年式　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.First_year_registration__c        // 初年度登録月　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Except_First_year_registration__c        // 初年度月除外　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.fuel__c        // 燃料　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.teiin__c        // 定員　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.dis_volume__c        // 排気量　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.vehicle_length__c        // 長さ　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.vehicle_width__c        // 幅　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.vehicle_height__c        // 高さ　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.vehicle_weight__c        // 車輌重量　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.shaken_erase_year__c        // 車検期限年　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.shaken_erase_month__c        // 車検期限月　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Mst_Grades__r.inum__c        // グレード（INUM）　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Mst_Grades__r.Name        // グレード名　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.OpportunityID_18__c        // 買取商談ID（18ケタ）　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.exhibit_memo__c        // 注意事項　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.alert_memo__c        // 警告設定　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.setting_content__c        // 取・メン・保・スペア　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.auc_area__c        // 出品先　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.nyu_price__c        // 入札希望価格　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.expected_price__c        // 仕入希望価格　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.auc_sprice__c        // ライブ開始価格　  HANA_SF_SATEI-272　20241115追加
                ,oppotunity__r.Vehicle_Gross_Weight__c        // 車輌総重量
                ,oppotunity__r.maximum_payload__c        // 最大積載量

                ,manage_bumon__c        // 統括部門(テキスト)
                ,ai_use_umu__c        // AI判定使用有無
                ,sv_sync_date__c        // サーバ同期日時
                ,asses_date__c        // 査定年月日

                // ,car_type__c        // 型式
                // ,car_type__r.inum__c        // 型式（INUM）
                // ,car_type__r.Name        // 型式名

                ,full_katasiki__c        // フル型式
                ,shadai_no__c        // 車台番号
                ,turbo__c        // ターボ
                ,color_changed__c        // 色替え
                ,no_lift_use__c        // リフト使用なし
                ,manual__c        // 取説
                ,reserve1__c        // 保証書
                ,dmg_pillar_right_A__c        // ピラー右A
                ,sobi_aw__c        // AW
                ,sobi_sunloof__c        // サンルーフ
                ,sobi_tv__c        // TV
                ,sobi_navi__c        // NAVI
                ,sobi_ps__c        // PS
                ,sobi_pw__c        // PW
                ,sobi_ac__c        // A/C 20210823追加
                ,sobi_pawer_slide_door_left__c        // パワースライドドア左
//                ,tolabel(sobi_pawer_slide_door_left__c) sobi_pawer_slide_door_left__c_label        // パワースライドドア左（ラベル）
                ,dmg_front_glass__c        // フロントガラス
                ,dmg_front_glass_y__c        // フロントガラス座標Y
                ,dmg_front_glass_x__c        // フロントガラス座標X
                ,dmg_front_glass_height__c        // フロントガラス座標高さ
                ,dmg_front_glass_width__c        // フロントガラス座標横幅
                ,dmg_front_glass_reason__c        // フロントガラス再学習理由
                ,dmg_front_bumper__c        // フロントバンパー
                ,dmg_front_bumper_y__c        // フロントバンパー座標Y
                ,dmg_front_bumper_x__c        // フロントバンパー座標X
                ,dmg_front_bumper_height__c        // フロントバンパー座標高さ
                ,dmg_front_bumper_width__c        // フロントバンパー座標横幅
                ,dmg_front_bumper_reason__c        // フロントバンパー再学習理由
                ,dmg_bonnet__c        // ボンネット
                ,dmg_bonnet_y__c        // ボンネット座標Y
                ,dmg_bonnet_x__c        // ボンネット座標X
                ,dmg_bonnet_height__c        // ボンネット座標高さ
                ,dmg_bonnet_width__c        // ボンネット座標横幅
                ,dmg_bonnet_reason__c        // ボンネット再学習理由
                ,dmg_loof_glass__c        // ルーフガラス
                ,dmg_rear_glass__c        // リアガラス
                ,dmg_rear_glass_y__c        // リアガラス座標Y
                ,dmg_rear_glass_x__c        // リアガラス座標X
                ,dmg_rear_glass_height__c        // リアガラス座標高さ
                ,dmg_rear_glass_width__c        // リアガラス座標横幅
                ,dmg_rear_glass_reason__c        // リアガラス再学習理由
                ,dmg_rear_bumper__c        // リアバンパー
                ,dmg_rear_bumper_y__c        // リアバンパー座標Y
                ,dmg_rear_bumper_x__c        // リアバンパー座標X
                ,dmg_rear_bumper_height__c        // リアバンパー座標高さ
                ,dmg_rear_bumper_width__c        // リアバンパー座標横幅
                ,dmg_rear_bumper_reason__c        // リアバンパー再学習理由
                ,dmg_trunk__c        // トランク／リアゲート
                ,dmg_trunk_y__c        // トランク／リアゲート座標Y
                ,dmg_trunk_x__c        // トランク／リアゲート座標X
                ,dmg_trunk_height__c        // トランク／リアゲート座標高さ
                ,dmg_trunk_width__c        // トランク／リアゲート座標横幅
                ,dmg_trunk_reason__c        // トランク／リアゲート再学習理由
                ,dmg_dash_panel__c        // ダッシュパネル
                ,dmg_back_panel__c        // バックパネル
                ,dmg_room_floor__c        // ルームフロア
                ,dmg_trunc_floor__c        // トランクフロア
                ,dmg_head_light_right__c        // ヘッドライト右
                ,dmg_head_light_right_y__c        // ヘッドライト右座標Y
                ,dmg_head_light_right_x__c        // ヘッドライト右座標X
                ,dmg_head_light_right_height__c        // ヘッドライト右座標高さ
                ,dmg_head_light_right_width__c        // ヘッドライト右座標横幅
                ,dmg_head_light_right_reason__c        // ヘッドライト右再学習理由
                ,dmg_fender_right_front__c        // フェンダー右前
                ,dmg_fender_right_front_y__c        // フェンダー右前座標Y
                ,dmg_fender_right_front_x__c        // フェンダー右前座標X
                ,dmg_fender_right_front_height__c        // フェンダー右前座標高さ
                ,dmg_fender_right_front_width__c        // フェンダー右前座標横幅
                ,dmg_fender_right_front_reason__c        // フェンダー右前再学習理由
                ,dmg_fender_right_back__c        // フェンダー右後
                ,dmg_fender_right_back_y__c        // フェンダー右後座標Y
                ,dmg_fender_right_back_x__c        // フェンダー右後座標X
                ,dmg_fender_right_back_height__c        // フェンダー右後座標高さ
                ,dmg_fender_right_back_width__c        // フェンダー右後座標横幅
                ,dmg_fender_right_back_reason__c        // フェンダー右後再学習理由
                ,dmg_door_right_front__c        // ドア右前
                ,dmg_door_right_front_y__c        // ドア右前座標Y
                ,dmg_door_right_front_x__c        // ドア右前座標X
                ,dmg_door_right_front_height__c        // ドア右前座標高さ
                ,dmg_door_right_front_width__c        // ドア右前座標横幅
                ,dmg_door_right_front_reason__c        // ドア右前再学習理由
                ,dmg_door_right_back__c        // ドア右後
                ,dmg_door_right_back_y__c        // ドア右後座標Y
                ,dmg_door_right_back_x__c        // ドア右後座標X
                ,dmg_door_right_back_height__c        // ドア右後座標高さ
                ,dmg_door_right_back_width__c        // ドア右後座標横幅
                ,dmg_door_right_back_reason__c        // ドア右後再学習理由
                ,dmg_side_step_right__c        // サイドステップ右
                ,dmg_front_side_mem_right__c        // フロントサイドメンバー右
                ,dmg_rear_side_mem_right__c        // リアサイドメンバー右
                ,dmg_head_light_left__c        // ヘッドライト左
                ,dmg_head_light_left_y__c        // ヘッドライト左座標Y
                ,dmg_head_light_left_x__c        // ヘッドライト左座標X
                ,dmg_head_light_left_height__c        // ヘッドライト左座標高さ
                ,dmg_head_light_left_width__c        // ヘッドライト左座標横幅
                ,dmg_head_light_left_reason__c        // ヘッドライト左再学習理由
                ,dmg_fender_left_front__c        // フェンダー左前
                ,dmg_fender_left_front_y__c        // フェンダー左前座標Y
                ,dmg_fender_left_front_x__c        // フェンダー左前座標X
                ,dmg_fender_left_front_height__c        // フェンダー左前座標高さ
                ,dmg_fender_left_front_width__c        // フェンダー左前座標横幅
                ,dmg_fender_left_front_reason__c        // フェンダー左前再学習理由
                ,dmg_fender_left_back__c        // フェンダー左後
                ,dmg_fender_left_back_y__c        // フェンダー左後座標Y
                ,dmg_fender_left_back_x__c        // フェンダー左後座標X
                ,dmg_fender_left_back_height__c        // フェンダー左後座標高さ
                ,dmg_fender_left_back_width__c        // フェンダー左後座標横幅
                ,dmg_fender_left_back_reason__c        // フェンダー左後再学習理由
                ,dmg_door_left_front__c        // ドア左前
                ,dmg_door_left_front_y__c        // ドア左前座標Y
                ,dmg_door_left_front_x__c        // ドア左前座標X
                ,dmg_door_left_front_height__c        // ドア左前座標高さ
                ,dmg_door_left_front_width__c        // ドア左前座標横幅
                ,dmg_door_left_front_reason__c        // ドア左前再学習理由
                ,dmg_door_left_back__c        // ドア左後
                ,dmg_door_left_back_y__c        // ドア左後座標Y
                ,dmg_door_left_back_x__c        // ドア左後座標X
                ,dmg_door_left_back_height__c        // ドア左後座標高さ
                ,dmg_door_left_back_width__c        // ドア左後座標横幅
                ,dmg_door_left_back_reason__c        // ドア左後再学習理由
                ,dmg_side_step_left__c        // サイドステップ左
                ,dmg_front_side_mem_left__c        // フロントサイドメンバー左
                ,dmg_rear_side_mem_left__c        // リアサイドメンバー左
                ,dmg_asi_right_front__c        // 足回り右前
                ,dmg_asi_right_front_y__c        // 足回り右前座標Y
                ,dmg_asi_right_front_x__c        // 足回り右前座標X
                ,dmg_asi_right_front_height__c        // 足回り右前座標高さ
                ,dmg_asi_right_front_width__c        // 足回り右前標横幅
                ,dmg_asi_right_front_reason__c        // 足回り右前再学習理由
                ,dmg_asi_right_back__c        // 足回り右後
                ,dmg_asi_right_back_y__c        // 足回り右後座標Y
                ,dmg_asi_right_back_x__c        // 足回り右後座標X
                ,dmg_asi_right_back_height__c        // 足回り右後座標高さ
                ,dmg_asi_right_back_width__c        // 足回り右後標横幅
                ,dmg_asi_right_back_reason__c        // 足回り右後再学習理由
                ,dmg_asi_left_front__c        // 足回り左前
                ,dmg_asi_left_front_y__c        // 足回り左前座標Y
                ,dmg_asi_left_front_x__c        // 足回り左前座標X
                ,dmg_asi_left_front_height__c        // 足回り左前座標高さ
                ,dmg_asi_left_front_width__c        // 足回り左前標横幅
                ,dmg_asi_left_front_reason__c        // 足回り左前再学習理由
                ,dmg_asi_left_back__c        // 足回り左後
                ,dmg_asi_left_back_y__c        // 足回り左後座標Y
                ,dmg_asi_left_back_x__c        // 足回り左後座標X
                ,dmg_asi_left_back_height__c        // 足回り左後座標高さ
                ,dmg_asi_left_back_width__c        // 足回り左後標横幅
                ,dmg_asi_left_back_reason__c        // 足回り左後再学習理由
                ,dmg_tail_lense_right__c        // テールレンズ右
                ,dmg_tail_lense_right_y__c        // テールレンズ右座標Y
                ,dmg_tail_lense_right_x__c        // テールレンズ右座標X
                ,dmg_tail_lense_right_height__c        // テールレンズ右座標高さ
                ,dmg_tail_lense_right_width__c        // テールレンズ右標横幅
                ,dmg_tail_lense_right_reason__c        // テールレンズ右再学習理由
                ,dmg_tail_lense_left__c        // テールレンズ左
                ,dmg_tail_lense_left_y__c        // テールレンズ左座標Y
                ,dmg_tail_lense_left_x__c        // テールレンズ左座標X
                ,dmg_tail_lense_left_height__c        // テールレンズ左座標高さ
                ,dmg_tail_lense_left_width__c        // テールレンズ左標横幅
                ,dmg_tail_lense_left_reason__c        // テールレンズ左再学習理由
                ,change_sobi__c        // 装備変更
                ,shaken_date_1__c        // 車検日１
                ,shaken_run_dist_1__c        // 車検証の走行距離１
                ,shaken_date_2__c        // 車検日２
                ,shaken_run_dist_2__c        // 車検証の走行距離２
                ,shaken_date_3__c        // 車検日３
                ,shaken_run_dist_3__c        // 車検証の走行距離３
                ,no_run_dist__c        // 距離記載なし
                ,gaihin_meter__c        // 外品メーター
                ,abnormal_dist__c        // 車検証上記載の距離異常
                ,mentenance_note__c        // メンテナンスノート
                ,changed_kisai__c        // 交換歴の記載
                ,changed_conpany_stamp__c        // 交換業者の社印
                ,assess_tokki__c        // 査定時特記事項等記入欄
                ,front_url__c        // 正面URL
                ,right_front_url__c        // 右前URL
                ,left_front_url__c        // 左前URL
                ,left_back_url__c        // 左後ろURL
                ,right_back_url__c        // 右後ろURL
                ,other_url_04__c        // その他URL4
                ,other_url_05__c        // その他URL5
                ,other_url_06__c        // その他URL6
                ,other_url_07__c        // その他URL7
                ,other_url_08__c        // その他URL8
                ,other_url_09__c        // その他URL9
                ,other_url_10__c        // その他URL10
                ,other_url_11__c        // その他URL11
                ,other_url_12__c        // その他URL12
                ,other_url_13__c        // その他URL13
                ,other_url_14__c        // その他URL14
                ,other_url_15__c        // その他URL15
                ,other_url_16__c        // その他URL16
                ,other_url_17__c        // その他URL17
                ,other_url_18__c        // その他URL18
                ,other_url_19__c        // その他URL19
                ,other_url_20__c        // その他URL20
                ,other_url_21__c        // その他URL21 pj2451033　追加
                ,other_url_22__c        // その他URL22 pj2451033　追加
                ,other_url_23__c        // その他URL23 pj2451033　追加
                ,other_url_24__c        // その他URL24 pj2451033　追加
                ,other_url_25__c        // その他URL25 pj2451033　追加
                ,other_url_26__c        // その他URL26 pj2451033　追加
                ,other_url_27__c        // その他URL27 pj2451033　追加
                ,other_url_28__c        // その他URL28 pj2451033　追加
                ,other_url_29__c        // その他URL29 pj2451033　追加
                ,other_url_30__c        // その他URL30 pj2451033　追加
                ,other_url_31__c        // その他URL31 pj2451033　追加
                ,other_url_32__c        // その他URL32 pj2451033　追加
                ,other_url_33__c        // その他URL33 pj2451033　追加
                ,other_url_34__c        // その他URL34 pj2451033　追加
                ,other_url_35__c        // その他URL35 pj2451033　追加
                ,other_url_36__c        // その他URL36 pj2451033　追加
                ,other_url_37__c        // その他URL37 pj2451033　追加
                ,other_url_38__c        // その他URL38 pj2451033　追加
                ,other_url_39__c        // その他URL39 pj2451033　追加
                ,other_url_40__c        // その他URL40 pj2451033　追加
                ,shakensho_url__c        // 車検証URL
                ,auc_market_price__c        // オークション相場
                ,auc_repair_market_price__c        // 修復歴相場
                ,auc_repair_price__c        // 修理金額
                ,auc_sales_price__c        // 売り金額
                ,auc_kibo_price__c        // 先方希望額
                ,auc_competitor__c        // 競合数
                ,auc_compe_price__c        // 競合額
                ,auc_submit_price__c        // 提示金額
                ,auc_kettei_yoteibi__c        // 決定予定日
                ,auc_hanbai_date__c        // 販売月
                ,auc_buy_condition__c        // 買取条件
                ,auc_meigi_henko_date__c        // 名義変更年月
                ,auc_tax_price__c        // 消費税
                ,auc_other__c        // その他
                ,tokki_other__c        // 特記事項（その他）
                ,tolabel(tokki_other__c) tokki_other__c_label         // 特記事項（その他）（ラベル）
                ,tokki_engine__c        // 特記事項（エンジン）
                ,tolabel(tokki_engine__c) tokki_engine__c_label        // 特記事項（エンジン）（ラベル）
                ,tokki_oil__c        // 特記事項（オイル）
                ,tolabel(tokki_oil__c) tokki_oil__c_label        // 特記事項（オイル）（ラベル）
                ,tokki_check_rump__c        // 特記事項（チェックランプ）
                ,tolabel(tokki_check_rump__c) tokki_check_rump__c_label        // 特記事項（チェックランプ）（ラベル）
                ,tokki_bug__c        // 特記事項（不具合）
                ,tolabel(tokki_bug__c) tokki_bug__c_label        // 特記事項（不具合）（ラベル）
                ,tokki_inner__c        // 特記事項（内装）
                ,tolabel(tokki_inner__c) tokki_inner__c_label        // 特記事項（内装）（ラベル）
                ,tokki_torihazusi__c        // 特記事項（取り外し）
                ,tolabel(tokki_torihazusi__c) tokki_torihazusi__c_label        // 特記事項（取り外し）（ラベル）
                ,tokki_outer__c        // 特記事項（外装）
                ,tolabel(tokki_outer__c) tokki_outer__c_label        // 特記事項（外装）（ラベル）
                ,tokki_keppin__c        // 特記事項（欠品／備品不具合）
                ,tolabel(tokki_keppin__c) tokki_keppin__c_label        // 特記事項（欠品／備品不具合）（ラベル）
                ,tokki_sobi__c        // 特記事項（装備）
                ,tolabel(tokki_sobi__c) tokki_sobi__c_label        // 特記事項（装備）（ラベル）
                ,dmg_pillar_right_B__c        // ピラー右B
                ,dmg_pillar_right_C__c        // ピラー右C
                ,dmg_pillar_left_A__c        // ピラー左A
                ,dmg_pillar_left_B__c        // ピラー左B
                ,dmg_pillar_left_C__c        // ピラー左C
                ,tokki__c        // 特記事項
//                ,tokki_japanese__c        // 特記事項（日本語）
//                ,tokki_eizi__c        // 特記事項（英語）
//                ,tokki_russian__c        // 特記事項（ロシア語）
//                ,tokki_chinese__c        // 特記事項（中国語）
//                ,tokki_spanish__c        // 特記事項（スペイン語）
                ,dmg_oil_pam__c        // オイルパン
                ,dmg_core_support__c        // コアサポート
                ,dmg_first_mem__c        // ファーストメンバー
                ,dmg_close_mem__c        // クロスメンバー
                ,dmg_engine_mem__c        // エンジンメンバー

                ,truck_type__c        // トラックの種類
                ,truck_cabin__c        // キャビン
                ,truck_bed__c        // ベッド
                ,truck_suspension_front__c        // サスペンション（前）
                ,truck_suspension_back__c        // サスペンション（後）
                ,truck_brake__c        // ブレーキ
                ,truck_aori_height__c        // あおり高さ
                ,truck_bed_length__c        // 荷台長
                ,truck_pto__c        // PTO
                ,truck_hydraulic_fluid__c        // 作動油
                ,truck_crane_boom__c        // クレーン段数
                ,truck_crane__c        // クレーン動作確認
                ,truck_radicon__c        // アウトリガー動作確認
                ,truck_freezer_temp__c        // ラジコン
                ,truck_insulation_thick__c        // ウイング動作確認
                ,truck_outrigger__c        // 冷凍機設定温度
                ,truck_wing__c        // 冷凍機
                ,truck_freezer__c        // 断熱材厚み
                ,truck_dump__c        // ダンプ動作確認
                ,truck_dump_type__c        // ダンプ方式
                ,truck_loader_dump__c        // ローダーダンプ確認
                ,truck_aerial_work__c        // 高所作業車作動確認
                ,truck_bucket_material__c        // バケット材質
                ,truck_loader__c        // ローダー動作確認

                ,SendDateToAuctionSite__c       // オークションサイトへの送信日時
            FROM
                Assessment__c
            WHERE
                Id = :assId
            LIMIT 1
        ];
    }
}