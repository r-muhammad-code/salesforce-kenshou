public class CalloutToCarview{
    public class RequestWrapper{
        @InvocableVariable(required=true)
        public Id case_id;
        @InvocableVariable(required=true)
        public String contact_id;
        @InvocableVariable(required=true)
        public String mail_media;
        @InvocableVariable(required=true)
        public String mail_email;
        @InvocableVariable(required=true)
        public String mail_subject;
        @InvocableVariable(required=true)
        public String mail_body;
        @InvocableVariable(required=true)
        public String owner_id;
    }

    @InvocableMethod(label='ケースから個人取引先と買取受付を作成しケースを更新(外部サービス連携)')
    public static void callExternalService(List<RequestWrapper> requests){
        for(RequestWrapper req : requests){
            Case c = [SELECT Id FROM Case WHERE Id = :req.case_id LIMIT 1];
            String key = 'w70vR38PYESZqvf7YNzTqHJCbeuW7bbA'; //はなまる用のcarviewAPIアクセスキー

            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint('https://bb.carview.co.jp/ecrm/api/AssessInfo.aspx');
            httpRequest.setMethod('POST');
            httpRequest.setHeader('Content-Type', 'application/x-www-form-urlencoded');

            String body = 'key=' + EncodingUtil.urlEncode(key, 'UTF-8') +
                          '&startcontactid=' + EncodingUtil.urlEncode(req.contact_id, 'UTF-8') +
                          '&endcontactid=' + EncodingUtil.urlEncode(req.contact_id, 'UTF-8');
            httpRequest.setBody(body);

            Http http = new Http();
            HttpResponse httpResponse;

            try{
                httpResponse = http.send(httpRequest);
                if(httpResponse.getStatusCode() == 200){
                    String xmlResponse = httpResponse.getBody();
                    Dom.Document doc = new Dom.Document();
                    doc.load(xmlResponse);
                    Dom.XmlNode root = doc.getRootElement();
                    String ns = root.getNamespace();
                    Dom.XmlNode itemNode = root.getChildElement('AssessInfo', ns)
                                               .getChildElement('Item', ns);
                    //既存項目
                    String cv_name = itemNode.getChildElement('Name', ns).getText();
                    String cv_email = itemNode.getChildElement('EMail', ns).getText();
                    String cv_tel = itemNode.getChildElement('Tel1', ns).getText();
                    String cv_mileage = itemNode.getChildElement('Mileage', ns).getText();

                    //Mail_本文に追加する項目
                    String cv_contact_date = itemNode.getChildElement('ContactDate', ns).getText();
                    String cv_is_broken = itemNode.getChildElement('IsBroken', ns).getText();
                    String cv_car_type = itemNode.getChildElement('CarType', ns).getText();
                    String cv_name_kana = itemNode.getChildElement('NameKana', ns).getText();
                    String cv_postal_code = itemNode.getChildElement('PostalCode', ns).getText();
                    String cv_region = itemNode.getChildElement('Region', ns).getText();
                    String cv_address = itemNode.getChildElement('Address', ns).getText();
                    String cv_model = itemNode.getChildElement('Model', ns).getText();
                    String cv_model_year = itemNode.getChildElement('ModelYear', ns).getText();
                    String cv_option = itemNode.getChildElement('Option', ns).getText();
                    String cv_user_comment = itemNode.getChildElement('Comment', ns).getText();
                    String cv_memo = itemNode.getChildElement('CVComment', ns).getText();
                    //事故車のみ
                    String cv_grade = itemNode.getChildElement('Grade', ns).getText();
                    String cv_color = itemNode.getChildElement('Color', ns).getText();
                    String cv_transmission = itemNode.getChildElement('Transmission', ns).getText();
                    String cv_steering = itemNode.getChildElement('Steering', ns).getText();
                    String cv_door = itemNode.getChildElement('Door', ns).getText();
                    String cv_displacement = itemNode.getChildElement('Displacement', ns).getText();
                    String cv_fuel_type = itemNode.getChildElement('FuelType', ns).getText();

                    Account acc = new Account();
                    acc.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND IsPersonType = true LIMIT 1].Id;
                    acc.LastName = cv_name;
                    acc.PersonEmail = cv_email;
                    acc.PersonMobilePhone = cv_tel;
                    try{
                        insert acc;
                        //買取受付の作成
                        Case__c cc = new Case__c();
                        cc.Account__c = acc.Id;
                        cc.MailAddress__c = req.mail_email;
                        cc.MailSubject__c = req.mail_subject;
                        //メール本文
                        String common_columns_start = req.mail_body + '\n\n\n' +
                                                '------以下、外部APIを通じてデータを取得し追記------\n' +
                                                '\n申込日時　：' + cv_contact_date +
                                                '\n申込ユーザ：' + cv_name +
                                                '\nフリガナ　：' + cv_name_kana +
                                                '\n郵便番号　：' + cv_postal_code +
                                                '\n都道府県　：' + cv_region +
                                                '\n住所　　　：' + cv_address +
                                                '\n電話番号　：' + cv_tel +
                                                '\nメール　　：' + cv_email +
                                                '\n状態　　　：' + cv_is_broken +
                                                '\n種類　　　：' + cv_car_type +
                                                '\n車種　　　：' + cv_model +
                                                '\n年式　　　：' + cv_model_year;
                        String common_columns_end =
                                                '\n走行距離　：' + cv_mileage +
                                                '\nオプション：' + cv_option +
                                                '\nコメント　：' + cv_user_comment +
                                                '\nメモ　　　：' + cv_memo;
                        if(cv_is_broken == '普通車'){
                            cc.MailBody__c = common_columns_start + common_columns_end;
                        }else{
                            cc.MailBody__c = common_columns_start +
                                                '\nグレード　：' + cv_grade +
                                                '\nカラー　　：' + cv_color +
                                                '\nミッション：' + cv_transmission +
                                                '\nハンドル　：' + cv_steering +
                                                '\nドア数　　：' + cv_door +
                                                '\n排気量　　：' + cv_displacement +
                                                '\n燃料種　　：' + cv_fuel_type +
                                            common_columns_end;
                        }
                        cc.MailOrigin__c = req.mail_media;
                        cc.Media__c = req.mail_media;
                        cc.OwnerId = req.owner_id;
                        //走行距離をString->Integerにパース
                        try{
                            String mileage_left = cv_mileage.split('～')[0].trim();
                            String numericStr = mileage_left.replaceAll(',', '');
                            cc.Mileage_hs__c = Integer.valueOf(numericStr);
                        }catch(Exception e){
                            System.debug('Exception: ' + e.getMessage());
                        }
                        try{
                            insert cc;
                            c.CustomCase__c = cc.Id;
                            c.Media__c = req.mail_media;
                            update c;
                        }catch(DmlException e){
                            System.debug('DML Exception: ' + e.getMessage());
                        }
                    }catch(DmlException e){
                        System.debug('DML Exception: ' + e.getMessage());
                    }
                }else{
                    System.debug('Callout failed with status: ' + httpResponse.getStatus());
                }
            }catch(Exception e){
                System.debug('Error: ' + e.getMessage());
            }
        }
    }
}