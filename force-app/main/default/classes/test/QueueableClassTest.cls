@isTest
public class QueueableClassTest {
  @isTest
  static void should_test_queueable_class_success() {
    // When
    Test.startTest();
    System.enqueueJob(new QueueableClass());
    Test.stopTest();

    // Then
    Account acct = [
      SELECT Name, Phone
      FROM Account
      WHERE Name = 'Acme'
      LIMIT 1
    ];
    System.assertNotEquals(null, acct);
    System.assertEquals('(415) 555-1212', acct.Phone);
  }
}
