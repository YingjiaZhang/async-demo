public with sharing class BatchableStatefulService {
  public List<Account> needUpdateAccountList = new List<Account>();

  public String getQuery() {
    return 'SELECT Id FROM Account Where BillingCountry != \'USA\'';
  }

  public void process(List<Account> aList) {
    System.debug('process');
    List<Account> batchAccountList = new List<Account>();
    for (Account a : aList) {
      needUpdateAccountList.add(a);
      batchAccountList.add(a);
    }
    update batchAccountList;
  }

  public void sendEmail() {
    System.debug('sendEmail : total ' + needUpdateAccountList.size());
  }
}
