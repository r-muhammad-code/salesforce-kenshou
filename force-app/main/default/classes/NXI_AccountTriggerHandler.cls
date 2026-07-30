public class NXI_AccountTriggerHandler {

    private Boolean m_isExecuting = false;
    private Integer batchSize = 0;

    public NXI_AccountTriggerHandler(Boolean isExecuting, Integer size){
        m_isExecuting = isExecuting;
        batchSize = size;
    }
    public void OnBeforeInsert(List<Account> newAccounts){
    }  
    public void OnAfterInsert(List<Account> newAccounts){
		autoSetNumbering(newAccounts);
    }
    public void OnBeforeUpdate(List<Account> oldAccounts, Map<Id, Account> oldAccountMap, List<Account> newAccounts, Map<Id, Account> newAccountMap){
    }
    public void OnAfterUpdate(List<Account> oldAccounts, Map<Id, Account> oldAccountMap, List<Account> newAccounts, Map<Id, Account> newAccountMap){
    }
    public void OnBeforeDelete(List<Account> pOpportunitysToDelete, Map<Id, Account> oldAccountMap){
    }
    public void OnAfterDelete(List<Account> oldAccounts, Map<Id, Account> oldAccountMap){
    }
    public void OnUndelete(List<Account> newAccounts){
    } 
    public void autoSetNumbering(List<Account> pAccounts) {        
  		List<Account> account = new List<Account>();
        for (Account a : pAccounts) {
        	if (a.AccountCode__c == null) {
            	Account acToUpdate = new Account(Id=a.Id);
              	acToUpdate.AccountCode__c = a.AccountCDNumbering__c;
              	account.add(acToUpdate);
            }
          }
          database.update(account);
    }        
}