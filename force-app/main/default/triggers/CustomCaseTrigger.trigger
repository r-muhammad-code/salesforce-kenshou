trigger CustomCaseTrigger on Case__c (before insert,before update,after insert,after update) {
//IsTransfer 
        if(Trigger.isBefore){
            for (Case__c cc :Trigger.New){

                if(cc.Heroku__c){
                    if(cc.CallAOpportunity__c !=null)   cc.WaitingCallA__c = true;
                    if(cc.Oppotunity__c !=null)       cc.WaitingOpp__c =true;
                }
            }
        }
        if(Trigger.isAfter){
            List<Id> targets = new List<Id>();
            for (Case__c cc :Trigger.New){
                if(cc.IsTransfer__c){
                    system.debug(cc.Id);
                    targets.add(cc.Id);
                }
            }
            if(targets.size()>0){
                NXI_TransferCustomCase tcc = new NXI_TransferCustomCase();
                tcc.Translation(targets);
            }
        }
}