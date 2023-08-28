public class QueueableClass implements Queueable {
  public void execute(QueueableContext context) {
    Integer delayInMinutes = 5;
    ID jobID = System.enqueueJob(new QueueableClass(), delayInMinutes);

    AsyncApexJob jobInfo = [
      SELECT Status, NumberOfErrors
      FROM AsyncApexJob
      WHERE Id = :jobID
    ];
    system.debug('-----Async Queueable Job : ' + jobInfo);
  }
}

/*

ID jobID = System.enqueueJob(new QueueableClass());

Integer delayInMinutes = 5;
ID jobID = System.enqueueJob(new QueueableClass(), delayInMinutes);


AsyncApexJob jobInfo
    = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
system.debug('-----Async Queueable Job : '+jobInfo);

Integer delayInMinutes = 5;
ID jobID = System.enqueueJob(new QueueableClass(), delayInMinutes);

*/

