@isTest
public class FutureMixedDMLClassTest {
  @isTest
  static void should_test_mixedDMLMethod_sccuess() {
    // Given Admin
    User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];

    // When
    System.runAs(thisUser) {
      Test.startTest();
      FutureMixedDMLClass.mixedDMLMethod();
      Test.stopTest();
    }

    // Then
    Account[] accts = [SELECT Id FROM Account WHERE Name = 'Acme'];
    System.assertEquals(1, accts.size());

    User[] users = [SELECT Id FROM User WHERE username = 'username22@test.com'];
    System.assertEquals(1, users.size());
  }
}
