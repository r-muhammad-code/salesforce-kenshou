@isTest
public class NXI_TestDataFactory {
    //**取引先**
    public static Account createAccount(String accountCode) {
        Account account = new Account();
        account.Name = 'テスト取引先';
        account.TradeType__c = '新規';
        account.CorporationType__c = '一般';
        account.AccountCode__c = accountCode;
        
        insert account;
        return account;
    }
    
    //**買取商談**
    public static PurchaseOpportunity__c createPurchaseOpportunity(Account account, String corporationId) {
        PurchaseOpportunity__c purchaseOpportunity = new PurchaseOpportunity__c();
        purchaseOpportunity.Account__c = account.Id;
        purchaseOpportunity.OpportunityType__c = '既存';
        purchaseOpportunity.Phase__c = '買取';
        purchaseOpportunity.CorporationID__c = corporationId;
        purchaseOpportunity.AssessmentDate__c=date.today();
        purchaseOpportunity.PurchaseDate__c=date.today();
        
        insert purchaseOpportunity;
        return purchaseOpportunity;
    }
    
    //**買取商談（ワーク）**
    public static PurchaseOpportunityWork__c createPurchaseOpportunityWork(Account account, String corporationId, String userCode) {
        PurchaseOpportunityWork__c purchaseOpportunityWork = new PurchaseOpportunityWork__c();
        purchaseOpportunityWork.Account__c = account.Id;
        purchaseOpportunityWork.OpportunityType__c = '既存';
        purchaseOpportunityWork.Phase__c = '買取';
        purchaseOpportunityWork.CorporationID__c = corporationId;
        purchaseOpportunityWork.UserCode__c = userCode;
        
        insert purchaseOpportunityWork;
        return purchaseOpportunityWork;
    }
    
     //**買取実績（ワーク）**
     public static PurchaseExperienceWork__c createPurchaseExperienceWork(PurchaseOpportunity__c purchaseOpportunity, String userCode) {
        PurchaseExperienceWork__c purchaseExperienceWork = new PurchaseExperienceWork__c();
        purchaseExperienceWork.PurchaseOpportunity__c = purchaseOpportunity.Id;
        purchaseExperienceWork.BudgetActualType__c = '実績';
        purchaseExperienceWork.UserCode__c = userCode;
        
        insert purchaseExperienceWork;
        return purchaseExperienceWork;
    }
}