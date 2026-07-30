/*
 * 査定表検索の検索条件クラス
 */
public without sharing class AssetCondition{
    /*
        * 検索条件の入力フィールド用
        * 
        * ・カスタムフィールドとして検索条件の入力項目を作成している。
        * ・こうすることで、プルダウンリストの場合はオブジェクトの設定画面から
        * 　選択リスト値を追加することで一覧画面の選択肢も追加される。
        */

    // 査定日(開始日)
    public String AssessDateStart { get; set; }
    // 査定日(終了日)
    public String AssessDateEnd{ get; set; }
    // メーカー
    public List<String> Maker { get; set; }
    // 車種
    public List<String> Model { get; set; }
    // 統括部門
    public List<String> ManageBumon { get; set; }
    // 査定担当者
    public List<String> AssessTanto { get; set; }
    // 車台番号
    public String ShadaiNo { get; set; }
    // ソートキー
    public String sortkey { get;set; }
    // ソート順
    public String order { get;set; }

    // コンストラクタ
    public AssetCondition() {
        // 画面表示順の初期値
        this.sortkey = 'asset_mngno__c';
        this.order = 'DESC';

        // 選択リストの初期化
        this.Maker = new List<String>();
        this.Model = new List<String>();
        this.ManageBumon = new List<String>();
        this.AssessTanto = new List<String>();

        Date d = Date.today().addYears(-1);
        this.AssessDateStart = d.year() + '/' + ('0' + d.month()).right(2) + '/' + ('0' + d.day()).right(2);
    }

    // ソート順を見出しに表示する記号に変換する
    public String sortOrderToString(){
        if(this.order == 'DESC'){
            return '▼';
        }
        return '▲';
    }

    // ソート順を逆にする
    public void setOrderReverse(){
        if(this.order == 'DESC'){
            this.order = 'ASC';
        }
        else {
            this.order = 'DESC';
        }
    }
}