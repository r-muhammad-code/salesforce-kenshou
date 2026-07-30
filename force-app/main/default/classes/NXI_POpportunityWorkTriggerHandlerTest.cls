@isTest
public class NXI_POpportunityWorkTriggerHandlerTest {
    @isTest static void test() {
        Account account = NXI_TestDataFactory.createAccount('0000');
        PurchaseOpportunityWork__c purchaseOpportunityWork = NXI_TestDataFactory.createPurchaseOpportunityWork(account, '0000', '0000');
    }
}