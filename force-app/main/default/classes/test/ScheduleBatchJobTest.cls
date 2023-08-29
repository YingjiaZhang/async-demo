@IsTest
private class ScheduleBatchJobTest {
  @testSetup
  static void setup() {
    List<Account> accounts = new List<Account>();
    // insert 10 accounts
    for (Integer i = 0; i < 10; i++) {
      accounts.add(
        new Account(
          name = 'Account ' + i,
          billingcity = 'New York',
          billingcountry = 'American Samoa'
        )
      );
    }
    insert accounts;
  }

  @isTest
  static void should_test_account_schedule_batch_updates_success() {
    String CRON_EXP = '0 5 * * * ?';

    Test.startTest();
    String jobId = System.schedule(
      'Scheduled Batch Apex Test',
      CRON_EXP,
      new ScheduleBatchJob()
    );

    Test.stopTest();

    CronTrigger schedule = [
      SELECT
        Id,
        CronJobDetail.Name,
        CronExpression,
        TimeZoneSidKey,
        PreviousFireTime,
        NextFireTime,
        State
      FROM CronTrigger
      WHERE Id = :jobId
    ];
    System.assertEquals(
      'Scheduled Batch Apex Test',
      schedule.CronJobDetail.Name
    );
    System.assertEquals('0 5 * * * ?', schedule.CronExpression);

    AsyncApexJob scheduleJob = [
      SELECT Id, ApexClass.Name
      FROM AsyncApexJob
      WHERE CronTriggerId = :jobId
    ];
    System.assertEquals('ScheduleBatchJob', scheduleJob.ApexClass.Name);

    Integer batchJobCount = [
      SELECT COUNT()
      FROM AsyncApexJob
      WHERE ApexClass.Name = 'BatchableStatefulClass'
    ];
    System.assertEquals(1, batchJobCount);
  }
}
