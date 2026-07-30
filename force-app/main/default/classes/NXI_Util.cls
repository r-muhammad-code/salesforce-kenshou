public class NXI_Util {
    //カスタム項目のAPI名セットを取得
    public static Set<String> getCustomFieldAPINameSet(Schema.SObjectType sobjType){
        Map<String, Schema.SObjectField> fieldMap = sobjType.getDescribe().Fields.getMap();
        Set<String> fieldAPINameSet = new Set<String>();

        for(Schema.SObjectField field : fieldMap.values()){
            Schema.DescribeFieldResult fieldResult = field.getDescribe();
            //標準項目、数式項目は除外
            if(!fieldResult.isCustom() || fieldResult.isCalculated()){
                continue;
            }
            fieldAPINameSet.add(fieldResult.getName());
        }
        
      return fieldAPINameSet;
    }
}