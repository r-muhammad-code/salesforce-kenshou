trigger Auction_Data_Trigger on Auction_Data__c (before insert, before update) {
    // 【無効化】保存時にフラグ計算を実行しない（夜間フローのみで更新する）
    return;

    /*
    AuctionDataBusinessDayFlagService.apply(Trigger.new);
    */
}