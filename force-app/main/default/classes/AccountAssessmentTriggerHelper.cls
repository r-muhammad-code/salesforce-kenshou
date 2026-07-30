public without sharing class AccountAssessmentTriggerHelper {
    
    public AccountAssessmentTriggerHelper(){
        
    }

    public void SetCommunityUserToOwner(List<AccountAssessment__c> newList){

        Map<Id, Id> assContactMap = new Map<Id, Id>();
        Map<Id, Id> conIdUserIdMap = new Map<Id, Id>();
        List<AccountAssessment__c> accAssUpdList = new List<AccountAssessment__c>();

        // 査定表IDと取引先責任者IDのマップを作成
        for(AccountAssessment__c accAss:
            [Select
                Id, Name, OwnerId, asses_tanto__c, asses_tanto__r.contact__c 
            From
                AccountAssessment__c
            Where
                Id in :newList
            ]
        ){
            if(accAss.asses_tanto__c != null && accAss.asses_tanto__r.contact__c != null){
                assContactMap.put(accAss.Id, accAss.asses_tanto__r.contact__c);
            }               
        }

        // 処理する査定表が無かったら終了
        if(assContactMap.isEmpty()){
            return;
        }

        // 取引先責任者IDとユーザIDのマップを作成
        for(User u:
            [Select
                Id, Name, ContactId
            From
                User
            Where
                ContactId in :assContactMap.values() AND isActive = true
            ]
        ){
            conIdUserIdMap.put(u.ContactId, u.Id);
        }

        // 処理するユーザーが無かったら終了
        if(assContactMap.isEmpty()){
            return;
        }

        // ユーザIDを査定表の所有者にセットする
        AccountAssessment__c updAss;
        for(Id assId:assContactMap.keySet()){
            updAss = new AccountAssessment__c(
                Id = assId,
                OwnerId = conIdUserIdMap.get(assContactMap.get(assId))
            );
            accAssUpdList.add(updAss);
        }

        try{
            if(!accAssUpdList.isEmpty()){
                update accAssUpdList;                
            }
        }
        catch(Exception e){
            System.debug('取引先査定表の所有者更新でエラーが発生しました。');
            System.debug('エラーメッセージ：' + e);
        }
    }
}