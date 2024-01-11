public class BatchableRaisesPlatformEventsClass implements Database.Batchable<SObject>, Database.Stateful, Database.RaisesPlatformEvents {
  public Integer batchProcessed = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    System.debug('start : ' + batchProcessed);
    return Database.getQueryLocator(
      'SELECT Id FROM Account Where BillingCountry != \'USA\''
    );
  }

  public void execute(Database.BatchableContext bc, List<Account> records) {
    System.debug('execute begin : ' + batchProcessed);
    batchProcessed++;
    if (batchProcessed == 3) {
      throw new CommonException('This is a test exception');
    }
    for (Account acc : records) {
      acc.BillingCountry = 'USA';
    }
    update records;
    System.debug('execute end : ' + batchProcessed);
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('finish : ' + batchProcessed + ' batch processed.');
    System.debug('Batch finished');
  }
}
