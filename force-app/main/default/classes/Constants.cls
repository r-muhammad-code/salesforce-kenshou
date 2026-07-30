public with sharing class Constants {
    public static final String AUCTIONSITE_URL = System.Label.AuctionSiteURL;

    public static final Map<String, Map<Decimal, TranslationMaster__c>> MST_TRANSLATION = AssetCommonUtility.getTranslationMaster();

    public static final String LANG_JAPANESE = 'Japanese';
    public static final String LANG_ENGLISH = 'English';
    public static final String LANG_RUSSIAN = 'Russian';
    public static final String LANG_CHINESE = 'Chinese';
    public static final String LANG_SPANISH = 'Spanish';

    // コンテンツドキュメントリンク　Visibility項目の値
    public static final String CDL_VISIBILITY_ALL_USERS = 'AllUsers';
    // コンテンツドキュメントリンク　ShareType項目の値
    public static final String CDL_SHARE_TYPE_V = 'V';
}