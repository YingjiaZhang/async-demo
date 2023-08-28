@isTest
private class BatchableClassTest {
  @testSetup
  static void setup() {
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
  }
  @isTest
  static void should_test_account_batchable_updates_success() {
    System.assertEquals(
      0,
      [SELECT COUNT() FROM Account WHERE billingcountry = 'USA']
    );

    Test.startTest();
    BatchableClass accBatch = new BatchableClass();
    Id batchId = Database.executeBatch(accBatch);
    Test.stopTest();

    System.assertEquals(
      100,
      [SELECT COUNT() FROM Account WHERE billingcountry = 'USA']
    );
  }
}
