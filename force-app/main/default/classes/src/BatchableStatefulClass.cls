public class BatchableStatefulClass implements Database.Batchable<SObject>, Database.Stateful {
  public Integer recordsProcessed = 0;

  public Database.QueryLocator start(Database.BatchableContext BC) {
    System.debug('start begin: ' + recordsProcessed);
    recordsProcessed = recordsProcessed + 1;
    System.debug('start end: ' + recordsProcessed);
    return Database.getQueryLocator(
      'SELECT Id FROM Account Where BillingCountry != \'USA\''
    );
  }

  public void execute(Database.BatchableContext BC, List<Account> scope) {
    System.debug('execute begin : ' + recordsProcessed);
    for (Account acc : scope) {
      acc.BillingCountry = 'USA';
      recordsProcessed = recordsProcessed + 1;
    }
    update scope;
    System.debug('execute end : ' + recordsProcessed);
  }

  public void finish(Database.BatchableContext BC) {
    System.debug('finish : ' + recordsProcessed + ' records processed.');
    System.debug('Batch finished');
  }
}
