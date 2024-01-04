# Salesforce Async Jobs

## Reference

- Quick Start: Salesforce DX : https://trailhead.salesforce.com/content/learn/projects/quick-start-salesforce-dx?trailmix_creator_id=shoreline&trailmix_slug=preparing-for-sfdx-vs-code-and-cli
- Trailhead Async Module : https://trailhead.salesforce.com/content/learn/modules/asynchronous_apex
- Asynchronous Apex : https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_async_overview.htm
- Asynchronous Apex: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_async_overview.htm
- CronExpression : https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_scheduler.htm
- Invoking Callouts Using Apex:https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_callouts.htm
- Firing Platform Events from Batch Apex : https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_batch_platformevents.htm

## Future Method

FutureClass.methodFuture

```
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

FutureClass.methodFuture(oppsMap.keySet());
```

FutureMixedDMLClass.mixedDMLMethod

```
FutureMixedDMLClass.mixedDMLMethod()
```

## Queueable

```
ID jobID = System.enqueueJob(new QueueableClass());

AsyncApexJob jobInfo
    = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
system.debug('-----Async Queueable Job : '+jobInfo);
```

```
Integer delayInMinutes = 5;
ID jobID = System.enqueueJob(new QueueableClass(), delayInMinutes);

AsyncApexJob jobInfo
    = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
system.debug('-----Async Queueable Job : '+jobInfo);
```

```
ID jobID = System.enqueueJob(new FirstQueuableJob());
```

## Batchable

```
BatchableClass batchInstance = new BatchableClass ();

// calling with a batch size 50
Database.executeBatch(batchInstance, 50);

// calling with a batch size 2000
Database.executeBatch(batchInstance, 2000);

// calling with default batch size 200
Database.executeBatch(batchInstance) ;
```

```
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

Database.executeBatch(new BatchableClass(), 10);

Database.executeBatch(new BatchableStatefulClass(), 10);

Database.executeBatch(new BatchableRaisesPlatformEventsClass(), 10);

```

## Scheduleable

```
 String jobId = SchdeuleJobInterval1Min.scheduleJob();

 select Id,CreatedDate,Status,  MethodName,ParentJobId, ApexClass.Name from AsyncApexJob  where ApexClass.Name = 'SchdeuleJobInterval1Min' order by CreatedDate desc  limit 100

```
