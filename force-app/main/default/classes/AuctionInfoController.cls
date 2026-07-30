/*
 * 査定表検索コントローラ
 */
public without sharing class AuctionInfoController extends AssetCommonController {
    public List<AuctionInformation__c> assetResults { get;set; } // 査定表の検索結果リスト
    public AuctionCondition condition { get;set; }         // 検索条件
    public String sortingField { get;set; }             // 見出しのソート用リンクを押された際のフィールド名
    public AssetUtil assetUtil;                         // 査定表ユーティリティ
    public AccountAssessment__c accAsse { get;set; }         // 取引先査定表レコード
    public AuctionInfoDao aucInfoDao = new AuctionInfoDao();        // オークション情報DAOインスタンス
    public AuctionInfoHelper helper = new AuctionInfoHelper();
    public List<resultCls> rcList {get; set;}

    /**
     * 初期化処理
     */
    public void init(){
        System.debug('■■■ init() Start ■■■');

        this.condition = new AuctionCondition();
        search();
        System.debug('■■■ init() End ■■■');
    }

    // コンストラクタ
    public AuctionInfoController(ApexPages.StandardController stdController){
        System.debug('■■■ コンストラクタ Start ■■■');
        // オークション情報を表示した取引先査定表を取得
        this.accAsse = (AccountAssessment__c)stdController.getRecord();
        this.assetUtil = new AssetUtil();

        System.debug('■■■ コンストラクタ End ■■■');
    }

    /**
     * 検索処理
     */
    public PageReference search() {
        System.debug('■■■ search() Start ■■■');

        this.assetResults = new List<AuctionInformation__c>();
        this.totalPageNumber = 1;
        this.pageNumber = 1;
        this.firstRow = 0;
        this.rcList = new List<resultCls>();
        this.pageSize = Integer.valueOf(System.Label.AuctionInfoPageDataSize);
        // オークション情報 検索条件
        String carModel = accAsse.car_model__r.Name;          // 車種
        String carYear = accAsse.registerdAtYear__c;          // 年式
        String carType = accAsse.car_type__r.Name;            // 型式
        String currentSortKey = this.condition.sortkey;       // 現在のソートキー
        String querySortKey = this.condition.sortkey;         // クエリで使用するソートキー
        String Order = this.condition.order;                  // ソート順
        Set<Id> auctionInfoId = new Set<Id>();

        // オークション情報検索実行
        try {
            // オークション情報を取得する
            this.assetResults = aucInfoDao.getAuctionInfo(carModel, carType, carYear, querySortKey, Order);
            if (this.assetResults == null || this.assetResults.size() == 0){
                return null;
            }

            // オークション情報のIDを取得する
            for (AuctionInformation__c res : assetResults) {
                auctionInfoId.add(res.Id);
            }
            // コンテンツバージョン(画像)を取得する
            Map<Id, List<ContentDocumentLink>> imgMap = getFile (auctionInfoId);
            System.debug('★イメージ取得結果 : ' + imgMap);

            // オークション情報と画像を1つにまとめる
            for (AuctionInformation__c aucInfo : assetResults) {
                resultCls rc = new resultCls();
                rc.firstResisteredYear = aucInfo.registerdAtYear__c;
                rc.carModel = aucInfo.car_model__c;
                rc.carType = aucInfo.car_type__c;
                rc.grade = aucInfo.car_grade__c;
                rc.runDist = aucInfo.run_dist__c;
                rc.cell = aucInfo.cell__c;
                rc.engine = aucInfo.engine__c;
                rc.selfRun = aucInfo.jiso__c;
                rc.soldDate = aucInfo.SoldData__c;
                rc.soldAmount = aucInfo.auc_sales_price__c;
                for (ContentDocumentLink cdl : imgMap.get(aucInfo.id)) {
                    System.debug('★画像の内容 : ' + cdl);
                    System.debug('★画像のタイトル : ' + cdl.ContentDocument.Title);
                    System.debug('★画像の紐付け先オブジェクト : ' + cdl.ContentDocument.LatestPublishedVersionId);
                    if (aucInfo.Id == cdl.LinkedEntityId) {
                        System.debug('★画像URLセット開始');
                        // 1番目の画像をセットする
                        if (helper.getImgFileNameNumber(cdl.ContentDocument.Title) == AuctionInfoConstants.IMAGE_NO_1ST) {
                            rc.imgUrl1 = AuctionInfoConstants.IMAGE_URL_BASE + cdl.ContentDocument.LatestPublishedVersionId;
                        }
                        // 2番目の画像をセットする
                        if (helper.getImgFileNameNumber(cdl.ContentDocument.Title) == AuctionInfoConstants.IMAGE_NO_2ND) {
                            rc.imgUrl2 = AuctionInfoConstants.IMAGE_URL_BASE + cdl.ContentDocument.LatestPublishedVersionId;
                        }
                        // 3番目の画像をセットする
                        if (helper.getImgFileNameNumber(cdl.ContentDocument.Title) == AuctionInfoConstants.IMAGE_NO_3RD) {
                            rc.imgUrl3 = AuctionInfoConstants.IMAGE_URL_BASE + cdl.ContentDocument.LatestPublishedVersionId;
                        }
                        // 4番目の画像をセットする
                        if (helper.getImgFileNameNumber(cdl.ContentDocument.Title) == AuctionInfoConstants.IMAGE_NO_4TH) {
                            rc.imgUrl4 = AuctionInfoConstants.IMAGE_URL_BASE + cdl.ContentDocument.LatestPublishedVersionId;
                        }
                        // 5番目の画像をセットする
                        if (helper.getImgFileNameNumber(cdl.ContentDocument.Title) == AuctionInfoConstants.IMAGE_NO_5TH) {
                            rc.imgUrl5 = AuctionInfoConstants.IMAGE_URL_BASE + cdl.ContentDocument.LatestPublishedVersionId;
                        }
                        // 6番目の画像をセットする
                        if (helper.getImgFileNameNumber(cdl.ContentDocument.Title) == AuctionInfoConstants.IMAGE_NO_6TH) {
                            rc.imgUrl6 = AuctionInfoConstants.IMAGE_URL_BASE + cdl.ContentDocument.LatestPublishedVersionId;
                        }
                    }
                }
                rcList.add(rc);
            }
            // 取得結果判定
            if (assetResults != null && !assetResults.isEmpty()) {
                this.totalPageNumber = util.totalPageNumber(this.assetResults.size(), this.pageSize);
                if (assetResults.size() >= AssetConstants.MAX_SEARCH_DATA_LIMIT) {
                    // 2000件を超えている場合はエラーにする。
                    assetResults.clear();
                    throw new ErrResultException (AssetConstants.MSG_MAX_DATA_LIMIT_ERROR);
                }
            }
        } catch (ErrResultException e) {
            ApexPages.Message message_system = new ApexPages.Message( ApexPages.severity.ERROR, e.getMessage());
            ApexPages.addMessage(message_system);
        } finally {
        }
        return null;
    }

    public class resultCls {
        public String firstResisteredYear {get; set;}      // 初年度登録日
        public String carModel {get; set;}                 // 車種名
        public String grade {get; set;}                    // グレード
        public String carType {get; set;}                  // 型式
        public Decimal runDist {get; set;}                 // 走行距離
        public String engine {get; set;}                   // エンジン
        public String cell {get; set;}                     // セル
        public String selfRun {get; set;}                  // 自走
        public Date soldDate {get; set;}                   // 売却日
        public Decimal soldAmount {get; set;}              // 売却金額
        public String imgUrl1 {get; set;}                  // 画像URL1
        public String imgUrl2 {get; set;}                  // 画像URL2
        public String imgUrl3 {get; set;}                  // 画像URL3
        public String imgUrl4 {get; set;}                  // 画像URL4
        public String imgUrl5 {get; set;}                  // 画像URL5
        public String imgUrl6 {get; set;}                  // 画像URL6
    }

    /**
    * 添付ファイル取得
    */ 
    public Map<Id, List<ContentDocumentLink>> getFile(Set<Id> objId){
        Map<Id, List<ContentDocumentLink>> res = new Map<Id, List<ContentDocumentLink>>();
        
        // コンテンツドキュメントリンクを取得する
        List<ContentDocumentLink> links = aucInfoDao.getContentDocumentLink(objId);

        for(ContentDocumentLink cdLink: links){
            if(!res.containsKey(cdLink.LinkedEntityId)){
                res.put(cdLink.LinkedEntityId, new List<ContentDocumentLink>());
            }
            res.get(cdLink.LinkedEntityId).add(cdLink);
        }
        System.debug('★コンテンツドキュメントリンク　取得結果 : ' + links);
        return res;
    }


    /**
     * ソートリンク処理
     */
    public PageReference sort(){
        System.debug('■■■ sort() Start ■■■');

        // ソートを行う対象フィールドが不明な場合は何もしない
        if(this.sortingField == null ){
            return null;
        }

        // ソートを行う対象が、現在ソートしているフィールドと同じ場合はソート順を反対にする
        if(this.sortingField == this.condition.sortkey){
            this.condition.setOrderReverse();
        }
        // ソートを行う対象が、現在ソートしているフィールドと違う場合は新しい項目でソートするようにする
        else {
            this.condition.sortkey = this.sortingField;
            this.condition.order = 'ASC';
        }

        // 検索実行
        search();
        return null;
    }

    /**
     * 現在のソートキーを取得するためのメソッド
     * 
     * ・検索結果の見出しにソート順を出すために使う
     * ・本来はgetSortOrderも含めて、ロジックもApex側で持ちたいが、
     * 　VisualForceから引数ありでメソッドが呼べないため、このようにしている。
     * 
     */
    public String getSortKey(){
        return this.condition.sortkey;
    }

    /**
     * 現在のソート順を取得するためのメソッド（▲ or ▼を返す）
     */ 
    public String getSortOrder(){
        return this.condition.sortOrderToString();
    }

    public Double getOffset(){
        TimeZone tz = Timezone.getTimeZone(AssetConstants.TIMEZONE);
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }

}