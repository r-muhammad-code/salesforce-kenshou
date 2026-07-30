/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_recruitment_masterTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_recruitment_masterTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new recruitment_master__c());
    }
}