public without sharing class CalloutToDataLineAI{
    private static DataLineApi_Data__c DataLineApiData = DataLineApi_Data__c.getOrgDefaults();
    private static final String client_key = DataLineApiData.client_key__c;
    private static final String CRYPTO_KEY = DataLineApiData.CRYPTO_KEY__c;

    private static final Set<String> DECRYPT_TARGETS = new Set<String>{
        'guest_name',
        'mail_adress',
        'owner_name',
        'owner_adress',
        'user_name',
        'user_adress'
    };

    public class RequestWrapper{
        @InvocableVariable(required=true) public String shonin_date_from;  //ex.20260408171000
        @InvocableVariable(required=true) public String shonin_date_to;    //ex.20260408171500
        @InvocableVariable public String satei_id; //custom_satei_idではなくsatei_idの指定が必要
    }

    // ★ フローに返す結果用の器を拡張（件数などを追加）
    public class SyncResult{
        @InvocableVariable public Boolean is_success;
        @InvocableVariable public Boolean has_error;
        @InvocableVariable public String errorMessage;
        @InvocableVariable public Integer total_count;  // 取得した総データ数
        @InvocableVariable public Integer insert_count; // 新規作成された数
        @InvocableVariable public Integer update_count; // 更新された数
        @InvocableVariable public Integer error_count;  // エラーになった数
    }

    @InvocableMethod(label='DataLine査定データの取得・同期')
    public static List<SyncResult> getSateiData(List<RequestWrapper> requests) {
        List<SyncResult> results_list = new List<SyncResult>();
        SyncResult result = new SyncResult();

        // ★ 変数の初期化
        result.is_success = true;
        result.has_error = false;
        result.errorMessage = '';
        result.total_count = 0;
        result.insert_count = 0;
        result.update_count = 0;
        result.error_count = 0;
        results_list.add(result);

        String session_id = GetSessionId();
        if(String.isBlank(session_id)){
            results_list[0].is_success = false;
            results_list[0].errorMessage = 'ログイン失敗のためデータ取得をスキップ';
            System.debug('ログイン失敗のためデータ取得をスキップ');
            return results_list;
        }
        for (RequestWrapper req : requests) {
            String endpoint = DataLineApiData.get_endpoint__c;
            endpoint += '?client_key=' + client_key;
            endpoint += '&session_id=' + session_id;
            endpoint += '&shonin_date_from=' + req.shonin_date_from;
            endpoint += '&shonin_date_to=' + req.shonin_date_to;
            if(String.isNotBlank(req.satei_id)){
                endpoint += '&satei_id=' + req.satei_id;
            }

            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint(endpoint);
            httpRequest.setMethod('GET');
            httpRequest.setTimeout(60000);
            httpRequest.setHeader('User-Agent', 'DataLineAIsatei-API/2.0');
            try{
                HttpResponse res = new Http().send(httpRequest);
                if(res.getStatusCode() == 200){
                    Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                    List<Object> records = (List<Object>)root.get('list');
                    if(records != null && !records.isEmpty()){

                        results_list[0].total_count = records.size();

                        List<AiAssessmentSync__c> upsertList = new List<AiAssessmentSync__c>();
                        Map<String, Object> tmp = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(new AssessmentDataDef()));
                        Set<String> definedFields = tmp.keySet();

                        Map<String, Schema.SObjectField> fieldMap = AiAssessmentSync__c.SObjectType.getDescribe().fields.getMap();

                        for(Object obj : records){
                            Map<String, Object> row = (Map<String, Object>)obj;
                            AiAssessmentSync__c syncRecord = new AiAssessmentSync__c();

                            // 1. option_list の整形
                            if (row.containsKey('option_list') && row.get('option_list') instanceof List<Object>) {
                                Map<String, String> labels = new Map<String, String>{
                                    'seq'=>'番号', 'view_num'=>'表示順', 'option_nm'=>'詳細名',
                                    'option_select_cd'=>'コード', 'option_select_nm'=>'項目名', 'option_select_price'=>'価格'
                                };
                                syncRecord.option_list__c = formatNestedList((List<Object>)row.get('option_list'), labels);
                            }
                            // 2. kikan_list の整形
                            if (row.containsKey('kikan_list') && row.get('kikan_list') instanceof List<Object>) {
                                Map<String, String> labels = new Map<String, String>{
                                    'kikan_cd'=>'ステータスコード', 'kikan_nm'=>'ステータス',
                                    'kikan_item_cd'=>'アイテムコード', 'kikan_item_nm'=>'アイテム'
                                };
                                syncRecord.kikan_list__c = formatNestedList((List<Object>)row.get('kikan_list'), labels);
                            }
                            // 3. denso_list の整形
                            if (row.containsKey('denso_list') && row.get('denso_list') instanceof List<Object>) {
                                Map<String, String> labels = new Map<String, String>{
                                    'denso_cd'=>'ステータスコード', 'denso_nm'=>'ステータス',
                                    'denso_item_cd'=>'アイテムコード', 'denso_item_nm'=>'アイテム'
                                };
                                syncRecord.denso_list__c = formatNestedList((List<Object>)row.get('denso_list'), labels);
                            }

                            for(String key : definedFields){
                                if(key == 'option_list' || key == 'kikan_list' || key == 'denso_list') continue;
                                String json_key = (key == 'number_ex') ? 'number' : key;
                                if(row.containsKey(json_key) && row.get(json_key) != null){
                                    String field_name = key + '__c';
                                    if(key == 'number_ex') field_name = 'number__c';
                                    Object rawValue = row.get(json_key);

                                    if (DECRYPT_TARGETS.contains(json_key)) {
                                        rawValue = decryptText((String)rawValue, CRYPTO_KEY);
                                    }
                                    if(fieldMap.containsKey(field_name)){
                                        Schema.DescribeFieldResult dfr = fieldMap.get(field_name).getDescribe();
                                        Schema.DisplayType targetType = dfr.getType();
                                        String strValue = String.valueOf(rawValue);
                                        try{
                                            strValue = (rawValue==null) ? '' : String.valueOf(rawValue).trim();
                                            if(String.isBlank(strValue) || strValue.equalsIgnoreCase('null')){
                                                continue;
                                            }
                                            if (targetType == Schema.DisplayType.STRING || targetType == Schema.DisplayType.TEXTAREA) {
                                                strValue = convertZenkakuToHankaku(strValue);
                                                rawValue = strValue;
                                            }
                                            if(targetType == Schema.DisplayType.DATE){
                                                syncRecord.put(field_name, Date.valueOf(strValue.replace('/', '-')));
                                            }else if(targetType == Schema.DisplayType.DATETIME){
                                                syncRecord.put(field_name, Datetime.valueOf(strValue.replace('/', '-')));
                                            }else if(targetType == Schema.DisplayType.DOUBLE || targetType == Schema.DisplayType.CURRENCY){
                                                syncRecord.put(field_name, Decimal.valueOf(strValue));
                                            }else{
                                                syncRecord.put(field_name, rawValue);
                                            }
                                        }catch(Exception e){
                                            System.debug('CastError:column=' + field_name + ', value=' + strValue + ', ErrorMessage=' + e.getMessage());
                                            results_list[0].has_error = true;
                                            results_list[0].errorMessage += '項目キャストエラー(ID:' + row.get('satei_id') + '): ' + field_name + '\n';
                                        }
                                    }
                                }
                            }
                            upsertList.add(syncRecord);
                        }
                        if(!upsertList.isEmpty()){
                            Schema.SObjectField externalIdField = AiAssessmentSync__c.Fields.satei_id__c;

                            Database.UpsertResult[] srList = Database.upsert(upsertList, externalIdField, false);

                            for (Integer i = 0; i < srList.size(); i++) {
                                if (srList[i].isSuccess()) {
                                    if (srList[i].isCreated()) {
                                        results_list[0].insert_count++;
                                    } else {
                                        results_list[0].update_count++;
                                    }
                                } else {
                                    results_list[0].has_error = true;
                                    results_list[0].error_count++;

                                    String failedId = (String)upsertList[i].get('satei_id__c');
                                    for(Database.Error err : srList[i].getErrors()) {
                                        results_list[0].errorMessage += 'Upsertエラー(ID:' + failedId + ') - ' + err.getMessage() + '\n';
                                    }
                                }
                            }
                        }
                    }
                    if (results_list[0].is_success) {
                        List<DataLineAPI_SyncStatus__c> settings = [SELECT Id, LastSyncDatetime__c FROM DataLineAPI_SyncStatus__c LIMIT 1];
                        if (!settings.isEmpty()) {
                            DataLineAPI_SyncStatus__c mySetting = settings[0];
                            mySetting.LastSyncDatetime__c = Datetime.now();
                            update mySetting;
                        } else {
                            System.debug('カスタム設定のレコードが1件も登録されていません。');
                        }
                    }
                }else{
                    System.debug('Callout failed with status: ' + res.getStatus());
                    results_list[0].is_success = false;
                    results_list[0].errorMessage += 'API連携エラー: ステータスコード ' + res.getStatus() + '\n'; // ★
                }
            }catch(Exception e){
                System.debug('ERROR: ' + e.getMessage());
                results_list[0].is_success = false;
                results_list[0].errorMessage += 'システムエラー: ' + e.getMessage() + '\n'; // ★
            }
        }
        return results_list;
    }

    public static String GetSessionId(){
        String account_id = DataLineApiData.account_id__c;
        String endpoint = DataLineApiData.session_id_endpoint__c;
        endpoint += '?client_key=' + client_key;
        endpoint += '&account_id=' + account_id;

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setHeader('User-Agent', 'DataLineAIsatei-API/2.0');

        Http http = new Http();
        String session_id;

        try{
            HttpResponse res = http.send(req);
            if(res.getStatusCode() == 200){
                Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                session_id = (String)root.get('session_id');
            }
        }catch(Exception e){
            System.debug('エラー発生' + e.getMessage());
        }
        return session_id;
    }

    private static String decryptText(String encryptedInput, String keyStr) {
        if (String.isBlank(encryptedInput)) return '';

        try {
            String decodedUrl = EncodingUtil.urlDecode(encryptedInput, 'UTF-8');
            String rawenc = EncodingUtil.base64Decode(decodedUrl).toString();
            Blob encryptedRaw = EncodingUtil.base64Decode(rawenc);
            Blob key = Blob.valueOf(keyStr);
            Blob iv = Blob.valueOf(String.fromCharArray(new List<Integer>{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}));
            Blob decryptedData64Blob = Crypto.decrypt('AES256', key, iv, encryptedRaw);
            return EncodingUtil.base64Decode(decryptedData64Blob.toString()).toString();
        } catch (Exception e) {
            System.debug('### 復号失敗: ' + e.getMessage() + ' / 対象データ: ' + encryptedInput);
            return encryptedInput;
        }
    }

    private static String formatNestedList(List<Object> targetList, Map<String, String> labelMap) {
    if (targetList == null || targetList.isEmpty()) return '';
        List<String> lines = new List<String>();
        for (Object obj : targetList) {
            Map<String, Object> item = (Map<String, Object>)obj;
            List<String> entry = new List<String>();
            for (String key : labelMap.keySet()) {
                if (item.containsKey(key) && item.get(key) != null) {
                    entry.add(labelMap.get(key) + ': ' + String.valueOf(item.get(key)));
                }
            }
            lines.add('・' + String.join(entry, ' / '));
        }
        return String.join(lines, '\n');
    }

    private static String convertZenkakuToHankaku(String target) {
        if (String.isBlank(target)) return target;
        String result = '';
        for (Integer i = 0; i < target.length(); i++) {
            Integer code = target.charAt(i);
            if (code >= 65281 && code <= 65374) {
                result += String.fromCharArray(new List<Integer>{code - 65248});
            } else if (code == 12288) {
                result += ' ';
            } else {
                result += String.fromCharArray(new List<Integer>{code});
            }
        }
        return result;
    }
}