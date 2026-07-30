@isTest
private class AssessPictureControllerTest {

    static Id asses_tanto_id;
    static Id asses_account_tanto_id;

    @TestSetup
    static void makeAssesTanto(){
        TestDataFactory tdf = new TestDataFactory();
        Account account = tdf.createAccountData();
        Contact contact = tdf.createContactData2(account);
        tdf.createAssessUser();
        tdf.createAccountAssessUser(contact);
    }

    static Id getAssesTanto(String emp_kind){
        Mst_Assess_Users__c tanto = [SELECT Id FROM Mst_Assess_Users__c WHERE emp_kind__c = :emp_kind LIMIT 1];
        return tanto.Id;
    }

    //査定表で画像項目すべてセット
    @isTest
    static void testLoadRecordAssessment_SetAllImage() {

        //査定表テストデータの作成
        System.debug(getAssesTanto('1'));
        Assessment__c testAssessment = new Assessment__c(asses_tanto__c = getAssesTanto('1'), asset_mngno__c = '20241101_150000_001000');
        insert testAssessment;

        String imageColumnList = 'front_url__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';
        String objectName = 'Assessment__c';
        String recordId = testAssessment.Id;

        for(Integer i = 0; i < imageColumnList.split(',').size(); i++){
            String key = imageColumnList.split(',')[i].trim();
            String value = 'https://'+key;
            testAssessment.put(key,value);
        }
        testAssessment.put('asses_tanto__c',getAssesTanto('1'));
        testAssessment.put('asset_mngno__c','20241101_150000_001000');
        update testAssessment;

        Test.startTest();
        Map<String, String> result = AssessPictureController.LoadRecord(imageColumnList, objectName, recordId);
        Test.stopTest();

        for(String col : imageColumnList.split(',')){
            String imageColum= col.trim();
            System.assertEquals('https://'+imageColum, result.get(imageColum), imageColum+'で期待される画像URLが一致しません。');
        }

    }

    //査定表で画像項目がすべて空
    @isTest
    static void testLoadRecordAssessment_SetNoImage() {

        //査定表テストデータの作成
        Assessment__c testAssessment = new Assessment__c(asses_tanto__c = getAssesTanto('1'), asset_mngno__c = '20241101_150000_001002');
        insert testAssessment;

        String imageColumnList = 'front_url__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';
        String objectName = 'Assessment__c';
        String recordId = testAssessment.Id;

        Map<String, String> result = AssessPictureController.LoadRecord(imageColumnList, objectName, recordId);

        for(String col : imageColumnList.split(',')){
            String imageColum= col.trim();
            System.assertEquals(null, result.get(imageColum), imageColum+'で期待される画像URLが一致しません。');
            System.debug('すべて空Value:'+result.get(imageColum));
        }
    }

    //査定表で画像項目が一部設定、一部空
    @isTest
    static void testLoadRecordAssessment_SetSomeImage() {

        //査定表テストデータの作成
        Assessment__c testAssessment = new Assessment__c(asses_tanto__c = getAssesTanto('1'), asset_mngno__c = '20241101_150000_001003');
        insert testAssessment;

        String imageColumnList = 'front_url__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';
        String objectName = 'Assessment__c';
        String recordId = testAssessment.Id;

        for(Integer i = 0; i < imageColumnList.split(',').size(); i++){
            String key = imageColumnList.split(',')[i].trim();
            String value = '';
            //正面、その他１のみ画像URLをセット
            if(key == 'front_url__c' || key == 'other_url_1__c'){
                value = 'https://'+key;
            }else{
                value ='';
            }
            testAssessment.put(key,value);
        }
        update testAssessment;

        Map<String, String> result = AssessPictureController.LoadRecord(imageColumnList, objectName, recordId);

        for(String col : imageColumnList.split(',')){
            String imageColum= col.trim();
            if(imageColum == 'front_url__c' || imageColum == 'other_url_1__c'){
                System.assertEquals('https://'+imageColum, result.get(imageColum), imageColum+'で期待される画像URLが一致しません。');
            }else{
                System.assertEquals(null, result.get(imageColum), imageColum+'で期待される画像URLが一致しません。');
            }
        }
    }
    //査定表で存在しない項目名の値セット（エラー確認用）
    @isTest
    static void testLoadRecordAssessment_InvalidColumn() {

        //査定表テストデータの作成
        Assessment__c testAssessment = new Assessment__c(asses_tanto__c = getAssesTanto('1'), asset_mngno__c = '20241101_150000_001004');
        insert testAssessment;

        String imageColumnList = 'errortest__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';
        String imageColumnList_loop = 'front_url__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';

        String objectName = 'Assessment__c';
        String recordId = testAssessment.Id;

        for(Integer i = 0; i < imageColumnList.split(',').size(); i++){
            String key = imageColumnList_loop.split(',')[i].trim();
            String value = 'https://'+key;
            testAssessment.put(key,value);
        }
        update testAssessment;
        try {
            Map<String, String> result = AssessPictureController.LoadRecord(imageColumnList, objectName, recordId);
            //必ずエラーになる
            System.assertEquals(0, 1, '例外になりませんでした。');
        }catch (Exception ex){
            System.assertEquals('No such column \'errortest__c\' on entity \'Assessment__c\'. If you are attempting to use a custom field, be sure to append the \'__c\' after the custom field name. Please reference your WSDL or the describe call for the appropriate names.', ex.getMessage(),'エラーが正しくありません');
        }
    }

