@isTest
private class AdvancedUtilityControllerTest {

    // 1. UTF-8 バイト数計算のテスト
    @isTest
    static void testCountBytesUtf8() {
        List<AdvancedUtilityController.FlowInput> inputs = new List<AdvancedUtilityController.FlowInput>();
        
        AdvancedUtilityController.FlowInput input1 = new AdvancedUtilityController.FlowInput();
        input1.actionType = 'countBytesUtf8';
        input1.textValue = 'Hello'; 
        inputs.add(input1);

        AdvancedUtilityController.FlowInput inputNull = new AdvancedUtilityController.FlowInput();
        inputNull.actionType = 'countBytesUtf8';
        inputNull.textValue = null;
        inputs.add(inputNull);

        Test.startTest();
        List<AdvancedUtilityController.FlowOutput> outputs = AdvancedUtilityController.executeUtilities(inputs);
        Test.stopTest();

        System.assertEquals(5, outputs[0].byteCount, 'UTF-8バイト数が正しくありません');
        System.assertEquals(0, outputs[1].byteCount, 'Nullの場合のバイト数は0である必要があります');
    }

    // 2. Shift_JIS バイト数計算のテスト
    @isTest
    static void testCountBytesSjis() {
        List<AdvancedUtilityController.FlowInput> inputs = new List<AdvancedUtilityController.FlowInput>();
        
        AdvancedUtilityController.FlowInput input = new AdvancedUtilityController.FlowInput();
        input.actionType = 'countBytesSjis';
        input.textValue = 'abcｱｲｳ漢字'; 
        inputs.add(input);

        AdvancedUtilityController.FlowInput inputNull = new AdvancedUtilityController.FlowInput();
        inputNull.actionType = 'countBytesSjis';
        inputNull.textValue = null;
        inputs.add(inputNull);

        Test.startTest();
        List<AdvancedUtilityController.FlowOutput> outputs = AdvancedUtilityController.executeUtilities(inputs);
        Test.stopTest();

        System.assertEquals(10, outputs[0].byteCount, 'Shift_JISバイト数が正しくありません');
        System.assertEquals(0, outputs[1].byteCount, 'Nullの場合のバイト数は0である必要があります');
    }

    // 3. 全角文字への変換テスト
    @isTest
    static void testToFullWidth() {
        List<AdvancedUtilityController.FlowInput> inputs = new List<AdvancedUtilityController.FlowInput>();
        
        AdvancedUtilityController.FlowInput input = new AdvancedUtilityController.FlowInput();
        input.actionType = 'toFullWidth';
        input.textValue = 'abc123ｶﾞﾝﾊﾞﾙ!';
        inputs.add(input);

        AdvancedUtilityController.FlowInput inputNull = new AdvancedUtilityController.FlowInput();
        inputNull.actionType = 'toFullWidth';
        inputNull.textValue = null;
        inputs.add(inputNull);

        Test.startTest();
        List<AdvancedUtilityController.FlowOutput> outputs = AdvancedUtilityController.executeUtilities(inputs);
        Test.stopTest();

        System.assertEquals('ａｂｃ１２３ガンバル！', outputs[0].resultText, '全角変換結果が正しくありません');
        System.assertEquals(null, outputs[1].resultText, 'Nullの入力に対してはNullが返る必要があります');
    }

    // 4. 半角文字への変換テスト
    @isTest
    static void testToHalfWidth() {
        List<AdvancedUtilityController.FlowInput> inputs = new List<AdvancedUtilityController.FlowInput>();
        
        AdvancedUtilityController.FlowInput input = new AdvancedUtilityController.FlowInput();
        input.actionType = 'toHalfWidth';
        input.textValue = '１２３４５ＡＢＣＤＥガンダム！';
        inputs.add(input);

        AdvancedUtilityController.FlowInput inputNull = new AdvancedUtilityController.FlowInput();
        inputNull.actionType = 'toHalfWidth';
        inputNull.textValue = null;
        inputs.add(inputNull);

        Test.startTest();
        List<AdvancedUtilityController.FlowOutput> outputs = AdvancedUtilityController.executeUtilities(inputs);
        Test.stopTest();

        System.assertEquals('12345ABCDEｶﾞﾝﾀﾞﾑ!', outputs[0].resultText, '半角変換結果が正しくありません');
        System.assertEquals(null, outputs[1].resultText, 'Nullの入力に対してはNullが返る必要があります');
    }

    // 5. 正規表現抽出のテスト (正常系・エラー系)
    @isTest
    static void testRegexExtract() {
        List<AdvancedUtilityController.FlowInput> inputs = new List<AdvancedUtilityController.FlowInput>();
        
        AdvancedUtilityController.FlowInput input1 = new AdvancedUtilityController.FlowInput();
        input1.actionType = 'regexExtract';
        input1.textValue = '注文番号: CN-20260722 です';
        input1.regexPattern = 'CN-\\d{8}';
        inputs.add(input1);

        AdvancedUtilityController.FlowInput inputError = new AdvancedUtilityController.FlowInput();
        inputError.actionType = 'regexExtract';
        inputError.textValue = 'テスト';
        inputError.regexPattern = '[a-z'; 
        inputs.add(inputError);

        Test.startTest();
        List<AdvancedUtilityController.FlowOutput> outputs = AdvancedUtilityController.executeUtilities(inputs);
        Test.stopTest();

        System.assertEquals('CN-20260722', outputs[0].resultText, '正規表現での抽出結果が正しくありません');
        System.assertEquals('ERROR', outputs[1].resultText, '不正な正規表現パターンの場合はERRORが返る必要があります');
    }

