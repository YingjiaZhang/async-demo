public class BatchableRaisesPlatformEventsClass implements Database.Batchable<SObject>, Database.Stateful, Database.RaisesPlatformEvents {
  public Integer batchProcessed = 0;

  public Database.QueryLocator start(Database.BatchableContext BC) {
    System.debug('start : ' + batchProcessed);
    return Database.getQueryLocator(
      'SELECT Id FROM Account Where BillingCountry != \'USA\''
    );
  }

  public void execute(Database.BatchableContext BC, List<Account> scope) {
    System.debug('execute begin : ' + batchProcessed);
    batchProcessed++;
    if (batchProcessed == 3) {
      throw new MyException('This is a test exception');
    }
    for (Account acc : scope) {
      acc.BillingCountry = 'USA';
    }
    update scope;
    System.debug('execute end : ' + batchProcessed);
  }

  public void finish(Database.BatchableContext BC) {
    System.debug('finish : ' + batchProcessed + ' batch processed.');
    System.debug('Batch finished');
  }

  public class MyException extends Exception {
  }
}
