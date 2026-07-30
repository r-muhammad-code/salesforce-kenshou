@isTest
public with sharing class UserDaoTest {
    testmethod private static void testGetUserProfileID() {
        TestDataFactory factory = new TestDataFactory();
        // 取引先責任者
        Contact con = factory.createContactData();
        // ユーザ
        User comUsr = factory.createCommunityUser(con);
        // テスト開始
        Test.startTest();

        String profileId = UserDao.getUserProfileID(comUsr.Id);

        // テスト終了
        Test.stopTest();

        System.assertEquals(profileId, comUsr.ProfileId);
    }
}