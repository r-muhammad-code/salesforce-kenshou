@isTest
public class NXI_POpportunityTriggerHandlerTest {
    @isTest static void test() {
        Account account = NXI_TestDataFactory.createAccount('0000');
        PurchaseOpportunity__c purchaseOpportunity = NXI_TestDataFactory.createPurchaseOpportunity(account, '0000');
    }
}