public class ScheduleBatchJob implements Schedulable {
  public void execute(SchedulableContext ctx) {
    Database.executeBatch(new BatchableStatefulClass(), 10);
  }
}

/*

List<Account> accounts = new List<Account>();
// insert 100 accounts
for (Integer i = 0; i < 100; i++) {
    accounts.add(
    new Account(
        name = 'Account ' + i,
        billingcity = 'New York',
        billingcountry = 'American Samoa'
    )
    );
}
insert accounts;

select Id, name, CreatedDate from Account where BillingCountry != 'usa'

String sch = '0 5 * * * ?';
String jobID = System.schedule('Schedule Batch Job', sch, new ScheduleBatchJob());
System.debug(jobID);


 */

