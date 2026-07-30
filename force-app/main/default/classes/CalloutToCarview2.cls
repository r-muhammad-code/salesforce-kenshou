public class CalloutToCarview2{
    public class RequestWrapper{
        @InvocableVariable(required=true)
        public String api_key;
        @InvocableVariable(required=true)
        public String contact_id;
    }
    public class ResponseWrapper{
        @InvocableVariable
        public String cv_name;
        @InvocableVariable
        public String cv_name_kana;
        @InvocableVariable
        public String cv_email;
        @InvocableVariable
        public String cv_tel;
        @InvocableVariable
        public String cv_postal_code;
        @InvocableVariable
        public String cv_region;
        @InvocableVariable
        public String cv_address;

        @InvocableVariable
        public String cv_contact_date;
        @InvocableVariable
        public String cv_is_broken;
        @InvocableVariable
        public String cv_car_type;
        @InvocableVariable
        public String cv_model;
        @InvocableVariable
        public String cv_model_year;
        @InvocableVariable

        public String cv_mileage_str;
        @InvocableVariable
        public Integer cv_mileage_int;

        @InvocableVariable
        public String cv_option;
        @InvocableVariable
        public String cv_user_comment;
        @InvocableVariable
        public String cv_memo;
        @InvocableVariable

        public String cv_grade;
        @InvocableVariable
        public String cv_color;
        @InvocableVariable
        public String cv_transmission;
        @InvocableVariable
        public String cv_steering;
        @InvocableVariable
        public String cv_door;
        @InvocableVariable
        public String cv_displacement;
        @InvocableVariable
        public String cv_fuel_type;
    }

    @InvocableMethod(label='APIよりデータ取得')
    public static List<ResponseWrapper> callExternalService(List<RequestWrapper> requests){
        List<ResponseWrapper> results = new List<ResponseWrapper>();
        for(RequestWrapper req : requests){
            try{
                Integer contact_id_int = Integer.valueOf(req.contact_id);
            }catch(Exception e){
                throw new AuraHandledException('contact_id is not number.');
            }
            ResponseWrapper res = new ResponseWrapper();
            String key = req.api_key; //はなまる用のcarviewAPIアクセスキー

            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint('https://bb.carview.co.jp/ecrm/api/AssessInfo.aspx');
            httpRequest.setMethod('POST');
            httpRequest.setHeader('Content-Type', 'application/x-www-form-urlencoded');

            String body = 'key=' + EncodingUtil.urlEncode(key, 'UTF-8') +
                          '&startcontactid=' + EncodingUtil.urlEncode(req.contact_id, 'UTF-8') +
                          '&endcontactid=' + EncodingUtil.urlEncode(req.contact_id, 'UTF-8');
            httpRequest.setBody(body);
            Http http = new Http();
            try{
                HttpResponse httpResponse = http.send(httpRequest);
                if(httpResponse.getStatusCode() == 200){
                    String xmlResponse = httpResponse.getBody();
                    Dom.Document doc = new Dom.Document();
                    doc.load(xmlResponse);
                    Dom.XmlNode root = doc.getRootElement();
                    String ns = root.getNamespace();
                    Dom.XmlNode itemNode = root.getChildElement('AssessInfo', ns)
                                                .getChildElement('Item', ns);
                    //個人取引先
                    res.cv_name = itemNode.getChildElement('Name', ns).getText();
                    res.cv_email = itemNode.getChildElement('EMail', ns).getText();
                    res.cv_tel = itemNode.getChildElement('Tel1', ns).getText();
                    res.cv_mileage_str = itemNode.getChildElement('Mileage', ns).getText();
                    //String->intパース処理
                    String mileage_left = res.cv_mileage_str.split('～')[0].trim();
                    String numericStr = mileage_left.replaceAll(',', '');
                    res.cv_mileage_int = Integer.valueOf(numericStr);
                    //メール本文 共通項目
                    res.cv_contact_date = itemNode.getChildElement('ContactDate', ns).getText();
                    res.cv_is_broken = itemNode.getChildElement('IsBroken', ns).getText();
                    res.cv_car_type = itemNode.getChildElement('CarType', ns).getText();
                    res.cv_name_kana = itemNode.getChildElement('NameKana', ns).getText();
                    res.cv_postal_code = itemNode.getChildElement('PostalCode', ns).getText();
                    res.cv_region = itemNode.getChildElement('Region', ns).getText();
                    res.cv_address = itemNode.getChildElement('Address', ns).getText();
                    res.cv_model = itemNode.getChildElement('Model', ns).getText();
                    res.cv_model_year = itemNode.getChildElement('ModelYear', ns).getText();
                    res.cv_option = itemNode.getChildElement('Option', ns).getText();
                    res.cv_user_comment = itemNode.getChildElement('Comment', ns).getText();
                    res.cv_memo = itemNode.getChildElement('CVComment', ns).getText();
                    //メール本文 事故車のみ項目
                    res.cv_grade = itemNode.getChildElement('Grade', ns).getText();
                    res.cv_color = itemNode.getChildElement('Color', ns).getText();
                    res.cv_transmission = itemNode.getChildElement('Transmission', ns).getText();
                    res.cv_steering = itemNode.getChildElement('Steering', ns).getText();
                    res.cv_door = itemNode.getChildElement('Door', ns).getText();
                    res.cv_displacement = itemNode.getChildElement('Displacement', ns).getText();
                    res.cv_fuel_type = itemNode.getChildElement('FuelType', ns).getText();
                }else{
                    System.debug('Callout failed with status: ' + httpResponse.getStatus());
                }
            }catch(Exception e){
                System.debug('Error: ' + e.getMessage());
            }
            results.add(res);
        }
        return results;
    }
}