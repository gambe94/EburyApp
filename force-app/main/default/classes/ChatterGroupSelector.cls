public with sharing class ChatterGroupSelector {
  private static Id tradeReviewersGroup = null;
  public static Id getTradeReviewersGroup(String groupName) {
    if (tradeReviewersGroup == null) {
      try {
        tradeReviewersGroup = [
          SELECT id
          FROM CollaborationGroup
          WHERE Name = :groupName
        ]
        .Id;
      } catch (QueryException e) {
        throw new Exception('Follwing chattergroup not exist: ' + groupName);
      }
    }
    return tradeReviewersGroup;
  }
}
