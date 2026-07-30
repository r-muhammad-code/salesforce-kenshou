public class NXI_PExperienceWorkTriggerHandler {
	private Boolean m_isExecuting = false;
    private Integer batchSize = 0;

    public NXI_PExperienceWorkTriggerHandler(Boolean isExecuting, Integer size){
        m_isExecuting = isExecuting;
        batchSize = size;
    }

    public void OnBeforeInsert(List<PurchaseExperienceWork__c> newPExperienceWorks){
    }  
    public void OnAfterInsert(List<PurchaseExperienceWork__c> newPExperienceWorks){
        createPExperiences(newPExperienceWorks);
    }
    public void OnBeforeUpdate(List<PurchaseExperienceWork__c> oldPExperienceWorks, Map<Id, PurchaseExperienceWork__c> oldPExperienceWorkMap, List<PurchaseExperienceWork__c> newPExperienceWorks, Map<Id, PurchaseExperienceWork__c> newPExperienceWorkMap){
    }
    public void OnAfterUpdate(List<PurchaseExperienceWork__c> oldPExperienceWorks, Map<Id, PurchaseExperienceWork__c> oldPExperienceWorkMap, List<PurchaseExperienceWork__c> newPExperienceWorks, Map<Id, PurchaseExperienceWork__c> newPExperienceWorkMap){
    }
    public void OnBeforeDelete(List<PurchaseExperienceWork__c> pExperienceWorksToDelete, Map<Id, PurchaseExperienceWork__c> oldPExperienceWorkMap){
    }
    public void OnAfterDelete(List<PurchaseExperienceWork__c> oldPExperienceWorks, Map<Id, PurchaseExperienceWork__c> oldPExperienceWorkMap){
    }
    public void OnUndelete(List<PurchaseExperienceWork__c> newPExperienceWorks){
    }
    
    public void createPExperiences(List<PurchaseExperienceWork__c> pExperienceWorks) {
        List<User> users = new List<User>();
        users = NXI_Dao.getUsers();
        
        Map<String, User> userMapByUserCode = new Map<String, User>();
        for (User user : users) {
            if (String.isBlank(user.UserCode__c)) {
                continue;
            }
            userMapByUserCode.put(user.UserCode__c, user);
        }
        
        Set<String> pewCustomFieldAPINameSet = new Set<String>();
        pewCustomFieldAPINameSet = NXI_Util.getCustomFieldAPINameSet(PurchaseExperienceWork__c.sObjectType);
        
        Set<String> peCustomFieldAPINameSet = new Set<String>();
        peCustomFieldAPINameSet = NXI_Util.getCustomFieldAPINameSet(PurchaseExperience__c.sObjectType);
        
        List<PurchaseExperienceWork__c> targetPurchaseExperienceWorks = new List<PurchaseExperienceWork__c>();
        targetPurchaseExperienceWorks = NXI_Dao.getPurchaseExperienceWorks(pExperienceWorks);
        
        List<PurchaseExperience__c> purchaseExperiences_ups = new List<PurchaseExperience__c>();
        
        for (PurchaseExperienceWork__c targetPurchaseExperienceWork : targetPurchaseExperienceWorks) {
            PurchaseExperience__c purchaseExperience_ups = new PurchaseExperience__c();
            
            //特殊処理
            //所有者コード→所有者変換
            if (userMapByUserCode.containsKey(targetPurchaseExperienceWork.UserCode__c)) {
                purchaseExperience_ups.OwnerId = userMapByUserCode.get(targetPurchaseExperienceWork.UserCode__c).Id;
            }
            
            for (String customFieldAPIName : pewCustomFieldAPINameSet) {
                if (!peCustomFieldAPINameSet.contains(customFieldAPIName)) {
                    continue;
                }
                if (customFieldAPIName == 'UserCode__c') {
                    continue;
                }
                purchaseExperience_ups.put(customFieldAPIName, targetPurchaseExperienceWork.get(customFieldAPIName));
            }
            
            purchaseExperiences_ups.add(purchaseExperience_ups);
        }
        
        if (!purchaseExperiences_ups.isEmpty()) {
            insert purchaseExperiences_ups;
            //買取商談にIDを連携
            List<Id> oppids= new List<Id>();
            List<PurchaseOpportunity__c> updopp = new List<PurchaseOpportunity__c>();
            for(PurchaseExperience__c upsrecord:purchaseExperiences_ups){
                if(upsrecord.PurchaseOpportunity__c !=null ){
                    if( !oppids.contains(upsrecord.PurchaseOpportunity__c)){
                        oppids.add(upsrecord.PurchaseOpportunity__c);//重複回避用商談IDリスト
                        
                        PurchaseOpportunity__c updopprec =
                            new PurchaseOpportunity__c(id=upsrecord.PurchaseOpportunity__c,PurchaseExperience__c=upsrecord.Id);
                        
                        updopp.add(updopprec);
                    }
                }
            }
            if(!updopp.isEmpty()){
                update updopp;
            }
        }
        
        if (!targetPurchaseExperienceWorks.isEmpty()) {
            delete targetPurchaseExperienceWorks;
            Database.emptyRecycleBin(targetPurchaseExperienceWorks);
        }
    }
}