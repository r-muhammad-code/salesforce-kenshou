public without sharing class CommonUtility {

    // コンストラクタ
    public CommonUtility() {
    }

    
    /**
     * 文字列のリストを結合後、ある文字数で分割してログに出力する
     */
    static public void logDivString(List<String> strList) {
        String str = '';
        for(String s:strList) {
            str = str + s + ',';
        }
        str = str.removeEnd(',');
        logDivString(str);
    }

    /**
     * 文字列を、ある文字数で分割してログに出力する
     */
    static public void logDivString(String str) {
        List<String> stList = divString(str, 300);

//        Integer i = 1;
        for(String st:stList) {
//            System.debug('#' + String.valueOf(i) + ' : ' + st);
//            i++;
            System.debug(st);
        }
    }

    /**
     * 文字列を指定された文字数で分割して、リスト化する
     */
    static private List<String> divString(String str, Integer divLen) {
        List<String> rtnSt = new List<String>();
        Integer stLen = str.length();

        // 文字が空白、または文字数が指定改行文字数以下の場合はそのままの値を返す
        if(String.isBlank(str) || stLen <= divLen){
            rtnSt.add(str);
        }
        else{
           // 小数点を出す為にDecimal型で計算
            Decimal decimalStRows = Decimal.valueOf(stLen) / Decimal.valueOf(divLen);
            // 切り上げ処理で内容の行数を取得
            Integer stRows = Integer.valueOf(decimalStRows.round(System.RoundingMode.UP));
            // 最初の改行まで取得+改行コード付与
            rtnSt.add(str.substring(0, divLen));
            // 2行目以降をループ処理
            for(Integer i = 1; i < stRows; i++){
                if(divLen*(i + 1) < stLen){
                    rtnSt.add(str.substring(divLen*i, divLen*(i + 1)));
                }else{
                    // 最後の文字まで取得
                    rtnSt.add(str.substring(divLen*i));
                }
            }
        }
        return rtnSt;
    }


}