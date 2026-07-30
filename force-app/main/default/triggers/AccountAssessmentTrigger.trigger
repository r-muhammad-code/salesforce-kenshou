trigger AccountAssessmentTrigger on AccountAssessment__c (after insert, after update) {

    if(AccountAssessmentTriggerHandler.hasExecuted){
        return;
    }
    AccountAssessmentTriggerHandler.hasExecuted = true;

    AccountAssessmentTriggerHandler handler = new AccountAssessmentTriggerHandler();
    
    if(Trigger.isBefore){
    }
    else if(Trigger.isAfter){
        if(Trigger.isInsert){
            handler.OnAfterInsert(Trigger.new);
        }
    }

}