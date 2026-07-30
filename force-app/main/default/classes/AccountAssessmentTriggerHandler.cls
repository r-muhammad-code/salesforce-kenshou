public without sharing class AccountAssessmentTriggerHandler {

    public static boolean hasExecuted = false;

    AccountAssessmentTriggerHelper helper = new AccountAssessmentTriggerHelper();

    // コンストラクタ
    public AccountAssessmentTriggerHandler(){
        
    }
    
    // Before Insert
    // public void OnBeforeInsert(List<AccountAssessment__c> newList){
    // }
    
    // Before Update
    // public void OnBeforeUpdate(List<AccountAssessment__c> newList, Map<Id, AccountAssessment__c> oldMap){
    // }
    
    // After Insert
    public void OnAfterInsert(List<AccountAssessment__c> newList){
        System.debug('★★★★★ OnAfterInsert start');
        // ひも付く査定ユーザから、コミュニティユーザを取得し、所有者にセットする
        helper.SetCommunityUserToOwner(newList);
    }
    
    // After Update
    // public void OnAfterUpdate(List<AccountAssessment__c> newList, Map<Id, AccountAssessment__c> oldMap){
    // }
    
}