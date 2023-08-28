public with sharing class SecondQueueableJob implements Queueable {
  private Account acc;

  public SecondQueueableJob(Account acc) {
    this.acc = acc;
  }

  public void execute(QueueableContext context) {
    Opportunity oppItem = new Opportunity(
      Name = 'Default Opporutnity',
      CloseDate = Date.Today(),
      AccountId = this.acc.Id,
      StageName = 'Perception Analysis'
    );
    insert oppItem;
    System.debug('----------oppItem--' + oppItem);
  }
}
