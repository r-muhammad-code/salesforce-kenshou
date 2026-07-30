@IsTest
private class CaseTaskEscalationSchedulerTest {

    @IsTest
    static void testBatchSetsFlagCorrectly() {

        Datetime nowDt = System.now();

        // ① まず素のタスクを2件作成（insert時のトリガーはそのまま動かしてOK）
        Case_Task__c overdue = new Case_Task__c();
        overdue.contact_delay_flag__c = false;
        insert overdue;

        Case_Task__c future = new Case_Task__c();
        future.contact_delay_flag__c = false;
        insert future;

        // ② insert後に、updateで EscalationDateTime__c を「過去」と「未来」に上書きする
        //    ※このupdateでは Compliance_deadline__c を触らない → トリガーは再計算しない

        overdue = [
            SELECT Id, EscalationDateTime__c, Compliance_deadline__c
            FROM Case_Task__c
            WHERE Id = :overdue.Id
        ];
        overdue.EscalationDateTime__c = nowDt.addMinutes(-10); // 10分前（期限切れ）

        future = [
            SELECT Id, EscalationDateTime__c, Compliance_deadline__c
            FROM Case_Task__c
            WHERE Id = :future.Id
        ];
        future.EscalationDateTime__c = nowDt.addMinutes(10);   // 10分後（まだ期限前）

        update new List<Case_Task__c>{ overdue, future };

        Test.startTest();

        // ▼ スケジュール経由ではなく、バッチ本体を直接実行
        Database.executeBatch(new CaseTaskEscalationBatch(), 200);

        Test.stopTest();

        // 結果取得
        Map<Id, Case_Task__c> resultMap = new Map<Id, Case_Task__c>([
            SELECT contact_delay_flag__c, EscalationDateTime__c
            FROM Case_Task__c
            WHERE Id IN :new List<Id>{ overdue.Id, future.Id }
        ]);

        // 期限切れレコード → true になっているはず
        System.assertEquals(
            true,
            resultMap.get(overdue.Id).contact_delay_flag__c,
            '期限切れレコードは contact_delay_flag__c が true になるべき'
        );

        // まだ期限前のレコード → false のままのはず（今回のバッチの対象外）
        System.assertEquals(
            false,
            resultMap.get(future.Id).contact_delay_flag__c,
            'まだ EscalationDateTime__c を過ぎていないレコードはフラグが立たないべき'
        );
    }
}