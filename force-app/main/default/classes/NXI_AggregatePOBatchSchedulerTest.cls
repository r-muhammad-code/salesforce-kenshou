@isTest
public class NXI_AggregatePOBatchSchedulerTest {
    @isTest static void test() {
        Account account = NXI_TestDataFactory.createAccount('9999');
        
        List<PurchaseOpportunity__c> purchaseOpportunies = new List<PurchaseOpportunity__c>();
        purchaseOpportunies.add(NXI_TestDataFactory.createPurchaseOpportunity(account, '1000'));
        purchaseOpportunies.add(NXI_TestDataFactory.createPurchaseOpportunity(account, '2000'));
        purchaseOpportunies.add(NXI_TestDataFactory.createPurchaseOpportunity(account, '3000'));
        
        Test.startTest();
        String jobId = System.schedule('NXI_AggregatePOBatchScheduler', '0 0 * * * ?', new NXI_AggregatePOBatchScheduler());
        Test.stopTest();
    }
}