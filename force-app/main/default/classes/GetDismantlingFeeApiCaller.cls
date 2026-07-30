public with sharing class GetDismantlingFeeApiCaller {

    // ▼ フローから呼び出すメソッド
    @InvocableMethod
    public static List<ApiResponseWrapper> callCostApi(List<ApiRequestWrapper> requests) {
        List<ApiResponseWrapper> responseList = new List<ApiResponseWrapper>();

        for (ApiRequestWrapper req : requests) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();

            request.setEndpoint('https://sccrsfapi.sococara.com/demolition-costs');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            
            // ▼ Basic認証
            String username = 'hanamaru';
            String password = '870870';
            Blob credentials = Blob.valueOf(username + ':' + password);
            String encodedCredentials = EncodingUtil.base64Encode(credentials);
            request.setHeader('Authorization', 'Basic ' + encodedCredentials);

            // DTOにマッピングしてJSON化
            RequestDTO body = new RequestDTO();
            body.prefecture = req.prefecture;
            body.keyword = req.keyword;
            body.displacement = req.displacement;
            body.order = req.order;
            body.sort_by = req.sort_by;

            request.setBody(JSON.serialize(body));

            ApiResponseWrapper resultWrapper = new ApiResponseWrapper();

            try {
                HttpResponse response = http.send(request);
                String responseBody = response.getBody();
                
                if (response.getStatusCode() == 200 && String.isNotBlank(responseBody)) {
                    ResponseDTO responseDto = (ResponseDTO) JSON.deserialize(responseBody, ResponseDTO.class);

                    if (responseDto.result != null) {
                        // 成功時
                        List<ResultItem> resultItems = responseDto.result;
        				String formattedList = '';

                        for (ResultItem item : resultItems) {
                            // 整形処理
                            String formattedString = '';
                            
                            // ▼ type
                            formattedString += (item.type == 'ヤ') ? item.type : item.type + ' ';
                            formattedString += '｜';

                            // ▼ price_class
                            formattedString += (item.price_class == 'メイン') ? item.price_class : item.price_class + '　';
                            formattedString += '｜';

                            // ▼ price の3桁カンマ
                            Decimal price = item.price != null ? item.price.setScale(0) : 0;
                            String priceStr = String.valueOf(price);
                            Integer len = priceStr.length();
                            if (len >= 4) {
                                priceStr = priceStr.substring(0, len - 3) + ',' + priceStr.substring(len - 3);
                            }
                            formattedString += priceStr + '｜';

                            // ▼ member_name（note付き）
                            String note = item.note != null ? item.note : '';
                            formattedString += item.member_name + '（' + note + '）';

                            // フィールドにセット
                            item.formattedString = formattedString;

                            formattedList = formattedList + '\n' + formattedString ;
                        }

                        resultWrapper.formattedResults = formattedList;
                        resultWrapper.results = resultItems;
                        resultWrapper.hasError = false;
                    } else if (responseDto.error != null) {
                        // errorはnull想定だったが念のため処理
                        resultWrapper.hasError = true;
                        resultWrapper.errorMessage = 'API returned error structure.';
                    }
                } else {
                    // エラー応答時の処理
                    ErrorWrapper errorWrapper = (ErrorWrapper) JSON.deserialize(response.getBody(), ErrorWrapper.class);
                    if (errorWrapper.error != null) {
                        resultWrapper.hasError = true;
                        resultWrapper.errorCode = response.getStatusCode();
                        resultWrapper.errorMessage = errorWrapper.error.message;
                    } else {
                        resultWrapper.hasError = true;
                        resultWrapper.errorCode = response.getStatusCode();
                        resultWrapper.errorMessage = 'Unknown error occurred.';
                    }
                }
            } catch (Exception e) {
                resultWrapper.hasError = true;
                resultWrapper.errorMessage = e.getMessage();
            }

            responseList.add(resultWrapper);
        }

        return responseList;
    }

    // ▼ フロー入力用ラッパークラス
    public class ApiRequestWrapper {
        @InvocableVariable(label='都道府県') public String prefecture;
        @InvocableVariable(label='キーワード') public String keyword;
        @InvocableVariable(label='排気量') public String displacement;
        @InvocableVariable(label='並び順') public String order;
        @InvocableVariable(label='並び順の基準') public String sort_by;
    }

    // ▼ フロー出力用ラッパークラス
    public class ApiResponseWrapper {
        @InvocableVariable(label='結果オブジェクト一覧') public List<ResultItem> results;
        @InvocableVariable(label='整形済み一覧') public String formattedResults;
        @InvocableVariable(label='エラーあり') public Boolean hasError;
        @InvocableVariable(label='エラーコード') public Integer errorCode;
        @InvocableVariable(label='エラーメッセージ') public String errorMessage;
    }

    // ▼ リクエストDTO
    public class RequestDTO {
        public String prefecture;
        public String keyword;
        public String displacement;
        public String order;
        public String sort_by;
    }

    // ▼ 成功レスポンスDTO
    public class ResponseDTO {
        public List<ResultItem> result;
        public Object error; // 実際はnullだが構造に合わせて保持
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

    // ▼ 結果の中身
    public class ResultItem {
        @InvocableVariable(label='解体種別') public String type;
        @InvocableVariable(label='会員名') public String member_name;
        @InvocableVariable(label='解体料金区分') public String price_class;
        @InvocableVariable(label='解体料金') public Decimal price;
        @InvocableVariable(label='備考') public String note;
        
        // ▼ フローで整形済み文字列として使用
        @InvocableVariable(label='整形済み文字列') public String formattedString;
    }
}