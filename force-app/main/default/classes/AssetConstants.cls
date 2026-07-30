/*
 * 定数定義クラス
 */
public with sharing class AssetConstants {

    // オブジェクト名
    public static final String MAKER = 'Mst_Makers__c';     // メーカー
    public static final String MODEL = 'Mst_Models__c';     // 車種
    public static final String ASSESS_TANTO = 'Mst_Assess_Users__c';     // 査定ユーザ

    // 項目名
    public static final String MANAGE_BUMON = 'manage_org__c';     // 統括部門

    // クラス名
    public static final String AUCTION_SEND_SCHEDULE_CLASS = 'AssessmentGetBatchScheduleCon';     // ヤード査定表自動送信バッチスケジュールクラス
    


    // ガバナ回避定義
    // 検索結果の件数
    public static final Integer MAX_SEARCH_DATA_LIMIT = 2000;

    // メッセージ定義
    public static final String MSG_SYSTEM_ERROR = 'システムエラーが発生しました。<br/>検索結果が５万件を超えている可能性があります。<br/>検索条件を絞って再度検索を実行してください。<br/>それでもエラーとなる場合はシステム管理者にご連絡ください。<br/>エラーメッセージ： {0}';
    public static final String MSG_MAX_DATA_LIMIT_ERROR = '検索結果が' + String.valueOf(MAX_SEARCH_DATA_LIMIT) + '件を超えています。<br/>検索条件を増やして対象データを絞り込んでください。';
    public static final String MSG_REQUIRED_ERROR = '*マークが付いた条件を1つ以上設定して下さい。';
    public static final String MSG_AUCTION_ERROR = 'ヤード査定表をオークションサイトへ自動送信する処理でエラーが発生しました。\nsalesforceおよびオークションサイトをご確認ください。\n以下が自動送信できなかった査定表です。\n';
    public static final String MSG_EXCEPTION_ERROR = 'ヤード査定表をオークションサイトへ自動送信するAPI処理で例外処理が発生しました。\n';
    public static final String MSG_AUCTION_SENDBATCH_EXCEPTION_SUBJECT = 'ヤード査定表の自動送信処理で例外が発生しました';
    public static final String MSG_AUCTION_SENDBATCH_EXCEPTION_DISPLAYNAME = 'ヤード査定表自動送信例外処理';
    public static final String MSG_AUCTION_SENDBATCH_ERROR_SUBJECT = 'ヤード査定表の自動送信処理でエラーが発生しました';
    public static final String MSG_AUCTION_SENDBATCH_ERROR_DISPLAYNAME = 'ヤード査定表自動送信エラー処理';

    // 曜日（英語⇒日本語）
    public static final Map<String, String> DAY_OF_THE_WEEK = new Map<String, String>{
        'Sun' => '日'
        , 'Mon' => '月'
        , 'Tue' => '火'
        , 'Wed' => '水'
        , 'Thu' => '木'
        , 'Fri' => '金'
        , 'Sat' => '土'
    };

    // タイムゾーン
    public static final String TIMEZONE = 'Asia/Tokyo';
}