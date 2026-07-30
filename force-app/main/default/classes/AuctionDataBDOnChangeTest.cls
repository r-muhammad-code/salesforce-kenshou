@IsTest
private class AuctionDataBDOnChangeTest {

    @IsTest
    static void test_Run_NullEmptyAndValidId() {
        // 必須項目が Name のみ前提。もし必須項目が他にもあるならここに追加してください。
        Auction_Data__c a = new Auction_Data__c(
            Name = 'UT-AuctionData',
            Deadline_Time__c = System.now(),
            // 差分を確実に作る：apply()がまずfalseに戻すので更新が発生しやすい
            IsPreviousBusinessDay__c = true,
            IsCurrentBusinessDay__c = true,
            IsNextBusinessDay__c = true,
            IsSecondNextBusinessDay__c = true
        );
        insert a;

        Test.startTest();

        // ガード分岐
        AuctionDataBusinessDayOnChangeInvocable.run(null);
        AuctionDataBusinessDayOnChangeInvocable.run(new List<Id>());

        // 正常系（Idだけ渡す）
        AuctionDataBusinessDayOnChangeInvocable.run(new List<Id>{ a.Id });

        Test.stopTest();

        // 何かしらフラグが動いた（=処理が走った）ことを確認
        Auction_Data__c afterRec = [
            SELECT IsPreviousBusinessDay__c,
                   IsCurrentBusinessDay__c,
                   IsNextBusinessDay__c,
                   IsSecondNextBusinessDay__c
            FROM Auction_Data__c
            WHERE Id = :a.Id
        ];

        System.assert(
            !(afterRec.IsPreviousBusinessDay__c
              && afterRec.IsCurrentBusinessDay__c
              && afterRec.IsNextBusinessDay__c
              && afterRec.IsSecondNextBusinessDay__c),
            'フラグが全てtrueのまま＝apply/updateが動いていない可能性があります'
        );
    }
}