@isTest
public class FututreClassTest {
  @isTest
  static void should_test_methodNoFuture_success() {
    // Given
    List<Opportunity> oppList = new List<Opportunity>();
    for (integer i = 0; i < 200; i++) {
      Opportunity oppItem = new Opportunity(
        Name = 'methodNoFutureOpportunity' + i,
        StageName = 'Perception Analysis',
        CloseDate = Date.Today(),
        DeleteFlag__c = true
      );
      oppList.add(oppItem);
    }
    insert oppList;
    Map<Id, Opportunity> oppsMap = new Map<Id, Opportunity>(oppList);

    // When
    FutureClass.methodNoFuture(oppsMap.keySet());

    // Then
    List<Opportunity> oppUpdateList = [
      SELECT Id, StageName
      FROM Opportunity
      WHERE DeleteFlag__c = TRUE
    ];
    System.assertEquals(200, oppUpdateList.size());
    if (oppUpdateList != null && oppUpdateList.size() > 0) {
      for (Opportunity oppUpdate : oppUpdateList) {
        System.assertEquals('Closed Won', oppUpdate.StageName);
      }
    }
  }

  @isTest
  static void should_test_methodFuture_success() {
    // Given
    List<Opportunity> oppList = new List<Opportunity>();
    for (integer i = 0; i < 200; i++) {
      Opportunity oppItem = new Opportunity(
        Name = 'methodFutureOpportunity' + i,
        StageName = 'Perception Analysis',
        CloseDate = Date.Today(),
        DeleteFlag__c = true
      );
      oppList.add(oppItem);
    }
    insert oppList;
    Map<Id, Opportunity> oppsMap = new Map<Id, Opportunity>(oppList);

    // When
    Test.startTest();
    FutureClass.methodFuture(oppsMap.keySet());
    Test.stopTest();

    List<Opportunity> oppUpdateList = [
      SELECT Id, StageName
      FROM Opportunity
      WHERE DeleteFlag__c = TRUE
    ];
    System.assertEquals(200, oppUpdateList.size());
    if (oppUpdateList != null && oppUpdateList.size() > 0) {
      for (Opportunity oppUpdate : oppUpdateList) {
        System.assertEquals('Closed Won', oppUpdate.StageName);
      }
    }
  }

  @isTest
  static void should_test_insertUserWithRole_success() {
    Test.startTest();
    FutureClass.insertUserWithRole(
      'username11@test.com',
      'Yingjia',
      'email@test.com',
      'Zhang'
    );
    Test.stopTest();

    User[] users = [SELECT Id FROM User WHERE username = 'username11@test.com'];
    System.assertEquals(1, users.size());
  }
}
