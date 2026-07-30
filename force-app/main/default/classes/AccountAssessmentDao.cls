public with sharing class AccountAssessmentDao {
    @AuraEnabled
    public static boolean IsEnableRecodeType(Id assId){
        Id enableRecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='Auction'].Id;
        system.debug('有効なレコードタイプID' + enableRecordTypeId);
        AccountAssessment__c Recode = [SELECT RecordTypeId FROM AccountAssessment__c WHERE Id = :assId LIMIT 1];
        system.debug('対象レコード' + Recode);

        return (Recode.RecordTypeId == enableRecordTypeId);
    }
}