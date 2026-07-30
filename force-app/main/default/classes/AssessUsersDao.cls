public without sharing class AssessUsersDao {

    // コンストラクタ
    public AssessUsersDao() {
    }

    // 査定担当者（統括部門から取得）
    public List<Mst_Assess_Users__c> getAssessTanto(List<String> manageBumonList){
        return [
            SELECT
                Id
                ,Name
                ,emp_kind__c
                ,manage_org__c
                ,login_user__c
            FROM
                Mst_Assess_Users__c
            WHERE toLabel(manage_org__c) IN :manageBumonList
            // SALESSTRATEGY-4557：無効を検索条件に追加
            AND Invalid__c = False
            ORDER BY
                manage_org__c, Name
        ];

    }

    // SALESSTRATEGY-4557：派生対応 有効な査定ユーザの統括部門を取得
    public List<Mst_Assess_Users__c> getAssessManageOrg(){
        List<Mst_Assess_Users__c> resultList = new List<Mst_Assess_Users__c>();
        Set<String> uniqueOrgSet = new Set<String>();

        // 通常のクエリで取得　※クエリ上でGROUP BY するとエラーになる
        List<Mst_Assess_Users__c> allUsers = [
            SELECT
                Id
                ,Name
                ,manage_org__c
            FROM
                Mst_Assess_Users__c
            WHERE Invalid__c = False
            ORDER BY
                manage_org__c
        ];

        // 重複を排除しながらリストを詰め替える
        for (Mst_Assess_Users__c user : allUsers) {
            if (user.manage_org__c != null && !uniqueOrgSet.contains(user.manage_org__c)) {
                uniqueOrgSet.add(user.manage_org__c);
                resultList.add(user);
            }
        }

        return resultList;
    }
}