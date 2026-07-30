/*
 * 共通処理ユーティリティクラス
 */
public without sharing class AssetCommonUtility {
    // メーカーマスタDaoインスタンス
    MakerDao makerDao = new MakerDao();

    // 車種マスタDaoインスタンス
    ModelDao modelDao = new ModelDao();

    // 査定ユーザマスタDaoインスタンス
    AssessUsersDao assUsrDao = new AssessUsersDao();

    // コンストラクタ
    public AssetCommonUtility() {
    }

    /**
     * 選択リストを作成する（マスタから取得）
     */
    public List<SelectOption> getSelectList(String objName){

        // 選択リスト
        List<SelectOption> selList = new List<SelectOption>();
        // 先頭にブランクを追加
        selList.add( new SelectOption('blank', ''));

        // メーカ
        if(objName == AssetConstants.MAKER){
            // マスタを全件取得
            List<Mst_Makers__c> objList = makerDao.getAllMaker();
            // リストを作成
            for(Mst_Makers__c obj : objList){
                if(!String.isBlank(obj.inum__c) && !String.isBlank(obj.Name)){
                    selList.add( new SelectOption(obj.inum__c, obj.Name));
                }
            }
        }
        // 車種
/*        else if(objName == AssetConstants.MODEL){
            // 車種マスタはメーカーマスタの選択で動的に変化するため、ここでは取得しない
        }
*/
        // その他
        else{
            // selListは空のまま
        }

        return selList;
    }


    /**
     * 選択リストを作成する（項目から取得）
     */
    public List<SelectOption> getSelectList(String objName, String itemName){
        System.debug('選択リスト作成start：' + objName + ' , ' + itemName);

        // 選択リスト
        List<SelectOption> selList = new List<SelectOption>();
        // 先頭にブランクを追加
        selList.add( new SelectOption('blank', ''));

        // 選択リスト値を取得
        List<Schema.PicklistEntry> pickList = getPicklist(objName, itemName);
        // 選択リストを作成
        for(Schema.PicklistEntry p : pickList){
            System.debug('p.getValue() : ' + p.getValue());
            System.debug('p.getLabel() : ' + p.getLabel());
            selList.add( new SelectOption(p.getValue(), p.getLabel()));
        }
        // Valueでソート
        selList.sort();

        System.debug('選択リスト作成end：' + objName + ' , ' + itemName);
        return selList;
    }


    /**
     * 選択されたメーカー文字列（複数選択リスト値）から車種選択リストを作成する
     */
    public List<SelectOption> getModelSelectList(List<String> makerList){
        System.debug('getSelectList 車種選択リスト取得 start');
        // 新規車種リスト
        List<SelectOption> modelList = new List<SelectOption>();

        // 選択されたメーカーに紐づく車種を取得
        List<Mst_Models__c> modelListResult = modelDao.getSelectModel(makerList);
        for (Mst_Models__c modelResult : modelListResult) {
            if(!String.isBlank(modelResult.inum__c) && !String.isBlank(modelResult.Name)){
                modelList.add(new SelectOption(modelResult.inum__c, modelResult.Name));
            }
        }

        // inumでソート
        if(!modelList.isEmpty()){
            modelList.sort();
            // 先頭にブランクを追加
            modelList.add( 0, new SelectOption('blank', ''));
        }

        System.debug('getSelectList 車種選択リスト取得 end');

        return modelList;
    }


    /**
     * 選択された統括部門文字列（複数選択リスト値）から査定担当者選択リストを作成する
     */
    public List<SelectOption> getAssessTantoSelectList(List<String> manageBumonList){
        System.debug('getAssessTantoSelectList 査定担当者選択リスト取得 start');
        // 新規査定担当者リスト
        List<SelectOption> tantoList = new List<SelectOption>();
        // 先頭にブランクを追加
        tantoList.add( new SelectOption('blank', ''));

        // 選択された統括部門の査定担当者を取得
        List<Mst_Assess_Users__c> tantoListResult = assUsrDao.getAssessTanto(manageBumonList);
        System.debug('tantoListResult : '+ tantoListResult);
        for (Mst_Assess_Users__c tanto : tantoListResult) {
            if(!String.isBlank(tanto.login_user__c) && !String.isBlank(tanto.Name)){
                tantoList.add(new SelectOption(tanto.login_user__c, tanto.Name));
            }
        }
        System.debug('tantoList : '+ tantoList);

        System.debug('getAssessTantoSelectList 査定担当者選択リスト取得 end');

        return tantoList;
    }

    // SALESSTRATEGY-4557：派生対応 有効な査定ユーザの統括部門を取得
    /**
     * 有効な査定ユーザに設定されている統括部門からリストを作成する
     */
    public List<SelectOption> getManegeOrgSelectList(){
        // 選択リスト
        List<SelectOption> selList = new List<SelectOption>();
        // 有効な査定ユーザの統括部門を取得　
        List<Mst_Assess_Users__c> objList = assUsrDao.getAssessManageOrg();
        // リストを作成
        for(Mst_Assess_Users__c obj : objList){
            if(!String.isBlank(obj.manage_org__c)){
                selList.add( new SelectOption(obj.manage_org__c, obj.manage_org__c));
            }
        }

        // inumでソート
        if(!selList.isEmpty()){
            selList.sort();
            // 先頭にブランクを追加
            selList.add( 0, new SelectOption('blank', ''));
        }

        return selList;
    }


    /**
     * 項目の選択リスト値取得
     */
    public List<Schema.PicklistEntry> getPicklist(String sObjName, String fieldName){

        List<Schema.PicklistEntry> pickList;
        Schema.SObjectType sObjType = (Schema.SObjectType) Schema.getGlobalDescribe().get(sObjName);

        if(sObjType != null){
            Map<String, Schema.SObjectField> fieldmap = sObjType.getDescribe().fields.getMap();
            Schema.SObjectField f = (Schema.SObjectField) fieldmap.get(fieldName);
            if(f != null) {
                Schema.DescribeFieldResult r = f.getDescribe();
                // *****以下を追記*****/
                if (r.getType() == Schema.DisplayType.Picklist) {
                    pickList = r.getPicklistValues();
                    System.debug('値' + pickList);
                }
            }
        }
        return pickList;
    }


    /**
     * リストの中身を「'」で囲って返却する
     */
    public String convertSingleQuote(List<String> targetList){
        String afterTarget = '';
        for (String target : targetList) {
            afterTarget += '\''+target+'\',';
        }
        afterTarget = afterTarget.removeEnd(',');
        afterTarget = '(' + afterTarget + ')';

        return afterTarget;
    }

/*
    public void logDivString(List<String> strList) {
        String str = '';
        for(String s:strList) {
            str = str + s + ',';
        }
        str = str.removeEnd(',');
        logDivString(str);
    }

    public void logDivString(String str) {
        List<String> stList = divString(str, 300);

        Integer i = 1;
        for(String st:stList) {
            System.debug('[soql_' + String.valueOf(i) + '] ' + st);
            i++;
        }
    }

    public List<String> divString(String str, Integer divLen) {
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
*/

    public Integer calcFirstRow(Integer page, Integer size) {
        System.debug('■■■ calcFirstRow() Start ■■■');
            return Math.max(0, (page - 1) * size);
    }

    //リストサイズから合計ページ数を算出
    public Integer totalPageNumber(Integer listSize, Integer pageSize){
        System.debug('■■■ totalPageNumber() Start ■■■');
        //200件以下の場合1ページ
        if(listSize >= pageSize){
            return Integer.valueOf((((Decimal)listSize / (Decimal)pageSize)).round(System.RoundingMode.UP));
        } else {
            return 1;
        }
    }

    /*
     * 翻訳マスタを取得する
     * return:Map<field_name, Map<num, Translation__c>>
     */
    public static Map<String, Map<Decimal, TranslationMaster__c>> getTranslationMaster(){
        System.debug('getTranslationMaster start');
        Map<String, Map<Decimal, TranslationMaster__c>> tmMap = new Map<String, Map<Decimal, TranslationMaster__c>>();

        List<TranslationMaster__c> tmList = [
            SELECT
                Id
                ,Name
                ,Number__c
                ,Field__c
                ,FieldApiName__c
                ,Japanese__c
                ,English__c
                ,Russian__c
                ,Chinese__c
                ,Spanish__c
                ,ExtraID__c
            FROM
                TranslationMaster__c
            ORDER BY
                FieldApiName__c, Number__c
            LIMIT 50000
        ];
        System.debug('tmList.size() : ' + tmList.size());

        for(TranslationMaster__c tm:tmList){
            if(!tmMap.containsKey(tm.FieldApiName__c)){
                tmMap.put(tm.FieldApiName__c, new Map<Decimal, TranslationMaster__c>());
            }
            tmMap.get(tm.FieldApiName__c).put(tm.Number__c, tm);
        }

        System.debug('tmMap : ' + tmMap);
        System.debug('getTranslationMaster end');
        return tmMap;
    }

    /*
     * 翻訳マスタを取得する
     * return:Map<field_name, Map<num, Translation__c>>
     */
    public String getTranslation(String numString, String apiName, String lang){

        String langApiName;
        Decimal num = checkNum(numString);

        if(num == null){
            return '';
        }

        try{
            if(lang == Constants.LANG_JAPANESE || lang == Constants.LANG_ENGLISH || lang == Constants.LANG_RUSSIAN || lang == Constants.LANG_CHINESE || lang == Constants.LANG_SPANISH){
                langApiName = lang + '__c';
                if(Constants.MST_TRANSLATION.containsKey(apiName)){
                    if(Constants.MST_TRANSLATION.get(apiName).containsKey(num)){
                        return (String)Constants.MST_TRANSLATION.get(apiName).get(num).get(langApiName);
                    }
                }
            }
        }
        catch(Exception e){
            System.debug('getTranslation Error : ' + e.getMessage());
            return '';
        }
        System.debug('getTranslationMaster return empty');
        return '';
    }

    /*
     * 文字列が数値なら数値型に変換して返し、数値以外ならnullを返す
     */
    private Decimal checkNum(String numString){
        if(!String.isBlank(numString) && numString.isNumeric()){
            return Decimal.valueOf(numString);
        }
        else{
            return null;
        }
    }

    /*
     * 複数選択リストの文字列を翻訳して返す
     */
    public String getTranslatedMulti(String orgString, String apiName, String lang){

        String translatedString;
        List<String> orgStringList = new List<String>();
        List<String> translatedStringList = new List<String>();

        // 複数選択リストの選択項目を分割してリストに格納
        if(!String.isEmpty(orgString)){
            orgStringList = orgString.split(';');
        }
        else{
            return '';
        }

        // リストの各文字列を翻訳してリストに格納
        for(String numString:orgStringList){
            translatedStringList.add(getTranslation(numString, apiName, lang));
        }

        // 翻訳後リストの各文字列をセミコロンで結合
        translatedString = String.join(translatedStringList, ';');

        return translatedString;
    }
}