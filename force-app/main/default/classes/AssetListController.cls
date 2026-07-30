/*
 * 査定表検索コントローラ
 */
public without sharing class AssetListController extends AssetCommonController {
    // transient public List<Assessment__c> assetResults { get;set; } // 査定表の検索結果リスト
    public List<Assessment__c> assetResults { get;set; } // 査定表の検索結果リスト
    public Assessment__c assess {get;set;}              // 査定表
    public AssetCondition condition{ get;set; }         // 検索条件
    public String sortingField { get;set; }             // 見出しのソート用リンクを押された際のフィールド名
    public AssetUtil assetUtil;                         // 査定表ユーティリティ

    /**
     * 初期化処理
     */
    public void init(){
        System.debug('■■■ init() Start ■■■');

        this.condition = new AssetCondition();
        this.assetResults = new List<Assessment__c>();

        System.debug('■■■ init() End ■■■');
    }

    // コンストラクタ
    public AssetListController(){
        System.debug('■■■ コンストラクタ Start ■■■');

        this.assess = new Assessment__c();
        this.assetUtil = new AssetUtil();

        System.debug('■■■ コンストラクタ End ■■■');
    }

    /**
     * クリアボタン処理
     */
    public PageReference clear(){
        System.debug('■■■ clear() Start ■■■');
        init();
        return null;
    }

    /**
     * 検索ボタン処理
     */
    public PageReference search() {
        System.debug('■■■ search() Start ■■■');

        this.assetResults = new List<Assessment__c>();

        this.totalPageNumber = 1;
        this.pageNumber = 1;
        this.firstRow = 0;

        // 入力チェック
        // ApexPages.Message message = this.checkInput(condition);
        // if(message != null){
        //     ApexPages.addMessage(message);
        //     return null;
        // }

        // 査定表検索実行
        try{
            String qAsset = assetUtil.getAssessQuery(condition);
            System.debug('[soql] ' + qAsset);
//            cmUtil.logDivString(qDeliver);
            this.assetResults = database.query(qAsset);
            System.debug('assetResults :' + assetResults);
            //cmUtil.logDivString(deliverResults);

            if (assetResults != null && !assetResults.isEmpty()) {
                this.totalPageNumber = util.totalPageNumber(this.assetResults.size(), pageSize);
                if (assetResults.size() >= AssetConstants.MAX_SEARCH_DATA_LIMIT) {
                    // 2000件を超えている場合はエラーにする。
                    assetResults.clear();
                    throw new ErrResultException (AssetConstants.MSG_MAX_DATA_LIMIT_ERROR);
                }
            }
            
        } catch (ErrResultException e) {
            ApexPages.Message message_system = new ApexPages.Message( ApexPages.severity.ERROR, e.getMessage());
            ApexPages.addMessage(message_system);
        } catch (Exception e) {
            ApexPages.Message message_system = new ApexPages.Message( ApexPages.severity.ERROR, AssetConstants.MSG_SYSTEM_ERROR, e.getMessage());
            ApexPages.addMessage(message_system);
        } finally {
        }
        return null;
    }

    /**
     * ソート条件をリセットしてから検索
     */
    public PageReference sortInitSearch(){
        System.debug('■■■ sortInitSearch() Start ■■■');
        this.sortingField = 'asset_mngno__c';
        this.condition.sortkey = 'asset_mngno__c';
        this.condition.order = 'DESC';

        search();
        return null;
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


    /**
     * 必須項目のいずれか一つが入力されているかチェック
     * 一つ以上入力あり：True
     * 一つも入力なし：False
     */
    // public ApexPages.Message checkInput(AssetCondition sc){
    //     if(
    //         (sc.AssessDateStart == null)
    //         && (sc.AssessDateEnd == null)
    //         && (sc.ManageBumon == null || sc.ManageBumon.isEmpty())
    //     ){
    //         ApexPages.Message message = new ApexPages.Message( ApexPages.severity.ERROR, AssetConstants.MSG_REQUIRED_ERROR); 
    //         return message;
    //     }
    //     return null;
    // }

    // 車種リスト（メーカーを選択された時に取得）
    public List<SelectOption> getModelList(){
        system.debug('condition.Maker : '+ condition.Maker);
        return util.getModelSelectList(condition.Maker);
    }

    // 査定担当者リスト（統括部門を選択された時に取得）
    public List<SelectOption> getAssessTantoList(){
        system.debug('condition.ManageBumon : '+ condition.ManageBumon);
        return util.getAssessTantoSelectList(condition.ManageBumon);
    }

    public Double getOffset(){
        TimeZone tz = Timezone.getTimeZone(AssetConstants.TIMEZONE);
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }

}