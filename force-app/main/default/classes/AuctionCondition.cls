/**
 * オークション情報のソート
 */
public without sharing class AuctionCondition {

    // ソートキー
    public String sortkey { get;set; }
    // ソート順
    public String order { get;set; }

    public AuctionCondition() {
        // 画面表示順の初期値
        this.sortkey = 'SoldData__c';
        this.order = 'DESC';
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