public without sharing class AssessmentGetBatchScheduleCon implements AssessmentGetBatchSchedule.IScheduler{
    private final Integer BATCH_SIZE = Integer.valueOf(System.Label.YardAssessmentSendBatchSize);
    
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new AssessmentGetBatch(), BATCH_SIZE);
    }
}