public class BatchableClass implements Database.Batchable<SObject> {
  public Database.QueryLocator start(Database.BatchableContext BC) {
    return Database.getQueryLocator(
      'SELECT Id FROM Account Where BillingCountry != \'USA\''
    );
  }

  public void execute(Database.BatchableContext BC, List<Account> scope) {
    for (Account acc : scope) {
      acc.BillingCountry = 'USA';
    }
    update scope;
  }

  public void finish(Database.BatchableContext BC) {
    System.debug('Batch finished');
  }
}
