/*
 * メーカーDao
 */
public without sharing class MakerDao {

    // コンストラクタ
    public MakerDao() {
    }

    public List<Mst_Makers__c> getAllMaker(){
        return [
            SELECT
                Id
                ,Name
                ,inum__c
            FROM
                Mst_Makers__c
            WHERE
                Name <> '--'
            AND
                disp_flg__c='1'
            ORDER BY
                row_num__c
        ];
    }
}