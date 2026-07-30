public with sharing class PostAssessmentBatchHelper {

    /**
     * コンストラクタ
     */    
    public PostAssessmentBatchHelper() { 
    }

    //AssessmentGetBatchから査定表データ取得
    public void postBatch(List<Assessment__c> scope){
        AssessmentDetailHelper helper = new AssessmentDetailHelper();
        List<Assessment__c> assSuccess = new List<Assessment__c>();
        List<Assessment__c> assFailed = new List<Assessment__c>();

        // 送信データの最新状態を取得する
        Map<Id,Assessment__c> nearAsses = getUnsendList(scope);

        // 1件ずつ取得
        for(Assessment__c ass : scope){
            Assessment__c nearAss = nearAsses.get(ass.Id);
            if(nearAss.SendDateToAuctionSite__c == null && nearAss.error_flg__c == false){
                // 未送信なのでオークション連携
                try{
                    ass.postAuctionErrReason__c = createErrorMessage(ass.postAuctionErrReason__c, 'SendStart');
                    HttpResponse httpRes = helper.PostAssessmentInfoHelper(ass);
                    ass.postAuctionErrReason__c = createErrorMessage(ass.postAuctionErrReason__c, 'Status:' + httpRes.getStatusCode());
                    if(httpRes.getStatusCode() == 200){
                        ass.SendDateToAuctionSite__c = Datetime.now();
                        assSuccess.add(ass);
                    }else{
                        ass.error_flg__c = true;
                        assFailed.add(ass);
                    }
                }
                catch(Exception e){
                    ass.error_flg__c = true;
                    ass.postAuctionErrReason__c = createErrorMessage(ass.postAuctionErrReason__c, 'Exception:' + e.getMessage());
                    assFailed.add(ass);
                }
            }else{
                // 未送信なのでログに送信済みを書き込んで終了
                ass.postAuctionErrReason__c = createErrorMessage(nearAss.postAuctionErrReason__c, nearAss.error_flg__c ? 'Already Error' : 'Sended');
                assSuccess.add(ass);
            }
        }
            
        if(!assSuccess.isEmpty()){
            //オークションサイトへの送信日時を更新
            update assSuccess;
        }
        if(!assFailed.isEmpty()){
            //エラーフラグを更新
            update assFailed;
            //sendErrorMailにassFailedを渡す
            sendErrorMail(assFailed);
        }
    }

    //エラーメッセージ用文字列の生成
    private string createErrorMessage(string preMsg, string msg){
        msg = DateTime.now().format('yyyy/MM/dd HH:mm:ss.SSS') + '\t' + msg;
        if (preMsg == null){
            return msg;
        }else{
            return preMsg + '\r\n' + msg;
        }
    }

    //エラーメール送信
    private void sendErrorMail(List<Assessment__c> assFailed){
        System.debug(assFailed);
        // エラーメール送信先を取得
        String mailAddress = System.Label.SnedErrMailAddress;
        if(String.isBlank(mailAddress)){
            // メールアドレスが設定されていなかった場合は何もしない
            return;
        }

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        // 送信先(String[])
        mail.setToAddresses(mailAddress.split(','));
        // 件名(String)
        mail.setSubject(AssetConstants.MSG_AUCTION_SENDBATCH_ERROR_SUBJECT);
        // 本文(String)
        String body = AssetConstants.MSG_AUCTION_ERROR;

        for (Assessment__c mailBody : assFailed) {
            body += mailBody.Name + ',';
        }
        // 最後のカンマを消す
        body = body.removeEnd(',');

        mail.setPlainTextBody(body);
        // 送信者表示名。組織のメールアドレス使用時は設定不可。
        mail.setSenderDisplayName(AssetConstants.MSG_AUCTION_SENDBATCH_ERROR_DISPLAYNAME);

        // 著名の有無。デフォルトはtrue。
        mail.setUseSignature(false);
        // メール送信
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail}, false);
        System.debug('ERR : ' + mail);
        System.debug('エラーメッセージ' + results[0].getErrors());
        if (!results[0].isSuccess()) {
            // メール送信に失敗した場合はロールバックさせないためにExceptionを発生させない
        }

   }

   // 送信データの最新状態を取得する
   private Map<Id,Assessment__c> getUnsendList(List<Assessment__c> scope){
        // 送信済みかどうかを直前にチェックする
        Set<Id> targetIds = new Set<Id>();
        for(Assessment__c ass : scope){
            targetIds.add(ass.Id);
        }
        return new Map<Id,Assessment__c>([select Id, SendDateToAuctionSite__c, error_flg__c, postAuctionErrReason__c from Assessment__c where Id in :targetIds]);
   }
}