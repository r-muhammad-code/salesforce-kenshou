public without sharing class ContentVersionTriggerHelper {
    public ContentVersionTriggerHelper() {

    }

    public void CreateAuctionInfo(List<ContentVersion> targetList) {
        System.debug('■■■ CreateAuctionInfo-START ■■■');

        // オークション情報の作成
        Map<String, AuctionInformation__c> tempAuctionInfoMap = new Map<String, AuctionInformation__c>();
        for (ContentVersion cv : targetList) {
            if (!cv.isSet('ControlNumber__c') || cv.ControlNumber__c == ''){
                // オークション以外の画像なのでスキップ
                continue;
            }
            if (tempAuctionInfoMap.containsKey(cv.ControlNumber__c)) {
                // オークション作成済みなのでスキップ
                continue;
            }
            AuctionInformation__c auctionInfo = new AuctionInformation__c();
            auctionInfo.cell__c = cv.cell__c;                                   // セル
            auctionInfo.jiso__c = cv.jiso__c;                                   // 自走
            auctionInfo.engine__c = cv.engine__c;                               // エンジン
            auctionInfo.SoldData__c = cv.SoldData__c;                           // 売却日
            auctionInfo.car_type__c = cv.car_type__c;                           // 車種
            auctionInfo.car_grade__c = cv.car_grade__c;                         // グレード
            auctionInfo.car_model__c = cv.car_model__c;                         // 型式
            auctionInfo.ControlNumber__c = cv.ControlNumber__c;                 // 管理番号
            auctionInfo.registerdAtYear__c = cv.registerdAtYear__c;             // 年式
            auctionInfo.auc_sales_price__c = cv.auc_sales_price__c;             // 売却金額
            if (String.isNotBlank(cv.run_dist__c)) {
                auctionInfo.run_dist__c = Decimal.valueOf(cv.run_dist__c);      // 走行距離
            }
            // insert用のリストに追加
            tempAuctionInfoMap.put(auctionInfo.ControlNumber__c, auctionInfo);
        }

        if (tempAuctionInfoMap.size() == 0){
            // オークション情報が無ければ何もせず終了
            return;
        }

        // オークション情報 upsert(管理番号(ControlNumber__c)をキーに設定する)
        List<AuctionInformation__c> auctionInfoList = new List<AuctionInformation__c>(tempAuctionInfoMap.values());
        upsert auctionInfoList ControlNumber__c;

        // insertしたオークション情報をMapにセットする(Key：管理番号, Value：オークション情報)
        Map<String, AuctionInformation__c> auctionInfoMap = new Map<String, AuctionInformation__c>();
        for (AuctionInformation__c auc : auctionInfoList) {
            auctionInfoMap.put(auc.ControlNumber__c, auc);
        }

        // コンテンツドキュメントリンクの作成
        List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();
        for (ContentVersion tempCv : targetList) {
            ContentDocumentLink cdl = new ContentDocumentLink();
            if (auctionInfoMap.containsKey(tempCv.ControlNumber__c)) {
                cdl.LinkedEntityId = auctionInfoMap.get(tempCv.ControlNumber__c).Id;    // リンク済みエンティティID(リンクするオブジェクトのレコードID)
                cdl.ContentDocumentId = tempCv.ContentDocumentId;                       // コンテンツドキュメントID(添付ファイルのID)
                cdl.Visibility = Constants.CDL_VISIBILITY_ALL_USERS;                    // 表示
                cdl.ShareType = Constants.CDL_SHARE_TYPE_V;                             // 共有種別
                cdlList.add(cdl);
            }
        }

        // コンテンツドキュメントリンク insert
        insert cdlList;

        System.debug('■■■ CreateAuctionInfo-END ■■■');
    }
}