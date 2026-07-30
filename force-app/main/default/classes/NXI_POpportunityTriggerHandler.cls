public class NXI_POpportunityTriggerHandler {

    private Boolean m_isExecuting = false;
    private Integer batchSize = 0;

    public NXI_POpportunityTriggerHandler(Boolean isExecuting, Integer size){
        m_isExecuting = isExecuting;
        batchSize = size;
    }
    public void OnBeforeInsert(List<PurchaseOpportunity__c> newPOpportunitys){
		autoSetPurchaseOpportunity(newPOpportunitys);
    }  
    public void OnAfterInsert(List<PurchaseOpportunity__c> newPOpportunitys){
    }
    public void OnBeforeUpdate(List<PurchaseOpportunity__c> oldPOpportunitys, Map<Id, PurchaseOpportunity__c> oldPOpportunityMap, List<PurchaseOpportunity__c> newPOpportunitys, Map<Id, PurchaseOpportunity__c> newPOpportunityMap){
		autoSetPurchaseOpportunity(newPOpportunitys);
    }
    public void OnAfterUpdate(List<PurchaseOpportunity__c> oldPOpportunitys, Map<Id, PurchaseOpportunity__c> oldPOpportunityMap, List<PurchaseOpportunity__c> newPOpportunitys, Map<Id, PurchaseOpportunity__c> newPOpportunityMap){
    }
    public void OnBeforeDelete(List<PurchaseOpportunity__c> pOpportunitysToDelete, Map<Id, PurchaseOpportunity__c> oldPOpportunityMap){
    }
    public void OnAfterDelete(List<PurchaseOpportunity__c> oldPOpportunitys, Map<Id, PurchaseOpportunity__c> oldPOpportunityMap){
    }
    public void OnUndelete(List<PurchaseOpportunity__c> newPOpportunitys){
    } 

    public void autoSetPurchaseOpportunity(List<PurchaseOpportunity__c> pOpportunitys) {
        
        for (PurchaseOpportunity__c po : pOpportunitys) {              
            // フェーズが受付で査定依頼日が未入力のとき、査定依頼日に当日をセット
            if (po.Phase__c == '受付' && po.RequestDate__c == null){
        		po.RequestDate__c = date.today();            
    		}            
    
            // フェーズが保留で査定日が未入力のとき、査定日に当日をセット
            if (po.Phase__c == '保留' && po.AssessmentDate__c == null){
        		po.AssessmentDate__c = date.today();            
    		}            
    
            // フェーズが買取で買取日が未入力のとき、買取日に当日をセット 
            if (po.Phase__c == '買取' && po.PurchaseDate__c == null){
        		po.PurchaseDate__c = date.today();            
    		}            
    
            // フェーズが全完了で全完了日が未入力のとき、全完了日に当日をセット
            if (po.Phase__c == '全完了' && po.CompletionDate__c == null){
        		po.CompletionDate__c = date.today();            
    		}            
    
            // フェーズがキャンセルでキャンセル日が未入力のとき、キャンセル日に当日をセット
            if (po.Phase__c == 'キャンセル' && po.CancelDate__c == null){
        		po.CancelDate__c = date.today();            
    		}            
    
            // 搬入日が未入力のとき、搬入日に引取日をセット
            if (po.CarryDate__c ==  null){
        		po.CarryDate__c = po.TakeUpDate__c;            
    		}            
        }        
    }        
}