    // 6. SHA-256 ハッシュ化のテスト
    @isTest
    static void testSha256() {
        List<AdvancedUtilityController.FlowInput> inputs = new List<AdvancedUtilityController.FlowInput>();
        
        AdvancedUtilityController.FlowInput input = new AdvancedUtilityController.FlowInput();
        input.actionType = 'sha256';
        input.textValue = 'salesforce';
        inputs.add(input);

        Test.startTest();
        List<AdvancedUtilityController.FlowOutput> outputs = AdvancedUtilityController.executeUtilities(inputs);
        Test.stopTest();

        System.assertNotEquals(null, outputs[0].hashedText, 'ハッシュ化結果がNullであってはなりません');
        System.assertEquals(64, outputs[0].hashedText.length(), 'SHA-256ハッシュ文字列は64文字である必要があります');
    }

    // 7. 営業日加算のテスト
    @isTest
    static void testAddBusinessDays() {
        List<AdvancedUtilityController.FlowInput> inputs = new List<AdvancedUtilityController.FlowInput>();
        
        AdvancedUtilityController.FlowInput inputAdd = new AdvancedUtilityController.FlowInput();
        inputAdd.actionType = 'addBusinessDays';
        inputAdd.baseDate = Date.newInstance(2026, 6, 12);
        inputAdd.daysToAdd = 2;
        inputs.add(inputAdd);

        AdvancedUtilityController.FlowInput inputSub = new AdvancedUtilityController.FlowInput();
        inputSub.actionType = 'addBusinessDays';
        inputSub.baseDate = Date.newInstance(2026, 6, 15);
        inputSub.daysToAdd = -2;
        inputs.add(inputSub);

        Test.startTest();
        List<AdvancedUtilityController.FlowOutput> outputs = AdvancedUtilityController.executeUtilities(inputs);
        Test.stopTest();

        System.assertEquals(Date.newInstance(2026, 6, 16), outputs[0].resultDate, '営業日加算結果が正しくありません');
        System.assertEquals(Date.newInstance(2026, 6, 11), outputs[1].resultDate, '営業日減算結果が正しくありません');
    }

    // 8. 営業日数算定のテスト
    @isTest
    static void testCalculateBusinessDays() {
        List<AdvancedUtilityController.FlowInput> inputs = new List<AdvancedUtilityController.FlowInput>();
        
        AdvancedUtilityController.FlowInput input1 = new AdvancedUtilityController.FlowInput();
        input1.actionType = 'calculateBusinessDays';
        input1.baseDate = Date.newInstance(2026, 6, 12);
        input1.endDateInput = Date.newInstance(2026, 6, 16);
        inputs.add(input1);

        AdvancedUtilityController.FlowInput inputReverse = new AdvancedUtilityController.FlowInput();
        inputReverse.actionType = 'calculateBusinessDays';
        inputReverse.baseDate = Date.newInstance(2026, 6, 16);
        inputReverse.endDateInput = Date.newInstance(2026, 6, 12);
        inputs.add(inputReverse);

        AdvancedUtilityController.FlowInput inputNull = new AdvancedUtilityController.FlowInput();
        inputNull.actionType = 'calculateBusinessDays';
        inputNull.baseDate = Date.newInstance(2026, 6, 12);
        inputNull.endDateInput = null;
        inputs.add(inputNull);

        Test.startTest();
        List<AdvancedUtilityController.FlowOutput> outputs = AdvancedUtilityController.executeUtilities(inputs);
        Test.stopTest();

        System.assertEquals(3, outputs[0].businessDayCount, '営業日数算出結果が正しくありません');
        System.assertEquals(3, outputs[1].businessDayCount, 'From/Toが逆の場合でも正しく算出される必要があります');
        System.assertEquals(0, outputs[2].businessDayCount, '日付パラメータ不足時は0が返る必要があります');
    }

    // 9. 空のアクションタイプや未定義アクションタイプの例外系テスト
    @isTest
    static void testBlankAndInvalidActionType() {
        List<AdvancedUtilityController.FlowInput> inputs = new List<AdvancedUtilityController.FlowInput>();
        
        AdvancedUtilityController.FlowInput inputBlank = new AdvancedUtilityController.FlowInput();
        inputBlank.actionType = '';
        inputs.add(inputBlank);

        AdvancedUtilityController.FlowInput inputInvalid = new AdvancedUtilityController.FlowInput();
        inputInvalid.actionType = 'unknownAction';
        inputs.add(inputInvalid);

        Test.startTest();
        List<AdvancedUtilityController.FlowOutput> outputs = AdvancedUtilityController.executeUtilities(inputs);
        Test.stopTest();

        System.assertEquals(2, outputs.size(), '出力リストのサイズが入力と一致する必要があります');
        System.assertEquals(null, outputs[0].resultText, '空のアクションタイプ時は各結果がNullである必要があります');
        System.assertEquals(null, outputs[1].resultText, '未定義のアクションタイプ時は各結果がNullである必要があります');
    }
}