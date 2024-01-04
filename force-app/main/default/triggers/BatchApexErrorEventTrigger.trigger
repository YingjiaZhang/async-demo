trigger BatchApexErrorEventTrigger on BatchApexErrorEvent(after insert) {
  System.debug('--------------- Catch batch error event');
  Set<Id> asyncApexJobIds = new Set<Id>();
  for (BatchApexErrorEvent evt : Trigger.new) {
    asyncApexJobIds.add(evt.AsyncApexJobId);
  }
  Map<Id, AsyncApexJob> jobs = new Map<Id, AsyncApexJob>(
    [SELECT id, ApexClass.Name FROM AsyncApexJob WHERE Id IN :asyncApexJobIds]
  );

  for (BatchApexErrorEvent evt : Trigger.new) {
    String classMethod = jobs.get(evt.AsyncApexJobId).ApexClass != null
      ? jobs.get(evt.AsyncApexJobId).ApexClass.Name
      : '';
    String message =
      'Class Name: ' +
      classMethod +
      ' Exception Type: ' +
      evt.ExceptionType +
      '; Message: ' +
      evt.Message +
      '; Record Ids: ' +
      evt.JobScope +
      '; StackTrace: ' +
      evt.StackTrace;
    System.debug(message);
  }
}
