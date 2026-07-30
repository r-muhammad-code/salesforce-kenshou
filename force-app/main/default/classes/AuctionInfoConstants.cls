public with sharing class AuctionInfoConstants {
    public AuctionInfoConstants() {

    }

    // 画像URL
    public static final String IMAGE_URL_BASE = '/sfc/servlet.shepherd/version/renditionDownload?rendition=ORIGINAL_Jpg&versionId=';

    // 画像ファイル名末尾No
    public static final String IMAGE_NO_1ST = '1';
    public static final String IMAGE_NO_2ND = '2';
    public static final String IMAGE_NO_3RD = '3';
    public static final String IMAGE_NO_4TH = '4';
    public static final String IMAGE_NO_5TH = '5';
    public static final String IMAGE_NO_6TH = '6';

    // ソートキー
    public static final String SORT_KEY_SOLDDATE = 'soldDate';          // 売却日
    public static final String SORT_KEY_SOLDAMOUNT = 'soldAmount';      // 売却金額
    public static final String SORT_KEY_SELFRUN = 'selfRun';            // 自走
    // クエリで使用するソートキー
    public static final String SORT_KEY_QUERY_SOLDDATE = 'SoldData__c';          // 売却日
    public static final String SORT_KEY_QUERY_SOLDAMOUNT = 'auc_sales_price__c';      // 売却金額
    public static final String SORT_KEY_QUERY_SELFRUN = 'jiso__c';            // 自走

    // エラーメッセージ
    public static final String NULL_RESULT_MSG = '直近1年で取り扱いがございません。';

}