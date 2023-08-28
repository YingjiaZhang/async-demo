public with sharing class FirstQueuableJob implements Queueable {
  public void execute(QueueableContext context) {
    Account accItem = new Account(Name = 'Acme', Phone = '(415) 555-1212');
    insert accItem;
    System.debug('----------accItem--' + accItem);

    if (!System.Test.isRunningTest()) {
      System.enqueueJob(new SecondQueueableJob(accItem));
    }
  }
}

/*
Account -- Opportunity 

ID jobID = System.enqueueJob(new FirstQueuableJob());
*/

