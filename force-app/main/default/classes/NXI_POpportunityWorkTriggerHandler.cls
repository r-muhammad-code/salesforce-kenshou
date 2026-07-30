public class NXI_POpportunityWorkTriggerHandler {
	private Boolean m_isExecuting = false;
    private Integer batchSize = 0;

    public NXI_POpportunityWorkTriggerHandler(Boolean isExecuting, Integer size){
        m_isExecuting = isExecuting;
        batchSize = size;
    }

    public void OnBeforeInsert(List<PurchaseOpportunityWork__c> newPOpportunityWorks){
    }  
    public void OnAfterInsert(List<PurchaseOpportunityWork__c> newPOpportunityWorks){
        createPOpportunities(newPOpportunityWorks);
    }
    public void OnBeforeUpdate(List<PurchaseOpportunityWork__c> oldPOpportunityWorks, Map<Id, PurchaseOpportunityWork__c> oldPOpportunityWorkMap, List<PurchaseOpportunityWork__c> newPOpportunityWorks, Map<Id, PurchaseOpportunityWork__c> newPOpportunityWorkMap){
    }
    public void OnAfterUpdate(List<PurchaseOpportunityWork__c> oldPOpportunityWorks, Map<Id, PurchaseOpportunityWork__c> oldPOpportunityWorkMap, List<PurchaseOpportunityWork__c> newPOpportunityWorks, Map<Id, PurchaseOpportunityWork__c> newPOpportunityWorkMap){
    }
    public void OnBeforeDelete(List<PurchaseOpportunityWork__c> pOpportunityWorksToDelete, Map<Id, PurchaseOpportunityWork__c> oldPOpportunityWorkMap){
    }
    public void OnAfterDelete(List<PurchaseOpportunityWork__c> oldPOpportunityWorks, Map<Id, PurchaseOpportunityWork__c> oldPOpportunityWorkMap){
    }
    public void OnUndelete(List<PurchaseOpportunityWork__c> newPOpportunityWorks){
    }
    
    public void createPOpportunities(List<PurchaseOpportunityWork__c> pOpportunityWorks) {
        List<User> users = new List<User>();
        users = NXI_Dao.getUsers();
        
        Map<String, User> userMapByUserCode = new Map<String, User>();
        for (User user : users) {
            if (String.isBlank(user.UserCode__c)) {
                continue;
            }
            userMapByUserCode.put(user.UserCode__c, user);
        }
        
        Set<String> powCustomFieldAPINameSet = new Set<String>();
        powCustomFieldAPINameSet = NXI_Util.getCustomFieldAPINameSet(PurchaseOpportunityWork__c.sObjectType);
        
        Set<String> poCustomFieldAPINameSet = new Set<String>();
        poCustomFieldAPINameSet = NXI_Util.getCustomFieldAPINameSet(PurchaseOpportunity__c.sObjectType);
        
        List<PurchaseOpportunityWork__c> targetPurchaseOpportunityWorks = new List<PurchaseOpportunityWork__c>();
        targetPurchaseOpportunityWorks = NXI_Dao.getPurchaseOpportunityWorks(pOpportunityWorks);
        
        List<PurchaseOpportunity__c> purchaseOpportunities_ups = new List<PurchaseOpportunity__c>();
        
        for (PurchaseOpportunityWork__c targetPurchaseOpportunityWork : targetPurchaseOpportunityWorks) {
            PurchaseOpportunity__c purchaseOpportunity_ups = new PurchaseOpportunity__c();
            
            //特殊処理
            //所有者コード→所有者変換
            if (userMapByUserCode.containsKey(targetPurchaseOpportunityWork.UserCode__c)) {
                purchaseOpportunity_ups.OwnerId = userMapByUserCode.get(targetPurchaseOpportunityWork.UserCode__c).Id;
            }
            
            for (String customFieldAPIName : powCustomFieldAPINameSet) {
                if (!poCustomFieldAPINameSet.contains(customFieldAPIName)) {
                    continue;
                }
                if (customFieldAPIName == 'UserCode__c') {
                    continue;
                }
                if(customFieldAPIName =='ModelYear__c'){
                  purchaseOpportunity_ups.put('ModelYearPickList__c',    targetPurchaseOpportunityWork.get(customFieldAPIName));
                }
                purchaseOpportunity_ups.put(customFieldAPIName, targetPurchaseOpportunityWork.get(customFieldAPIName));
            }
            
            purchaseOpportunities_ups.add(purchaseOpportunity_ups);
        }
        
        if (!purchaseOpportunities_ups.isEmpty()) {
            upsert purchaseOpportunities_ups CorporationID__c;
        }
        
        if (!targetPurchaseOpportunityWorks.isEmpty()) {
            delete targetPurchaseOpportunityWorks;
            Database.emptyRecycleBin(targetPurchaseOpportunityWorks);
        }
    }
}