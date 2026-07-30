public with sharing class UserDao {
    public UserDao() {

    }

    /*
    * ユーザのプロファイルIDを取得する
    */
    @AuraEnabled
    public static String getUserProfileID(Id userId){
        List<User> u = [SELECT ProfileId FROM User WHERE Id = :userId ];
        return u[0].ProfileId;
    }
}