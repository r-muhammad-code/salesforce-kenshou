@isTest
public class NXI_PExperienceWorkTriggerHandlerTest {
    @isTest static void test() {
        Account account = NXI_TestDataFactory.createAccount('0000');
        PurchaseOpportunity__c purchaseOpportunity = NXI_TestDataFactory.createPurchaseOpportunity(account, '0000');
        PurchaseExperienceWork__c purchaseExperienceWork = NXI_TestDataFactory.createPurchaseExperienceWork(purchaseOpportunity, '0000');
    }
}