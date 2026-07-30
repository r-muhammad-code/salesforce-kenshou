@isTest
class SandboxDataCreatorTest {
    @isTest
    static void testPostCopyScript() {
        SandboxDataCreator script = new SandboxDataCreator();
        
        Test.startTest();
        // ここで本体の runApexClass を呼び出すことで、
        // メーカ・車種・ヤード作成の全行が「実行」されます
        script.runApexClass(null);
        Test.stopTest();

        // 【答え合わせ】
        // 1. トヨタがいるか
        System.assertEquals(1, [SELECT count() FROM Mst_Makers__c WHERE Name = 'トヨタ']);
        // 2. プリウスがいるか
        System.assertEquals(1, [SELECT count() FROM Mst_Models__c WHERE Name = 'プリウス']);
        // 3. ヤードが「2件」できているか（ここがポイント！）
        System.assertEquals(2, [SELECT count() FROM Mst_Yard__c], 'ヤードマスタが2件作成されていません');
    }
}