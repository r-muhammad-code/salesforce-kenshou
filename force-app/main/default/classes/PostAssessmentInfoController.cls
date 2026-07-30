public without sharing class PostAssessmentInfoController {

    private AssessmentDetailHelper assHelper = new AssessmentDetailHelper();
    private AssessmentDao assDao = new AssessmentDao();

    private final String ENDPOINT = Constants.AUCTIONSITE_URL;

    public Assessment__c ass = new Assessment__c();
    public Id assId;
    public String retURL;                                                  //遷移先URL

    public static final String RECORD_TYPE_SALES = 'sales'; //レコードタイプ「営業」 20211027 HANA_SF_SATEI-205
    public static final String RECORD_TYPE_ID 
    = Schema.SObjectType.Assessment__c.getRecordTypeInfosByDeveloperName().get(RECORD_TYPE_SALES).getRecordTypeId(); //レコードタイプID  20211027 HANA_SF_SATEI-205

//    public String httpMessage {get; set;}


    // コンストラクタ
    public PostAssessmentInfoController(ApexPages.StandardController stdctrl) {
        // 査定表レコードのIDを取得
        this.assId = (Id)stdctrl.getId();
        // 査定表データ取得
        this.ass = assDao.getAssessmentInfo(assId).get(0);
        // 確認画面後に遷移するURL
        this.retURL = assId;
    }

    /*
     * 査定表情報をオークションサイトAPIへ送信する
     */
    public Pagereference postAssessmentInfo(){
        // 送信済だったら送信せずにメッセージを表示
        if(ass.SendDateToAuctionSite__c != null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.INFO, '送信済です。'));
            return null;
        }
        // レコードタイプが営業で「営業データ出品」項目が未選択の場合メッセージを表示 20211027 HANA_SF_SATEI-205
        else if((RECORD_TYPE_ID == ass.RecordtypeId) && String.isEmpty(ass.SalesDataListing__c)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.INFO, '営業データ出品項目を入力してください。'));
            return null;
        }

        System.debug('postAssessmentInfo Start ～ オークションサイトへ査定表情報送信');
        HttpResponse httpRes = assHelper.PostAssessmentInfoHelper(this.ass);
        if(httpRes.getStatusCode() == 200){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM, '送信に成功しました。'));
            updSendDate();
            System.debug(httpRes.getBody());
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, '送信に失敗しました。管理者に連絡して下さい。'));
        }
        return null;
    }

    // 確認ボタン押下時
    public PageReference confirm() {
        String prevURL = '/' + retURL;
        PageReference prevPage = new PageReference(prevURL);
        return prevPage;
    }

    // オークションサイト送信日時を更新
    private void updSendDate(){

        // API送信日時を保存
        Assessment__c updAss = new Assessment__c(
            Id = this.assId,
            SendDateToAuctionSite__c = Datetime.now()
        );

        try{
            update updAss;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, '「オークションサイトへの送信日時」の更新に失敗しました。'));
        }
    }
}