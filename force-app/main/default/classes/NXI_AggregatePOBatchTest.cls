@isTest
public class NXI_AggregatePOBatchTest {
    @isTest static void test() {
        Account account = NXI_TestDataFactory.createAccount('9999');
        
        List<PurchaseOpportunity__c> purchaseOpportunies = new List<PurchaseOpportunity__c>();
        purchaseOpportunies.add(NXI_TestDataFactory.createPurchaseOpportunity(account, '1000'));
        purchaseOpportunies.add(NXI_TestDataFactory.createPurchaseOpportunity(account, '2000'));
        purchaseOpportunies.add(NXI_TestDataFactory.createPurchaseOpportunity(account, '3000'));
        
        Test.startTest();
        NXI_AggregatePOBatch batch = new NXI_AggregatePOBatch();
        Database.executeBatch(batch, 200);
        Test.stopTest();
    }
}