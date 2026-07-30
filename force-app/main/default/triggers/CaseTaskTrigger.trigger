trigger CaseTaskTrigger on Case_Task__c (before insert, before update) {

    if (Trigger.isInsert) {
        // 新規作成時は必ずエスカレーション期限を計算
        CaseTaskEscalationService.setEscalationAndFlag(Trigger.new);
    }

    if (Trigger.isUpdate) {
        List<Case_Task__c> target = new List<Case_Task__c>();

        for (Case_Task__c newRec : Trigger.new) {
            Case_Task__c oldRec = Trigger.oldMap.get(newRec.Id);

            // 対応期限が変更されたときだけ再計算する
            if (newRec.Compliance_deadline__c != oldRec.Compliance_deadline__c) {
                target.add(newRec);
            }
        }

        if (!target.isEmpty()) {
            CaseTaskEscalationService.setEscalationAndFlag(target);
        }
    }
}