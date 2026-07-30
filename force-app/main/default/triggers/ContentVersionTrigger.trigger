trigger ContentVersionTrigger on ContentVersion (after insert) {

    // ハンドラークラス
    ContentVersionTriggerHandler handler = new ContentVersionTriggerHandler();

    if(Trigger.isBefore){

    } else if(Trigger.isAfter) {
        if(Trigger.isInsert){
            handler.OnAfterInsert(Trigger.new);
        }
    }
}