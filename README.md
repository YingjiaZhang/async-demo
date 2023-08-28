# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)

## Async Jobs

### Future Method

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

### Queueable

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

### Batch

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

```
