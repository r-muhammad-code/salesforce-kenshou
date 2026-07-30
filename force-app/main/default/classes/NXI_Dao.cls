public class NXI_Dao {
    //**ユーザ**
    public static List<User> getUsers() {
        String soql = '';
        soql += 'SELECT ';
        soql += NXI_Dao.createSelect('User');
        soql += 'FROM User ';
        return Database.query(soql);
    }
    //**買取受付**
    public static List<Case__c> getCustomCase(List<Id> recordId) {
        String soql = '';
        soql += 'SELECT ';
        soql += NXI_Dao.createSelect('Case__c');
        soql += ', CallAOpportunity__r.Phase__c ';
        soql += ', Oppotunity__r.Phase__c ';
        soql += ', Oppotunity__r.Grade__c ';
        soql += ', CallAOpportunity__r.LocationAddress_hs__c ';
        soql += ', Account__r.LastName ';
        soql += ', Account__r.IsPerson__c ';
        soql += ', Account__r.Name ';
        soql += ', Account__r.Name_kana__c ';
        soql += ', Account__r.Fax ';
        soql += ', Account__r.CorporationName__c ';
        soql += ', Account__r.FirstName ';
        soql += ', Account__r.PersonEmail ';
        soql += ', Account__r.PersonMobilePhone ';
        soql += ', Account__r.PersonOtherCity ';
        soql += ', Account__r.PersonMailingCity ';
        //数式soql += ', Account__r.PersonMailingAddress ';
        soql += ', Account__r.PersonOtherStreet ';
        soql += ', Account__r.PersonMailingStreet ';
        soql += ', Account__r.PersonOtherState ';
        soql += ', Account__r.PersonMailingState ';
        soql += ', Account__r.PersonOtherPostalCode ';
        soql += ', Account__r.PersonMailingPostalCode ';
        soql += ', Oppotunity__r.CreatedDate ';
        soql += ', Oppotunity__r.CompletionDate__c ';
        soql += ', Oppotunity__r.CancelDate__c ';
        soql += ', Oppotunity__r.CancelReason__c ';
        soql += ', Grades__r.Name ';
        
        soql += 'FROM Case__c ';
        soql += 'WHERE Id IN :recordId ';
        return Database.query(soql);
    }
    //**連携テーブル**
    public static List<WorkExchange__c> getWorkExchange(List<Id> recordId) {
        String soql = '';
        soql += 'SELECT ';
        soql += NXI_Dao.createSelect('WorkExchange__c');
        soql += 'FROM WorkExchange__c ';
        soql += 'WHERE Id IN :recordId ';
        return Database.query(soql);
    }
    /*
     //**買取商談**
    public static List<PurchaseOpportunity__c> getPurchaseOpportunity(List<Id> recordId) {
        String soql = '';
        soql += 'SELECT ';
        soql += NXI_Dao.createSelect('PurchaseOpportunity__c');
        soql += 'FROM PurchaseOpportunity__c ';
        soql += 'WHERE Id IN :recordId ';
        return Database.query(soql);
    }
    //**CallA**
    public static List<CallCenterA_Opportunity__c> getCallCenterA_Opportunity(List<Id> recordId) {
        String soql = '';
        soql += 'SELECT ';
        soql += NXI_Dao.createSelect('CallCenterA_Opportunity__c');
        soql += 'FROM CallCenterA_Opportunity__c ';
        soql += 'WHERE Id IN :recordId ';
        return Database.query(soql);
    }
     //**Account**
    public static List<Account> getAccount(List<Id> recordId) {
        String soql = '';
        soql += 'SELECT ';
        soql += NXI_Dao.createSelect('Account');
        soql += 'FROM Account ';
        soql += 'WHERE Id IN :recordId ';
        return Database.query(soql);
    }
    //**User**
    public static List<User> getUser(List<String> UserCode) {
        String soql = '';
        soql += 'SELECT ';
        soql += NXI_Dao.createSelect('User');
        soql += 'FROM User ';
        soql += 'WHERE UserCode__c  IN :UserCode ';
        return Database.query(soql);
    }*/
    
    //**買取商談（ワーク）**
    public static List<PurchaseOpportunityWork__c> getPurchaseOpportunityWorks(List<PurchaseOpportunityWork__c> pOpportunityWorks) {
        String soql = '';
        soql += 'SELECT ';
        soql += NXI_Dao.createSelect('PurchaseOpportunityWork__c');
        soql += 'FROM PurchaseOpportunityWork__c ';
        soql += 'WHERE Id IN :pOpportunityWorks ';
        return Database.query(soql);
    }
    
    //**買取実績（ワーク）**
    public static List<PurchaseExperienceWork__c> getPurchaseExperienceWorks(List<PurchaseExperienceWork__c> pExperienceWorks) {
        String soql = '';
        soql += 'SELECT ';
        soql += NXI_Dao.createSelect('PurchaseExperienceWork__c');
        soql += 'FROM PurchaseExperienceWork__c ';
        soql += 'WHERE Id IN :pExperienceWorks ';
        return Database.query(soql);
    }

    //買取商談の直近査定日を取引先ごとに取得
    public static String getLastAssessmentDateByAccount() {
        String soql = '';
        soql += 'SELECT ';
        soql += 'Account__c ';
        soql += ', MAX(AssessmentDate__c) LastAssessmentDate ';
        soql += ', MAX(PurchaseDate__c) LastPurchaseDate ';
        soql += 'FROM PurchaseOpportunity__c ';
        soql += 'WHERE AggregationDate__c = LAST_N_DAYS:80 ';
        soql += 'GROUP BY Account__c ';
        soql += 'LIMIT 50000 ';
        
        return soql;
    }
    
    //**ヘルパー**
    //オブジェクトの全項目を取得するSELECT句を作成
    public static String createSelect(String objectName) {
        Schema.SObjectType sType = (Schema.SObjectType)Schema.getGlobalDescribe().get(objectName);
        Schema.DescribeSObjectResult sObjectResult = sType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = sObjectResult.fields.getMap();
        
        String selectFields = '';
        for (Schema.SObjectField field : fieldMap.values()) {
            if (selectFields.length() > 0) {
                selectFields = selectFields + ', ';
            }
            Schema.DescribeFieldResult fieldResult = field.getDescribe();
            selectFields = selectFields + fieldResult.getName();
        }
        return selectFields + ' ';
    }
    /*
     //オブジェクトの書き込み可能な項目を取得するSELECT句を作成
    public static String createSelectWritable(String objectName) {
        Schema.SObjectType sType = (Schema.SObjectType)Schema.getGlobalDescribe().get(objectName);
        Schema.DescribeSObjectResult sObjectResult = sType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = sObjectResult.fields.getMap();
        
        String selectFields = '';
        for (Schema.SObjectField field : fieldMap.values()) {           

            if (selectFields.length() > 0) {
                selectFields = selectFields + ', ';
            }
            Schema.DescribeFieldResult fieldResult = field.getDescribe();
            if(!fieldResult.isCreateable()){
                continue;
            }
            selectFields = selectFields + fieldResult.getName();
        }
        return selectFields + ' ';
    }*/
}