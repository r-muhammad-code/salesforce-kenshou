public with sharing class AssessPictureController {

    @AuraEnabled
    public static Map<String, String> LoadRecord(String imageColumnList, String objectName, String recordId) {

        String sql = 'SELECT '+imageColumnList+' FROM '+objectName+' WHERE id = :recordId';

        sObject assess = Database.query(sql);
        Map<String, String> result = new Map<String, String>();

        for(String col: imageColumnList.split(',')){
            result.put(col,(String)assess.get(col));
        }
        return result;
    }
}