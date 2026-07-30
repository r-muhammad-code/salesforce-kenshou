@isTest
public class NXI_DaoTest {
    @isTest
    public static void test01() {
        List<User> users = NXI_Dao.getUsers();
        Account ac = new Account(LastName = 'nakamura');
        insert ac;
       // Case__c cc = new Case__c(Account__c=ac.id );
        
        List<Id> idlist = new List<Id>();
        
        List<Case__c> cclist =  NXI_Dao.getCustomCase(idlist);
        List<WorkExchange__c>  welist =NXI_Dao.getWorkExchange(idlist);
        
        String  results = NXI_Dao.getLastAssessmentDateByAccount();
       
        List<PurchaseOpportunityWork__c> woplist = new List<PurchaseOpportunityWork__c>();
        List<PurchaseOpportunityWork__c> selectlist   =  NXI_Dao.getPurchaseOpportunityWorks(woplist);
        
        List<PurchaseExperienceWork__c> weplist = new List<PurchaseExperienceWork__c>();
        List<PurchaseExperienceWork__c> selectlist2   =  NXI_Dao.getPurchaseExperienceWorks(weplist);
        

    }
   

}