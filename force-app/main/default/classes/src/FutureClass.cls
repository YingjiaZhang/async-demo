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
}