    //取引先査定表で画像項目すべてセット
    @isTest
    static void testLoadRecordAccountAssessment_SetAllImage() {
        
        //取引先査定表テストデータの作成
        AccountAssessment__c testAccountAssessment = new AccountAssessment__c(asses_tanto__c = getAssesTanto('2'), asset_mngno__c = '20241102_230000_001001');
        insert testAccountAssessment;

        String imageColumnList = 'front_url__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';
        String objectName = 'AccountAssessment__c';
        String recordId = testAccountAssessment.Id;

        for(Integer i = 0; i < imageColumnList.split(',').size(); i++){
            String key = imageColumnList.split(',')[i].trim();
            String value = 'https://'+key;
            testAccountAssessment.put(key,value);
        }
        update testAccountAssessment;

        Map<String, String> result = AssessPictureController.LoadRecord(imageColumnList, objectName, recordId);

        for(String col : imageColumnList.split(',')){
            String imageColum= col.trim();
            System.assertEquals('https://'+imageColum, result.get(imageColum), imageColum+'で期待される画像URLが一致しません。');
        }
    }

    //取引先査定表で画像項目がすべて空
    @isTest
    static void testLoadRecordAccountAssessment_SetNoImage() {
        
        //取引先査定表テストデータの作成
        Id tanto = getAssesTanto('2');
        System.debug(tanto);
        AccountAssessment__c testAccountAssessment = new AccountAssessment__c(asses_tanto__c = getAssesTanto('2'), asset_mngno__c = '20241102_230000_001002');
        insert testAccountAssessment;

        String imageColumnList = 'front_url__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';
        String objectName = 'AccountAssessment__c';
        String recordId = testAccountAssessment.Id;

        Map<String, String> result = AssessPictureController.LoadRecord(imageColumnList, objectName, recordId);

        for(String col : imageColumnList.split(',')){
            String imageColum= col.trim();
            System.assertEquals(null, result.get(imageColum), imageColum+'で期待される画像URLが一致しません。');
        }
    }

    //取引先査定表で画像項目が一部設定、一部空
    @isTest
    static void testLoadRecordAccountAssessment_SetSomeImage() {

        //取引先査定表テストデータの作成
        AccountAssessment__c testAccountAssessment = new AccountAssessment__c(asses_tanto__c = getAssesTanto('2'), asset_mngno__c = '20241102_230000_001003');
        insert testAccountAssessment;

        String imageColumnList = 'front_url__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';
        String objectName = 'AccountAssessment__c';
        String recordId = testAccountAssessment.Id;

        for(Integer i = 0; i < imageColumnList.split(',').size(); i++){
            String key = imageColumnList.split(',')[i].trim();
            String value = '';
            //正面、その他１のみ画像URLをセット
            if(key == 'right_front_url__c' || key == 'other_url_2__c'){
                value ='https://'+key;
            }else{
                value ='';
            }
            testAccountAssessment.put(key,value);
        }
        update testAccountAssessment;

        Map<String, String> result = AssessPictureController.LoadRecord(imageColumnList, objectName, recordId);

        for(String col : imageColumnList.split(',')){
            String imageColum= col.trim();
            if(imageColum == 'right_front_url__c' || imageColum == 'other_url_2__c'){
                System.assertEquals('https://'+imageColum, result.get(imageColum), imageColum+'で期待される画像URLが一致しません。');
            }else{
                System.assertEquals(null, result.get(imageColum), imageColum+'で期待される画像URLが一致しません。');
            }
        }
    }

    //取引先査定表で存在しない項目名の値セット（エラー確認用）
    @isTest
    static void testLoadRecordAccountAssessment_InvalidColumn() {

        //取引先査定表テストデータの作成
        AccountAssessment__c testAccountAssessment = new AccountAssessment__c(asses_tanto__c = getAssesTanto('2'), asset_mngno__c = '20241102_230000_001004');
        insert testAccountAssessment;

        //SFプロパティに「正面」項目なし（代わりにアプリに存在しない項目あり）
        String imageColumnList = 'errortest__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';
        String imageColumnList_loop = 'front_url__c,right_front_url__c,left_front_url__c,left_back_url__c,right_back_url__c,room_url__c,engine_url__c,cotion_url__c,key_url__c,meter_url__c,steering_url__c,center_console_url__c,front_seat_url__c,switch1_url__c,switch2_url__c,other_url_01__c,other_url_02__c,other_url_03__c,other_url_04__c,other_url_05__c,other_url_06__c,other_url_07__c,other_url_08__c,other_url_09__c,other_url_10__c,other_url_11__c,other_url_12__c,other_url_13__c,other_url_14__c,other_url_15__c,other_url_16__c,other_url_17__c,other_url_18__c,other_url_19__c,other_url_20__c,other_url_21__c,other_url_22__c,other_url_23__c,other_url_24__c,other_url_25__c,other_url_26__c,other_url_27__c,other_url_28__c,other_url_29__c,other_url_30__c,other_url_31__c,other_url_32__c,other_url_33__c,other_url_34__c,other_url_35__c,other_url_36__c,other_url_37__c,other_url_38__c,other_url_39__c,other_url_40__c,shakensho_url__c';

        String objectName = 'AccountAssessment__c';
        String recordId = testAccountAssessment.Id;

        for(Integer i = 0; i < imageColumnList.split(',').size(); i++){
            String key = imageColumnList_loop.split(',')[i].trim();
            String value = 'https://'+key; 
            testAccountAssessment.put(key,value);
        }
        update testAccountAssessment;
        try {
            Map<String, String> result = AssessPictureController.LoadRecord(imageColumnList, objectName, recordId);
            //必ずエラーになる
            System.assertEquals(0, 1, '例外になりませんでした。');
        }catch (Exception ex){
            System.assertEquals('No such column \'errortest__c\' on entity \'AccountAssessment__c\'. If you are attempting to use a custom field, be sure to append the \'__c\' after the custom field name. Please reference your WSDL or the describe call for the appropriate names.', ex.getMessage(),'エラーが正しくありません');
        }
    }
}