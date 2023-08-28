public class FutureClass {
  public static void methodNoFuture(Set<Id> idsSet) {
    String sql = 'SELECT Id,Name FROM Opportunity where Id in :idsSet';
    List<Opportunity> opps = Database.query(sql);
    List<Opportunity> newOppList = new List<Opportunity>();
    for (Opportunity opp : opps) {
      opp.stageName = 'Closed Won';
      newOppList.add(opp);
    }
    update newOppList;
    System.debug('---- methodNoFuture : ' + System.isFuture());
  }

  @future
  public static void methodFuture(Set<Id> idsSet) {
    if (idsSet.isEmpty()) {
      throw new CommonException('The opportunity ids are empty');
    }
    String sql = 'SELECT Id,Name FROM Opportunity where Id in :idsSet';
    List<Opportunity> opps = Database.query(sql);
    List<Opportunity> newOppList = new List<Opportunity>();
    for (Opportunity opp : opps) {
      opp.stageName = 'Closed Won';
      newOppList.add(opp);
    }
    update newOppList;
    System.debug('---- methodFuture : ' + System.isFuture());
  }

  @future
  public static void insertUserWithRole(
    String uname,
    String al,
    String em,
    String lname
  ) {
    Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
    UserRole r = [SELECT Id FROM UserRole WHERE Name = 'COO'];

    User u = new User(
      alias = al,
      email = em,
      emailencodingkey = 'UTF-8',
      lastname = lname,
      languagelocalekey = 'en_US',
      localesidkey = 'en_US',
      profileid = p.Id,
      userroleid = r.Id,
      timezonesidkey = 'America/Los_Angeles',
      username = uname
    );
    insert u;
  }
}
