public class BatchableClass implements Database.Batchable<SObject> {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT Id FROM Account Where BillingCountry != \'USA\''
    );
  }

  public void execute(Database.BatchableContext bc, List<Account> records) {
    for (Account acc : records) {
      acc.BillingCountry = 'USA';
    }
    update records;
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('Batch finished');
  }
}
