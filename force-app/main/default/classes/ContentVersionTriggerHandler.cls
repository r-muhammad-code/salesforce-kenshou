public without sharing class ContentVersionTriggerHandler {

    // ヘルパークラス
    ContentVersionTriggerHelper helper = new ContentVersionTriggerHelper();
    public ContentVersionTriggerHandler() {

    }

    public void OnAfterInsert(List<ContentVersion> targets) {
        System.debug('■■■ OnAfterInsert-START ■■■');
        
        helper.CreateAuctionInfo(targets);

        System.debug('■■■ OnAfterInsert-END ■■■');

    }
}