@IsTest
private class CaseTaskEscalationServiceTest {

    // ▼ 1) Compliance_deadline__c なし → EscalationDateTime__c がセットされる
    @IsTest
    static void testEscalationWithoutComplianceDeadline() {

        // Status__c はあえて何もセットしない（null / 既定値のまま）
        Case_Task__c task = new Case_Task__c();
        insert task;  // before insert トリガーが動く

        // 挿入後の値を取得
        Case_Task__c result = [
            SELECT CreatedDate, EscalationDateTime__c
            FROM Case_Task__c
            WHERE Id = :task.Id
        ];

        // エスカレーション期限がセットされていること
        System.assertNotEquals(
            null,
            result.EscalationDateTime__c,
            'Compliance_deadline__c がなくても EscalationDateTime__c は必ずセットされるべき'
        );

        // 作成日時より後の時間になっていること
        System.assert(
            result.EscalationDateTime__c > result.CreatedDate,
            'EscalationDateTime__c は CreatedDate より後になっているはず'
        );
    }

    // ▼ 2) Compliance_deadline__c が 3営業時間より早い場合 → そちらが優先される
    @IsTest
    static void testEscalationUsesEarlierComplianceDeadline() {

        // まずタスクを作成（Status__c はセットしない）
        Case_Task__c task = new Case_Task__c();
        insert task;

        // 作成後の値を取得
        task = [
            SELECT Id, CreatedDate
            FROM Case_Task__c
            WHERE Id = :task.Id
        ];

        // CreatedDate の1時間後を Compliance_deadline__c に設定
        // → ロジック上「3営業時間より早い」前提
        Datetime compliance = task.CreatedDate.addHours(1);
        task.Compliance_deadline__c = compliance;

        Test.startTest();
        update task;  // before update トリガー → サービスクラスが動く
        Test.stopTest();

        Case_Task__c result = [
            SELECT EscalationDateTime__c, Compliance_deadline__c
            FROM Case_Task__c
            WHERE Id = :task.Id
        ];

        // Compliance_deadline__c のほうが早いので、EscalationDateTime__c に採用されるべき
        System.assertEquals(
            result.Compliance_deadline__c,
            result.EscalationDateTime__c,
            'Compliance_deadline__c の方が早ければ、それが EscalationDateTime__c として採用されるべき'
        );
    }

    // ▼ 3) 期限超過（Status は null = 未対応扱い） → contact_delay_flag__c = true
    @IsTest
    static void testContactDelayFlagAndStatus() {

        // タスク作成（Status__c はセットしない → isNewStatus(null) = true）
        Case_Task__c task = new Case_Task__c();
        insert task;

        // すでに過去になっている Compliance_deadline__c をセット
        // → 「期限超過」が確実に成り立つようにする
        task = [
            SELECT Id
            FROM Case_Task__c
            WHERE Id = :task.Id
        ];
        task.Compliance_deadline__c = System.now().addHours(-1); // 1時間前

        Test.startTest();
        update task;  // before update トリガー → サービスクラスが動く
        Test.stopTest();

        Case_Task__c afterUpdate = [
            SELECT Status__c, EscalationDateTime__c, contact_delay_flag__c
            FROM Case_Task__c
            WHERE Id = :task.Id
        ];

        // Status は null だが isNewStatus(null) = true なので、
        // 期限超過していれば contact_delay_flag__c は true になるはず
        System.assertEquals(
            true,
            afterUpdate.contact_delay_flag__c,
            '期限超過しているので contact_delay_flag__c は true になるべき'
        );
    }
}