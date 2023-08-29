public class SimpleScheduleJob implements Schedulable {
  public void execute(SchedulableContext ctx) {
    System.debug('-----schedule------' + ctx.getTriggerId());
  }
}

/*

String sch = '20 30 8 10 2 ?';
String jobID = System.schedule('Simple Schedule Job', sch, new SimpleScheduleJob());

*/

