global class SandboxDataCreator implements SandboxPostCopy {
    global void runApexClass(SandboxContext context) {
        
        try {
            // --- STEP 1: メーカマスタ（トヨタ）の作成 ---
            Mst_Makers__c makerToyota = new Mst_Makers__c(
                Name = 'トヨタ',
                COUNTRY__C = '1',
                COUNTRY_NAME__C = '国産車',
                DISP_FLG__C = '1',
                INUM__C = '10000001',
                MAKER__C = '10000001',
                MAKER_NAME_EIZI__C = 'TOYOTA',
                ROW_NUM__C = 20000010
            );
            insert makerToyota;

            // --- STEP 2: 車種マスタ（プリウス）の作成 ---
            Mst_Models__c modelPrius = new Mst_Models__c(
                Name = 'プリウス',
                MAKER__C = makerToyota.Id,
                Makers_en__c = 'TOYOTA',
                DISP_FLG__C = '1',
                INUM__C = '10100084',
                MAKER_CODE__C = '10000001',
                MAKER_DISP__C = 'トヨタ',
                MODEL_NAME_EIZI__C = 'PRIUS',
                MODEL_NAME_HALF_WIDTH__C = 'ﾌﾟﾘｳｽ',
                REUSE_DISP__C = '0',
                VARIETY_CLASSIFICATION__C = '10'
            );
            insert modelPrius;

            // --- STEP 3: 発着地マスタの作成（2レコード一括） ---
            List<Mst_Yard__c> yards = new List<Mst_Yard__c>();
            yards.add(new Mst_Yard__c(
                Name = '神戸集中ヤード',
                MST_YARD_CLASSIFICATION__C = '自社ヤード',
                YARD_CODE__C = 'YA31',
                DELIVERYPOSTALCODE__C = '651-1264',
                DELIVERYADDRESS__C = '兵庫県神戸市北区山田町衝原字南山49番1',
                DELIVERYPHONENUMBER__C = '078-586-3301',
                DELIVERYDESTINATIONPERSON__C = 'マキノ',
                DEPARTUREARRIVALAREA__C = '自社ヤード',
                DESTINATIONNOTES__C = 'トラック搬入時の連絡先　090-3267-1319'
            ));
            yards.add(new Mst_Yard__c(
                Name = 'HAA神戸',
                MST_YARD_CLASSIFICATION__C = '他社オークション',
                YARD_CODE__C = 'YA92014',
                DELIVERYADDRESS__C = '兵庫県神戸市中央区小野浜町21番1号',
                DELIVERYPHONENUMBER__C = '078-326-5566',
                DEPARTUREARRIVALAREA__C = '他社オークション',
                DESTINATIONNOTES__C = 'リスト無し / ID:O-6999 はなまる分',
                AUCTIONDAY__C = '土'
            ));
            insert yards;

            System.debug('【成功】マスタデータの自動作成が完了しました。');

        } catch (Exception e) {
            // エラーが発生した場合にここを通ります
            String errorMsg = 'SandboxDataCreatorでエラーが発生しました。';
            errorMsg += '\nエラー種別: ' + e.getTypeName();
            errorMsg += '\nエラーメッセージ: ' + e.getMessage();
            errorMsg += '\n発生箇所: ' + e.getStackTraceString();

            // デバッグログにエラー内容を書き出す
            System.debug(LoggingLevel.ERROR, errorMsg);
            
            // 重要：ここでメールを送る処理などを足すと、失敗にすぐ気づけます
        }
    }
}