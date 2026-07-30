public without sharing class AuctionInfoDao {
    // コンストラクタ
    public AuctionInfoDao() {
    }

    public List<AuctionInformation__c> getAuctionInfo(String carModel, String carType, String carYear, String sortKey, String order) {
        // SELECT
        String soqlBase = '';
        soqlBase += ' SELECT ';
        soqlBase += ' Id ';
        soqlBase += ' , Name ';                 // 名前
        soqlBase += ' , car_type__c ';          // 型式
        soqlBase += ' , car_model__c ';         // 車種
        soqlBase += ' , car_grade__c ';         // グレード
        soqlBase += ' , engine__c ';            // エンジン
        soqlBase += ' , cell__c ';              // セル
        soqlBase += ' , SoldData__c ';          // 売却日
        soqlBase += ' , auc_sales_price__c ';   // 売却金額
        soqlBase += ' , registerdAtYear__c ';   // 年式
        soqlBase += ' , ControlNumber__c ';     // 管理番号
        soqlBase += ' , jiso__c ';              // 自走
        soqlBase += ' , run_dist__c ';          // 走行距離
        soqlBase += ' FROM ';
        soqlBase += ' AuctionInformation__c ';

        // WHERE
        String SoqlWhere = ' WHERE ';

        // 車種(検索値がある場合、検索条件に追加)
        if (String.isNotBlank(carModel)) {
            SoqlWhere += 'car_model__c = ' + '\'' + carModel + '\'';
        }else{
            SoqlWhere += 'car_model__c = ' + null;
        }
        
        // 型式(検索値がある場合、検索条件に追加)
        if (String.isNotBlank(carType)) {
            SoqlWhere += ' AND (car_type__c = ' + null + ' OR car_type__c = ' + '\'' + carType + '\')';
        }
        
        // 年式(検索値がある場合、検索条件に追加)
        if (String.isNotBlank(carYear)) {
            SoqlWhere += ' AND (registerdAtYear__c = ' + null + ' OR registerdAtYear__c = ' + '\'' + carYear + '\')';
        }

        // ORDER BY
        String soqlOrder = '';
        soqlOrder += ' ORDER BY ' + sortKey + ' ' + order;
        // クエリ実行
        List<AuctionInformation__c> auctionInfoList = Database.query(soqlBase + soqlWhere + soqlOrder);
        return auctionInfoList;
    }
    
    /**
     * コンテンツドキュメントリンクを取得する
     * コンテンツドキュメントリンクを軸に、親のコンテンツドキュメントから以下の項目を取得する
     * ・タイトル
     * ・最新の公開バージョンID（ContentsVersionのID）
     * 
     */
    public List<ContentDocumentLink> getContentDocumentLink(Set<Id> objectId) {
        system.debug('TargetLinkedEntityId');
        system.debug(objectId);
        List<ContentDocumentLink> linkList = [ SELECT ContentDocumentId                             // コンテンツドキュメントID
                                                    , Id                                            // ID
                                                    , LinkedEntityId                                // リンク済みエンティティID
                                                    , ContentDocument.Title                         // コンテンツドキュメント.タイトル
                                                    , ContentDocument.LatestPublishedVersionId      // 最新の公開バージョンID
                                                    FROM ContentDocumentLink
                                                    WHERE LinkedEntityId = :objectId ];
        return linkList;
    }

}