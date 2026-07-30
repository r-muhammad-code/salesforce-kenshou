/*
 * 車種Dao
 */
public with sharing class ModelDao {

    // コンストラクタ
    public ModelDao() {
    }

    public List<Mst_Models__c> getSelectModel(List<String> makerList){
        return [
            SELECT
                Id
                ,Name
                ,inum__c
                ,disp_flg__c
                ,maker__c
                ,maker__r.Name 
                ,maker__r.inum__c
            FROM
                Mst_Models__c
            WHERE maker__r.inum__c IN :makerList
            AND disp_flg__c='1'
            ORDER BY
                row_num__c
            Limit 50000
        ];
    }

}