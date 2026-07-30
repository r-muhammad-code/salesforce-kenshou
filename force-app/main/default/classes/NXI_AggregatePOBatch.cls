public class NXI_AggregatePOBatch implements Database.Batchable<AggregateResult>, Database.Stateful {
    
    public NXI_AggregatePOBatch() {
    }
    
    public Iterable<AggregateResult> start(Database.BatchableContext bc) {
        String soql = NXI_Dao.getLastAssessmentDateByAccount();
        return new AggregateResultIterator(soql);
    }
    
    public void execute(Database.BatchableContext bc, List<AggregateResult> results) {
        List<Account> accounts_ups = new List<Account>();
        
        for (AggregateResult result : results) {
            Account account_ups = new Account();
            
            account_ups.put('Id', (Id)result.get('Account__c'));
      if (result.get('LastAssessmentDate')!=null){

      account_ups.put('LastAssessmentDate__c', result.get('LastAssessmentDate'));

      }

      if (result.get('LastPurchaseDate')!=null){

      account_ups.put('LastPurchaseDate__c', result.get('LastPurchaseDate'));       

      }          
            accounts_ups.add(account_ups);
        }
        
        if (!accounts_ups.isEmpty()) {
            upsert accounts_ups;
        }
    }
    
    public void finish(Database.BatchableContext bc) {
    }
}