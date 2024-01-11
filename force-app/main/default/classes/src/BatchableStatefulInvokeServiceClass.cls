public class BatchableStatefulInvokeServiceClass implements Database.Batchable<SObject>, Database.Stateful {
  private BatchableStatefulService service = new BatchableStatefulService();

  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(service.getQuery());
  }

  public void execute(Database.BatchableContext bc, List<Account> records) {
    service.process(records);
  }

  public void finish(Database.BatchableContext bc) {
    service.sendEmail();
  }
}
