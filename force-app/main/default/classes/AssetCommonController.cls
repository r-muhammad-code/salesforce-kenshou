/*
 * 査定表コントローラ
 * 共通部分
 */
public virtual class AssetCommonController {

    // public AssetCondition cond;
    public AssetCommonUtility util;      // 一般ユーティリティ

    public List<SelectOption> makerList{ get; set; }        // メーカー選択リスト
    // public List<SelectOption> modelList{ get; set; }        // 車種選択リスト
    public List<SelectOption> manageBumonList{ get; set; }        // 統括部門選択リスト
    // public List<SelectOption> assessTantoList{ get; set; }        // 査定担当者選択リスト

    // 表示ページ
    public Integer pageNumber {get; set;}
    // トータルページ数
    public Integer totalPageNumber {get; set;}
    // 表示開始行
    public Integer firstRow{get; set;} 
    // 表示件数
    private static final Integer PAGE_SIZE = 10;
    public Integer pageSize = PAGE_SIZE;

    // コンストラクタ
    public AssetCommonController() {

        this.util = new AssetCommonUtility();

        // メーカー選択リスト作成
        this.makerList = util.getSelectList(AssetConstants.MAKER);
        // 車種選択リスト作成
        // this.modelList = util.getSelectList(AssetConstants.MODEL);
        // 統括部門選択リスト作成
        // SALESSTRATEGY-4557：派生対応 有効な査定ユーザの統括部門を取得
        //this.manageBumonList = util.getSelectList(AssetConstants.ASSESS_TANTO, AssetConstants.MANAGE_BUMON);
        this.manageBumonList = util.getManegeOrgSelectList();

        //ページ初期化
        this.pageNumber = 1;
        this.firstRow = 0;

        //最大ページ取得
        this.totalPageNumber = 1;
    }

    // メーカーリスト
    public List<SelectOption> getMakerList(){
        return this.makerList;
    }

    // 車種リスト
    // public List<SelectOption> getModelList(){
    //     return this.modelList;
    // }

    //統括部門リスト
    public List<SelectOption> getManageBumonList(){
        return this.manageBumonList;
    }

    /* --------------------------
     * ページ送り処理
     * ------------------------- */
    //最初のページへ
    public void doFirst(){
        System.debug('■■■ doFirst() Start ■■■');
        // firstRow = 0;
        this.pageNumber = 1;
        setPage(this.pageNumber);
    }
    //前へ
    public void doPrevious(){
        System.debug('■■■ doPrevious() Start ■■■');
        // firstRow -= pageSize;
        this.pageNumber--;
        setPage(this.pageNumber);
    }
    //次へ
    public void doNext(){
        System.debug('■■■ doNext() Start ■■■');
        // firstRow += pageSize;
        this.pageNumber++;
        setPage(this.pageNumber);
    }
    //最後のページへ
    public void doLast(){
        System.debug('■■■ doLast() Start ■■■');
        // firstRow = (pageSize * totalPageNumber) - pageSize;
        this.pageNumber = totalPageNumber;
        setPage(this.pageNumber);
    }

    /**
     * ページ移動
     */
    public void doMove(){
        setPage(this.pageNumber);
    }
    
    //ページサイズを取得
    public Integer getPageSize() {
        return this.pageSize;
    }

    /** 
     * ページング対応 ページ数等の設定処理 
     */
    private void setPage(Integer page) {
        System.debug('■■■ setPage() Start ■■■');

        if (page > totalPageNumber) {
            page = totalPageNumber;
        }

        if (page < 1) {
            page = 1;
        }

        this.pageNumber = page;

        this.firstRow = util.calcFirstRow(page, this.pageSize);
    }
}