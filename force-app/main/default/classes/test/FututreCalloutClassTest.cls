@IsTest
private class FututreCalloutClassTest {
  @IsTest
  private static void should_test_sendSMSAsyncMethod_success() {
    // Given
    Test.setMock(HttpCalloutMock.class, new SMSCalloutMock());

    // When
    Test.startTest();
    SMSUtils.sendSMSAsync('111', '222', 'Greetings!');
    Test.stopTest();

    // Then
    List<SMS_Log__c> logs = [SELECT msg__c FROM SMS_Log__c];
    System.assertEquals(1, logs.size());
    System.assertEquals('success', logs[0].msg__c);
  }
}
