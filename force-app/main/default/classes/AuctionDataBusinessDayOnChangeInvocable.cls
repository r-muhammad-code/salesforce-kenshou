public with sharing class AuctionDataBusinessDayOnChangeInvocable {

    /**
     * レコードトリガーフロー（After Save）から呼ぶ想定の Invocable。
     *
     * 入力：Auction_Data__c のレコードID（1件でも複数でもOK）
     * 処理：該当レコードだけを取得 → 営業日フラグ再計算 → 変更があったものだけ更新
     *
     * ※ 起動条件（ISCHANGED(Deadline_Time__c) など）はフロー側で制御する想定。
     */
    @InvocableMethod(label='Recalculate Business Day Flags (On Change)')
    public static void run(List<Id> auctionDataIds) {

        // ガード
        if (auctionDataIds == null || auctionDataIds.isEmpty()) return;

        // null混入対策 + 重複排除
        Set<Id> idSet = new Set<Id>();
        for (Id i : auctionDataIds) {
            if (i != null) idSet.add(i);
        }
        if (idSet.isEmpty()) return;

        // 対象レコードを最小限の項目で取得
        // （apply() が Deadline_Time__c と4フラグを見るため）
        List<Auction_Data__c> targets = [
            SELECT Id,
                   Deadline_Time__c,
                   IsPreviousBusinessDay__c,
                   IsCurrentBusinessDay__c,
                   IsNextBusinessDay__c,
                   IsSecondNextBusinessDay__c
            FROM Auction_Data__c
            WHERE Id IN :idSet
        ];

        if (targets.isEmpty()) return;

        // 変更前を保持（変更があったものだけUPDATEするため）
        Map<Id, Auction_Data__c> beforeMap = new Map<Id, Auction_Data__c>();
        for (Auction_Data__c a : targets) {
            beforeMap.put(a.Id, a.clone(true, true, false, false));
        }

        // 既存のロジックでフラグを再計算
        // ※このメソッドがtargets内のフラグを書き換える前提
        AuctionDataBusinessDayFlagService.apply(targets);

        // 変更があったものだけ更新（無駄なDML・後続フロー連鎖を抑える）
        List<Auction_Data__c> toUpdate = new List<Auction_Data__c>();
        for (Auction_Data__c a : targets) {
            Auction_Data__c b = beforeMap.get(a.Id);

            if (a.IsPreviousBusinessDay__c != b.IsPreviousBusinessDay__c ||
                a.IsCurrentBusinessDay__c  != b.IsCurrentBusinessDay__c  ||
                a.IsNextBusinessDay__c     != b.IsNextBusinessDay__c     ||
                a.IsSecondNextBusinessDay__c != b.IsSecondNextBusinessDay__c) {
                toUpdate.add(a);
            }
        }

        if (!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }
}