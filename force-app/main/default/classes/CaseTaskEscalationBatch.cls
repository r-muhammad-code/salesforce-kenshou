// 期限切れの対応タスクに contact_delay_flag__c を立てるバッチ（シンプル版）
global class CaseTaskEscalationBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        // ▼ 期限切れ & まだフラグが付いていないタスクだけを取得
        return Database.getQueryLocator([
            SELECT Id, EscalationDateTime__c, contact_delay_flag__c
            FROM Case_Task__c
            WHERE EscalationDateTime__c != null
              AND EscalationDateTime__c <= :System.now()
              AND contact_delay_flag__c = false
        ]);
    }

    global void execute(Database.BatchableContext bc, List<SObject> scope) {

        List<Case_Task__c> updateList = new List<Case_Task__c>();

        for (SObject sob : scope) {
            Case_Task__c ct = (Case_Task__c)sob;

            // この時点で「期限切れ & まだフラグなし」のレコードだけ来ているので、
            // 何も考えずにフラグを立てればOK
            ct.contact_delay_flag__c = true;
            updateList.add(ct);
        }

        if (!updateList.isEmpty()) {
            update updateList;
        }
    }

    global void finish(Database.BatchableContext bc) {
        // 後処理があればここに。今回は何もしない。
    }
}