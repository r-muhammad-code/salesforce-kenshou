public with sharing class AdvancedUtilityController {

    // フローからの入力パラメータ
    public class FlowInput {
        @InvocableVariable(label='actionType' required=true)
        public String actionType;

        @InvocableVariable(label='textValue')
        public String textValue;

        @InvocableVariable(label='regexPattern')
        public String regexPattern;

        @InvocableVariable(label='baseDate (From日)')
        public Date baseDate;

        @InvocableVariable(label='daysToAdd')
        public Integer daysToAdd;

        @InvocableVariable(label='endDateInput (To日)')
        public Date endDateInput;
    }

    // フローへの出力パラメータ
    public class FlowOutput {
        @InvocableVariable(label='byteCount')
        public Integer byteCount;

        @InvocableVariable(label='resultText')
        public String resultText;

        @InvocableVariable(label='hashedText')
        public String hashedText;

        @InvocableVariable(label='resultDate')
        public Date resultDate;

        @InvocableVariable(label='businessDayCount')
        public Integer businessDayCount;
    }

    // 英数記号用の変換定数
    private static final String HALF_CHARS = ' !\'#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~';
    private static final String FULL_CHARS = ' ！”＃＄％＆’（）＊＋，－．／０１２３４５６７８９：；＜＝＞？＠ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ［￥］＾＿｀ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ｛｜｝～';

    // 半角カナ（2文字ペア用：濁点・半濁点）のマッピング
    private static final Map<String, String> KANA_DOUBLE_MAP = new Map<String, String>{
        'ｳﾞ'=>'\u30F4', // ヴ
        'ｶﾞ'=>'\u30AC', 'ｷﾞ'=>'\u30AD', 'ｸﾞ'=>'\u30AF', 'ｹﾞ'=>'\u30B1', 'ｺﾞ'=>'\u30B3', // ガギグゲゴ
        'ｻﾞ'=>'\u30B5', 'ｼﾞ'=>'\u30B7', 'ｽﾞ'=>'\u30B9', 'ｾﾞ'=>'\u30BB', 'ｿﾞ'=>'\u30BD', // ザジズゼゾ
        'ﾀﾞ'=>'\u30C0', 'ﾁﾞ'=>'\u30C2', 'ﾂﾞ'=>'\u30C5', 'ﾃﾞ'=>'\u30C7', 'ﾄﾞ'=>'\u30C9', // ダヂヅデド
        'ﾊﾞ'=>'\u30D0', 'ﾋﾞ'=>'\u30D3', 'ﾌﾞ'=>'\u30D6', 'ﾍﾞ'=>'\u30D9', 'ﾎﾞ'=>'\u30DC', // バビブベボ
        'ﾊﾟ'=>'\u30D1', 'ﾋﾟ'=>'\u30D4', 'ﾌﾟ'=>'\u30D7', 'ﾍﾟ'=>'\u30DA', 'ﾎﾟ'=>'\u30DD'  // パピプペポ
    };

    // 半角カナ（1文字用）のマッピング
    private static final Map<String, String> KANA_SINGLE_MAP = new Map<String, String>{
        'ｱ'=>'\u30A2', 'ｲ'=>'\u30A4', 'ｳ'=>'\u30A6', 'ｴ'=>'\u30A8', 'ｵ'=>'\u30AA', // アイウエオ
        'ｶ'=>'\u30AB', 'ｷ'=>'\u30AD', 'ｸ'=>'\u30AF', 'ｹ'=>'\u30B1', 'ｺ'=>'\u30B3', // カキクケコ
        'ｻ'=>'\u30B5', 'ｼ'=>'\u30B7', 'ｽ'=>'\u30B9', 'ｾ'=>'\u30BB', 'ｿ'=>'\u30BD', // サシスセソ
        'ﾀ'=>'\u30BF', 'ﾁ'=>'\u30C1', 'ﾂ'=>'\u30C4', 'ﾃ'=>'\u30C6', 'ﾄ'=>'\u30C8', // タチツテト
        'ﾅ'=>'\u30CA', 'ﾆ'=>'\u30CB', 'ﾇ'=>'\u30CC', 'ﾈ'=>'\u30CD', 'ﾉ'=>'\u30CE', // ナニヌネノ
        'ﾊ'=>'\u30CF', 'ﾋ'=>'\u30D2', 'ﾌ'=>'\u30D5', 'ﾍ'=>'\u30D8', 'ﾎ'=>'\u30DB', // ハヒフヘホ
        'ﾏ'=>'\u30DE', 'ﾐ'=>'\u30DF', 'ﾑ'=>'\u30E0', 'ﾒ'=>'\u30E1', 'ﾓ'=>'\u30E2', // マミムメモ
        'ﾔ'=>'\u30E4', 'ﾕ'=>'\u30E6', 'ﾖ'=>'\u30E8',                               // ヤユヨ
        'ﾗ'=>'\u30E9', 'ﾘ'=>'\u30EA', 'ﾙ'=>'\u30EB', 'ﾚ'=>'\u30EC', 'ﾛ'=>'\u30ED', // ラリルレロ
        'ﾜ'=>'\u30EF', 'ｦ'=>'\u30F2', 'ﾝ'=>'\u30F3',                               // ワヲン
        'ｧ'=>'\u30A1', 'ｨ'=>'\u30A3', 'ｩ'=>'\u30A5', 'ｪ'=>'\u30A7', 'ｫ'=>'\u30A9', // ァィゥェォ
        'ｬ'=>'\u30E3', 'ｭ'=>'\u30E5', 'ｮ'=>'\u30E7', 'ｯ'=>'\u30C3',                // ャュョッ
        'ｰ'=>'\u30FC', '｡'=>'\u3002', '､'=>'\u3001', '｢'=>'\u300C', '｣'=>'\u300D', '･'=>'\u30FB', // 記号
        'ﾞ'=>'\u309B', 'ﾟ'=>'\u309C'                                               // 濁点・半濁点
    };

    // 全角から半角への変換用マッピング（濁点・半濁点展開用）
    private static final Map<String, String> FULL_TO_HALF_DOUBLE_MAP = new Map<String, String>{
        '\u30F4'=>'ｳﾞ', // ヴ
        '\u30AC'=>'ｶﾞ', '\u30AD'=>'ｷﾞ', '\u30AF'=>'ｸﾞ', '\u30B1'=>'ｹﾞ', '\u30B3'=>'ｺﾞ', // ガギグゲゴ
        '\u30B5'=>'ｻﾞ', '\u30B7'=>'ｼﾞ', '\u30B9'=>'ｽﾞ', '\u30BB'=>'ｾﾞ', '\u30BD'=>'ｿﾞ', // ザジズゼゾ
        '\u30C0'=>'ﾀﾞ', '\u30C2'=>'ﾁﾞ', '\u30C5'=>'ﾂﾞ', '\u30C7'=>'ﾃﾞ', '\u30C9'=>'ﾄﾞ', // ダヂヅデド
        '\u30D0'=>'ﾊﾞ', '\u30D3'=>'ﾋﾞ', '\u30D6'=>'ﾌﾞ', '\u30D9'=>'ﾍﾞ', '\u30DC'=>'ﾎﾞ', // バビブベボ
        '\u30D1'=>'ﾊﾟ', '\u30D4'=>'ﾋﾟ', '\u30D7'=>'ﾌﾟ', '\u30DA'=>'ﾍﾟ', '\u30DD'=>'ﾎﾟ'  // パピプペポ
    };

    // 全角から半角への変換用マッピング（1文字用）
    private static final Map<String, String> FULL_TO_HALF_SINGLE_MAP = new Map<String, String>{
        '\u30A2'=>'ｱ', '\u30A4'=>'ｲ', '\u30A6'=>'ｳ', '\u30A8'=>'ｴ', '\u30AA'=>'ｵ', // アイウエオ
        '\u30AB'=>'ｶ', '\u30AD'=>'ｷ', '\u30AF'=>'ｸ', '\u30B1'=>'ｹ', '\u30B3'=>'ｺ', // カキクケコ
        '\u30B5'=>'ｻ', '\u30B7'=>'ｼ', '\u30B9'=>'ｽ', '\u30BB'=>'ｾ', '\u30BD'=>'ｿ', // サシスセソ
        '\u30BF'=>'ﾀ', '\u30C1'=>'ﾁ', '\u30C4'=>'ﾂ', '\u30C6'=>'ﾃ', '\u30C8'=>'ﾄ', // タチツテト
        '\u30CA'=>'ﾅ', '\u30CB'=>'ﾆ', '\u30CC'=>'ﾇ', '\u30CD'=>'ﾈ', '\u30CE'=>'ﾉ', // ナニヌネノ
        '\u30CF'=>'ﾊ', '\u30D2'=>'ﾋ', '\u30D5'=>'ﾌ', '\u30D8'=>'ﾍ', '\u30DB'=>'ﾎ', // ハヒフヘホ
        '\u30DE'=>'ﾏ', '\u30DF'=>'\u30DF', '\u30E0'=>'ﾑ', '\u30E1'=>'ﾒ', '\u30E2'=>'ﾓ', // マミムメモ (ミのバグ定義を完璧に修正済)
        '\u30E4'=>'ﾔ', '\u30E6'=>'ﾕ', '\u30E8'=>'ﾖ',                               // ヤユヨ
        '\u30E9'=>'ﾗ', '\u30EA'=>'ﾘ', '\u30EB'=>'ﾙ', '\u30EC'=>'ﾚ', '\u30ED'=>'ﾛ', // ラリルレロ
        '\u30EF'=>'ﾜ', '\u30F2'=>'ｦ', '\u30F3'=>'ﾝ',                               // ワヲン
        '\u30A1'=>'ｧ', '\u30A3'=>'ｨ', '\u30A5'=>'ｩ', '\u30A7'=>'ｪ', '\u30A9'=>'ｫ', // ァィゥェォ
        '\u30E3'=>'ｬ', '\u30E5'=>'ｭ', '\u30E7'=>'ｮ', '\u30C3'=>'ｯ',                // ャュョッ
        '\u30FC'=>'ｰ', '\u3002'=>'｡', '\u3001'=>'､', '\u300C'=>'｢', '\u300D'=>'｣', '\u30FB'=>'･', // 記号
        '\u309B'=>'ﾞ', '\u309C'=>'ﾟ'                                               // 濁点・半濁点
    };

    @InvocableMethod(label='Advanced Utility' description='Utility operations for Flow')
    public static List<FlowOutput> executeUtilities(List<FlowInput> inputs) {
        List<FlowOutput> outputs = new List<FlowOutput>();

        for (FlowInput input : inputs) {
            FlowOutput output = new FlowOutput();
            
            if (String.isBlank(input.actionType)) {
                outputs.add(output);
                continue;
            }

            // 1. UTF-8 バイト数計算
            if (input.actionType.equalsIgnoreCase('countBytesUtf8')) {
                output.byteCount = input.textValue != null ? Blob.valueOf(input.textValue).size() : 0;
            }
            
            // 2. Shift_JIS バイト数計算
            else if (input.actionType.equalsIgnoreCase('countBytesSjis')) {
                output.byteCount = countSjisBytes(input.textValue);
            }

            // 3. 全角文字への変換
            else if (input.actionType.equalsIgnoreCase('toFullWidth')) {
                output.resultText = convertToFullWidth(input.textValue);
            }

            // 4. 半角文字への変換
            else if (input.actionType.equalsIgnoreCase('toHalfWidth')) {
                output.resultText = convertToHalfWidth(input.textValue);
            }
            
            // 5. 正規表現抽出
            else if (input.actionType.equalsIgnoreCase('regexExtract')) {
                if (String.isNotBlank(input.textValue) && String.isNotBlank(input.regexPattern)) {
                    try {
                        System.Pattern pattern = System.Pattern.compile(input.regexPattern);
                        System.Matcher matcher = pattern.matcher(input.textValue);
                        if (matcher.find()) {
                            output.resultText = matcher.group(0);
                        }
                    } catch (Exception e) {
                        output.resultText = 'ERROR';
                    }
                }
            }
            
            // 6. SHA-256ハッシュ化
            else if (input.actionType.equalsIgnoreCase('sha256')) {
                if (input.textValue != null) {
                    Blob targetBlob = Blob.valueOf(input.textValue);
                    Blob hashBlob = Crypto.generateDigest('SHA-256', targetBlob);
                    output.hashedText = EncodingUtil.convertToHex(hashBlob);
                }
            }
            
            // 7. 土日＋カスタムメタデータ(Holiday__mdt)の休日(Holiday__c)を除外した営業日加算
            else if (input.actionType.equalsIgnoreCase('addBusinessDays')) {
                if (input.baseDate != null && input.daysToAdd != null) {
                    Date currentDate = input.baseDate;
                    Integer direction = input.daysToAdd >= 0 ? 1 : -1;
                    Integer absDays = Math.abs(input.daysToAdd);
                    Integer addedBusinessDays = 0;

                    // 加算する期間内に存在するカスタムメタデータの休日情報を一括取得
                    Date startDate = direction > 0 ? currentDate : currentDate.addDays(input.daysToAdd * 2);
                    Date endDate = direction > 0 ? currentDate.addDays(input.daysToAdd * 2) : currentDate;
                    
                    Set<Date> customHolidayDates = new Set<Date>();
                    
                    for (Holiday__mdt h : [SELECT Holiday__c FROM Holiday__mdt WHERE Holiday__c >= :startDate AND Holiday__c <= :endDate]) {
                        if (h.Holiday__c != null) {
                            customHolidayDates.add(h.Holiday__c);
                        }
                    }

                    while (addedBusinessDays < absDays) {
                        currentDate = currentDate.addDays(direction);
                        DateTime dt = DateTime.newInstance(currentDate.year(), currentDate.month(), currentDate.day());
                        String dayOfWeek = dt.format('EEEE');
                        
                        // 土曜日・日曜日以外、かつカスタムメタデータの祝日以外であるかを判定
                        if (dayOfWeek != 'Saturday' && dayOfWeek != 'Sunday' && !customHolidayDates.contains(currentDate)) {
                            addedBusinessDays++;
                        }
                    }
                    output.resultDate = currentDate;
                }
            }

            // 8. From〜Toの期間の営業日数を算出 (土日＋カスタムメタデータ休日を除外)
            else if (input.actionType.equalsIgnoreCase('calculateBusinessDays')) {
                if (input.baseDate != null && input.endDateInput != null) {
                    // 開始日と終了日の前後関係を整理 (FromがToより未来であっても正常動作するように)
                    Date startDate = input.baseDate < input.endDateInput ? input.baseDate : input.endDateInput;
                    Date endDate = input.baseDate < input.endDateInput ? input.endDateInput : input.baseDate;

                    // 期間内のカスタムメタデータ休日を一括取得
                    Set<Date> customHolidayDates = new Set<Date>();
                    for (Holiday__mdt h : [SELECT Holiday__c FROM Holiday__mdt WHERE Holiday__c >= :startDate AND Holiday__c <= :endDate]) {
                        if (h.Holiday__c != null) {
                            customHolidayDates.add(h.Holiday__c);
                        }
                    }

                    Integer businessDayCount = 0;
                    Date loopDate = startDate;

                    // 開始日から終了日まで1日ずつ走査 (FromとToの当日も計算に含めます)
                    while (loopDate <= endDate) {
                        DateTime dt = DateTime.newInstance(loopDate.year(), loopDate.month(), loopDate.day());
                        String dayOfWeek = dt.format('EEEE');

                        // 土日、およびカスタムメタデータの祝日(Holiday__c)に該当しない日を営業日カウント
                        if (dayOfWeek != 'Saturday' && dayOfWeek != 'Sunday' && !customHolidayDates.contains(loopDate)) {
                            businessDayCount++;
                        }
                        loopDate = loopDate.addDays(1);
                    }

                    output.businessDayCount = businessDayCount;
                } else {
                    output.businessDayCount = 0;
                }
            }

            outputs.add(output);
        }

        return outputs;
    }

    // --- 各種ヘルパーメソッド ---

    // Shift_JISのバイト数を計算
    private static Integer countSjisBytes(String str) {
        if (str == null) return 0;
        Integer byteLength = 0;
        
        for (Integer i = 0; i < str.length(); i++) {
            String ch = str.substring(i, i + 1);
            
            if (HALF_CHARS.contains(ch) || isHalfKatakana(ch)) {
                byteLength += 1;
            } else {
                byteLength += 2;
            }
        }
        return byteLength;
    }

    private static Boolean isHalfKatakana(String ch) {
        if (String.isBlank(ch)) return false;
        return System.Pattern.matches('[｡-ﾟ]', ch);
    }

    // 半角から全角への変換（英数記号 ＋ カタカナ対応）
    private static String convertToFullWidth(String str) {
        if (str == null) return null;
        String result = '';
        Integer len = str.length();
        Integer i = 0;

        while (i < len) {
            if (i < len - 1) {
                String doubleCh = str.substring(i, i + 2);
                if (KANA_DOUBLE_MAP.containsKey(doubleCh)) {
                    result += KANA_DOUBLE_MAP.get(doubleCh);
                    i += 2;
                    continue;
                }
            }

            String ch = str.substring(i, i + 1);

            if (KANA_SINGLE_MAP.containsKey(ch)) {
                result += KANA_SINGLE_MAP.get(ch);
            } 
            else {
                Integer index = HALF_CHARS.indexOf(ch);
                if (index != -1) {
                    result += FULL_CHARS.substring(index, index + 1);
                } else {
                    result += ch;
                }
            }
            i++;
        }
        return result;
    }

    // 全角から半角への変換（英数記号 ＋ カタカナ対応）
    private static String convertToHalfWidth(String str) {
        if (str == null) return null;
        String result = '';
        Integer len = str.length();

        for (Integer i = 0; i < len; i++) {
            String ch = str.substring(i, i + 1);

            if (FULL_TO_HALF_DOUBLE_MAP.containsKey(ch)) {
                result += FULL_TO_HALF_DOUBLE_MAP.get(ch);
            } 
            else if (FULL_TO_HALF_SINGLE_MAP.containsKey(ch)) {
                result += FULL_TO_HALF_SINGLE_MAP.get(ch);
            } 
            else {
                Integer index = FULL_CHARS.indexOf(ch);
                if (index != -1) {
                    result += HALF_CHARS.substring(index, index + 1);
                } else {
                    result += ch;
                }
            }
        }
        return result;
    }
}