public class BatchableStatefulClass implements Database.Batchable<SObject>, Database.Stateful {
  public Integer recordsProcessed = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    System.debug('start begin: ' + recordsProcessed);
    recordsProcessed = recordsProcessed + 1;
    System.debug('start end: ' + recordsProcessed);
    return Database.getQueryLocator(
      'SELECT Id FROM Account Where BillingCountry != \'USA\''
    );
  }

  public void execute(Database.BatchableContext bc, List<Account> records) {
    System.debug('execute begin : ' + recordsProcessed);
    for (Account acc : records) {
      acc.BillingCountry = 'USA';
      recordsProcessed = recordsProcessed + 1;
    }
    update records;
    System.debug('execute end : ' + recordsProcessed);
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('finish : ' + recordsProcessed + ' records processed.');
    System.debug('Batch finished');
  }
}
