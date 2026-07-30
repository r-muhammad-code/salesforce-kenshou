/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_OpportunityActivityTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_OpportunityActivityTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new OpportunityActivity__c());
    }
}