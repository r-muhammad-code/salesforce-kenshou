/*
 * 開発者コンソールからスケジュールを登録する場合は、以下のApexコードを使用する
 * String str = System.schedule('AssessmentGetバッチ','15 30 4 * * ?', new AssessmentGetBatchSchedule());
 * 15 30 4 は4時30分15秒を表す。
 */
public class AssessmentGetBatchSchedule implements Schedulable{

    private final String CONNECT_CLASS = AssetConstants.AUCTION_SEND_SCHEDULE_CLASS;

    /**
     * コンストラクタ
     */
    public AssessmentGetBatchSchedule() {
    }

    /**
     * インターフェース
     */
     public Interface IScheduler {
         void execute(SchedulableContext sc);
     }

     public void execute(SchedulableContext sc){
         Type targetType = Type.forName(CONNECT_CLASS);

         if(targetType != null){
            IScheduler schedule = (IScheduler)targetType.newInstance();
            schedule.execute(sc);
         }
     }

}