public class NXI_AggregatePOBatchScheduler implements Schedulable{

    public void execute(SchedulableContext sc) {
        NXI_AggregatePOBatch batch = new NXI_AggregatePOBatch();
        Database.executeBatch(batch, 200);
    }   

}