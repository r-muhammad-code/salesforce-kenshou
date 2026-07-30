@IsTest 
public with sharing class CommonTest {
    // カバレッジ確保のためのテスト
    @IsTest 
    public static void CommonTest1() {
        List<String> strList = new List<String>();
        strList.add('test1');
        strList.add('test2');
        strList.add('test3');
        CommonUtility.logDivString(strList);

        ErrResultException e = new ErrResultException();
    }
}