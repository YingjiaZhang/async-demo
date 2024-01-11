public class BatchableStatefulInvokeServiceClass implements Database.Batchable<SObject>, Database.Stateful {
  private BatchableStatefulService service = new BatchableStatefulService();

  public Database.QueryLocator start(Database.BatchableContext BC) {
    return Database.getQueryLocator(service.getQuery());
  }

  public void execute(Database.BatchableContext BC, List<Account> records) {
    service.process(records);
  }

  public void finish(Database.BatchableContext BC) {
    service.sendEmail();
  }
}
