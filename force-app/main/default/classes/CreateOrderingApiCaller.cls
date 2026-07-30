public with sharing class CreateOrderingApiCaller {

    // ▼ フローから呼び出すメソッド
    @InvocableMethod(label='自動発注コールアウト')
    public static List<ApiResultWrapper> callOrderingApi(List<RequestWrapper> requestList) {
        List<ApiResultWrapper> results = new List<ApiResultWrapper>();

        // kari_dp_num ごとにグループ化
        Map<String, List<Map<String, Object>>> kariDpGroupedMap = new Map<String, List<Map<String, Object>>>();
        
        for (RequestWrapper input : requestList) {
            if (!kariDpGroupedMap.containsKey(input.kari_dp_num)) {
                kariDpGroupedMap.put(input.kari_dp_num, new List<Map<String, Object>>());
            }

            // ▼ hacchuu_info を配列形式に構築
            Map<String, Object> hacchuuInfo = new Map<String, Object>();
            hacchuuInfo.put('hd_hacchuukbn', input.hd_hacchuukbn);
            hacchuuInfo.put('jigyoushocode', input.jigyoushocode);
            hacchuuInfo.put('od_date', input.od_date);
            hacchuuInfo.put('hd_nyuuka_yoteidate', input.hd_nyuuka_yoteidate);
            hacchuuInfo.put('hd_sryoteidate', input.hd_sryoteidate);
            hacchuuInfo.put('tantoucode', input.tantoucode);
            hacchuuInfo.put('sr_code', input.sr_code);
            hacchuuInfo.put('sr_cname', input.sr_cname);
            hacchuuInfo.put('sh_code', input.sh_code);
            hacchuuInfo.put('shtyou_hasikbn', input.shtyou_hasikbn);
            hacchuuInfo.put('sh_yoteidate', input.sh_yoteidate);
            hacchuuInfo.put('sh_methcode', input.sh_methcode);
            hacchuuInfo.put('hd_yardcode', input.hd_yardcode);
            hacchuuInfo.put('ms_gnum', input.ms_gnum);
            hacchuuInfo.put('ms_htkbn', input.ms_htkbn);
            hacchuuInfo.put('saimukamokukbn', input.saimukamokukbn);
            hacchuuInfo.put('ms_soukocode', input.ms_soukocode);
            hacchuuInfo.put('shouhin_code', input.shouhin_code);
            hacchuuInfo.put('shouhin_hendounum', input.shouhin_hendounum);
            hacchuuInfo.put('kikaku', input.kikaku);
            hacchuuInfo.put('tz_kanrisuukbn', input.tz_kanrisuukbn);
            hacchuuInfo.put('zeiritsukbn', input.zeiritsukbn);
            hacchuuInfo.put('msunitprice_s_unitkbn', input.msunitprice_s_unitkbn);
            hacchuuInfo.put('msunit_insuu', input.msunit_insuu);
            hacchuuInfo.put('msunit_suu', input.msunit_suu);
            hacchuuInfo.put('msunitprice_s_unitcode', input.msunitprice_s_unitcode);
            hacchuuInfo.put('ms_insuu', input.ms_insuu);
            hacchuuInfo.put('ms_shisansuu', input.ms_shisansuu);
            hacchuuInfo.put('kari_unit_kbn', input.kari_unit_kbn);
            hacchuuInfo.put('sr_unitprice', input.sr_unitprice);
            hacchuuInfo.put('srgaku', input.srgaku);
            hacchuuInfo.put('srtax', input.srtax);
            hacchuuInfo.put('ms_nyuukayoteidate', input.ms_nyuukayoteidate);
            hacchuuInfo.put('ms_sr_yoteidate', input.ms_sr_yoteidate);
            hacchuuInfo.put('uw_gnum', input.uw_gnum);
            hacchuuInfo.put('lot_num', input.lot_num);
            hacchuuInfo.put('uw_insuu', input.uw_insuu);
            hacchuuInfo.put('uw_shisansuu', input.uw_shisansuu);
            hacchuuInfo.put('lot_bikou1', input.lot_bikou1);
            hacchuuInfo.put('eigyoutantou', input.eigyoutantou);
            hacchuuInfo.put('uketantou', input.uketantou);
            hacchuuInfo.put('sj_nenshiki', input.sj_nenshiki);
            hacchuuInfo.put('shonendo_month', input.shonendo_month);
            hacchuuInfo.put('shorikbn', input.shorikbn);
            hacchuuInfo.put('srj_joutai', input.srj_joutai);
            hacchuuInfo.put('shorui_senyoteidate', input.shorui_senyoteidate);
            hacchuuInfo.put('srj_ankenkbn', input.srj_ankenkbn);
            hacchuuInfo.put('eigyou_houjinkbn', input.eigyou_houjinkbn);
            hacchuuInfo.put('chk_jzkp', input.chk_jzkp);
            hacchuuInfo.put('chk_shokanfolder', input.chk_shokanfolder);
            hacchuuInfo.put('sj_nyuukapfnum_chiiki', input.sj_nyuukapfnum_chiiki);
            hacchuuInfo.put('sj_nyuukapfnum_suuji', input.sj_nyuukapfnum_suuji);
            kariDpGroupedMap.get(input.kari_dp_num).add(hacchuuInfo);
        }
        
        // グループごとに API コール
        for (String kariDpNum : kariDpGroupedMap.keySet()) {
            ApiResultWrapper result = new ApiResultWrapper();

            try {
                // JSON構築
                Map<String, Object> requestMap = new Map<String, Object>();
                requestMap.put('kari_dp_num', kariDpNum);
                requestMap.put('hacchuu_info', kariDpGroupedMap.get(kariDpNum));
                System.debug(kariDpGroupedMap.get(kariDpNum));
                String jsonBody = JSON.serialize(requestMap);
                System.debug('送信JSON: ' + jsonBody);

                // HTTPリクエスト構築
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://sccrsfapi.sococara.com/create-hacchuu');
                req.setMethod('POST');
                req.setHeader('Content-Type', 'application/json');
                
                // ▼ Basic認証
                String username = 'hanamaru';
                String password = '870870';
                Blob credentials = Blob.valueOf(username + ':' + password);
                String encodedCredentials = EncodingUtil.base64Encode(credentials);
                req.setHeader('Authorization', 'Basic ' + encodedCredentials);
                
                req.setBody(jsonBody);

                Http http = new Http();
                HttpResponse res = http.send(req);

                // ステータス判定とレスポンス処理
                if (res.getStatusCode() == 200){
                    result.statusCode = res.getStatusCode();
                    result.success = true;
                } else {
                    // エラー応答時の処理
                    ErrorWrapper errorWrapper = (ErrorWrapper) JSON.deserialize(res.getBody(), ErrorWrapper.class);
                    result.success = false;
                    result.statusCode = res.getStatusCode();
                    result.errorMessage = errorWrapper.error.message;
                }

            } catch (Exception e) {
                result.success = false;
                result.statusCode = -1;
                result.errorMessage = '例外が発生しました: ' + e.getMessage();
            }

            results.add(result);
        }

        return results;
    }

    // ▼ フローから渡すラップクラス
    public class RequestWrapper {
        @InvocableVariable(label='仮伝票番号')
        public String kari_dp_num;
        
        @InvocableVariable(label='ヘッダ発注区分')
        public String hd_hacchuukbn;

        @InvocableVariable(label='事業所コード')
        public String jigyoushocode;

        @InvocableVariable(label='発注日')
        public String od_date;
        
        @InvocableVariable(label='ヘッダ入荷予定日')
        public String hd_nyuuka_yoteidate;

        @InvocableVariable(label='ヘッダ仕入予定日')
        public String hd_sryoteidate;

        @InvocableVariable(label='担当者コード')
        public String tantoucode;        

        @InvocableVariable(label='仕入先コード')
        public String sr_code;

        @InvocableVariable(label='仕入先名')
        public String sr_cname;

        @InvocableVariable(label='支払先コード')
        public String sh_code;

        @InvocableVariable(label='支払帳端区分')
        public String shtyou_hasikbn;

        @InvocableVariable(label='支払予定日')
        public String sh_yoteidate;

        @InvocableVariable(label='支払方法コード')
        public String sh_methcode;

        @InvocableVariable(label='ヘッダ倉庫コード')
        public String hd_yardcode;

        @InvocableVariable(label='明細行番号')
        public String ms_gnum;        

        @InvocableVariable(label='明細発注区分')
        public String ms_htkbn;

        @InvocableVariable(label='債務科目区分')
        public String saimukamokukbn;

        @InvocableVariable(label='明細倉庫コード')
        public String ms_soukocode;

        @InvocableVariable(label='商品コード')
        public String shouhin_code;

        @InvocableVariable(label='商品変動特性数値')
        public String shouhin_hendounum;

        @InvocableVariable(label='規格')
        public String kikaku;

        @InvocableVariable(label='注残管理数量区分')
        public String tz_kanrisuukbn;

        @InvocableVariable(label='税率区分')
        public String zeiritsukbn;

        @InvocableVariable(label='明細単価数量単位区分')
        public String msunitprice_s_unitkbn;

        @InvocableVariable(label='明細単価員数')
        public String msunit_insuu;

        @InvocableVariable(label='明細単価数量')
        public String msunit_suu;

        @InvocableVariable(label='明細単価数量単位コード')
        public String msunitprice_s_unitcode;

        @InvocableVariable(label='明細員数')
        public String ms_insuu;

        @InvocableVariable(label='明細資産数量')
        public String ms_shisansuu;

        @InvocableVariable(label='仮単価区分')
        public String kari_unit_kbn;

        @InvocableVariable(label='仕入単価')
        public String sr_unitprice;

        @InvocableVariable(label='仕入金額')
        public String srgaku;

        @InvocableVariable(label='仕入消費税額')
        public String srtax;

        @InvocableVariable(label='明細入荷予定日')
        public String ms_nyuukayoteidate;

        @InvocableVariable(label='明細仕入予定日')
        public String ms_sr_yoteidate;

        @InvocableVariable(label='内訳行番号')
        public String uw_gnum;

        @InvocableVariable(label='ロット番号')
        public String lot_num;

        @InvocableVariable(label='内訳員数')
        public String uw_insuu;

        @InvocableVariable(label='内訳資産数量')
        public String uw_shisansuu;

        @InvocableVariable(label='ロット備考1')
        public String lot_bikou1;

        @InvocableVariable(label='営業担当')
        public String eigyoutantou;        

        @InvocableVariable(label='受付担当')
        public String uketantou;        
        
        @InvocableVariable(label='年式')
        public String sj_nenshiki;

        @InvocableVariable(label='初年度 月')
        public String shonendo_month;

        @InvocableVariable(label='処理区分')
        public String shorikbn;

        @InvocableVariable(label='状態')
        public String srj_joutai;

        @InvocableVariable(label='書類揃予定日')
        public String shorui_senyoteidate;
        
        @InvocableVariable(label='案件区分')
        public String srj_ankenkbn;  
        
        @InvocableVariable(label='営業/法人案件区分')
        public String eigyou_houjinkbn;

        @InvocableVariable(label='自動車税還付状態')
        public String chk_jzkp;
        
        @InvocableVariable(label='書類管理フォルダ')
        public String chk_shokanfolder;
        
        @InvocableVariable(label='入荷時登録番号地域')
        public String sj_nyuukapfnum_chiiki;
        
        @InvocableVariable(label='入荷時登録番号数字')
        public String sj_nyuukapfnum_suuji;
    }

    // ▼ フローに返す出力ラップクラス
    public class ApiResultWrapper {
        @InvocableVariable(label='成功フラグ') public Boolean success;
        @InvocableVariable(label='HTTPステータスコード') public Integer statusCode;
        @InvocableVariable(label='エラーメッセージ') public String errorMessage;
    }
    
    // ▼ エラー用DTO（エラーレスポンス構造に対応）
    public class ErrorWrapper {
        public Object result;
        public ErrorBody error;
    }

    public class ErrorBody {
        public String code;
        public String message;
    }
}