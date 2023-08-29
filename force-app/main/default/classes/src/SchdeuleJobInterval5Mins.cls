global class SchdeuleJobInterval5Mins implements Schedulable {
  private static String JOB_NAME = 'Schdeule Job Interval 5 Mins';
  private static Integer RUN_INTERVAL = 360;

  public static void scheduleJob() {
    datetime scheduleTime = DateTime.newInstance(System.currentTimeMillis())
      .addMinutes(1);
    string schedule = '0 ' + scheduleTime.minute() + ' * * * ? *';
    system.schedule(JOB_NAME, schedule, new SchdeuleJobInterval5Mins());
  }

  global void execute(SchedulableContext sc) {
    System.abortJob(sc.getTriggerId());
    try {
      System.debug('--------------' + sc.getTriggerId());
    } catch (Exception ex) {
      System.debug(ex.getMessage());
    } finally {
      reschedule();
    }
  }

  public static void reschedule() {
    datetime currentTime = DateTime.newInstance(System.currentTimeMillis());
    datetime nextTime = currentTime.addSeconds(RUN_INTERVAL);
    string schedule =
      nextTime.second() +
      ' ' +
      nextTime.minute() +
      ' * * * ? *';
    system.schedule(JOB_NAME, schedule, new SchdeuleJobInterval5Mins());
  }
}
