trigger WorkExchangeTrigger on WorkExchange__c (before insert,before update,after insert,after update) {

   if(Trigger.isAfter){
            List<Id> targets = new List<Id>();
            for (WorkExchange__c we :Trigger.New){
                if(!we.IsSynchronized__c){//処理済みフラグがFalse
                    targets.add(we.Id);
                }
            }
            if(targets.size()>0){
                NXI_TransferCustomCase tcc = new NXI_TransferCustomCase();
                tcc.Receive(targets);
            }
        }
}