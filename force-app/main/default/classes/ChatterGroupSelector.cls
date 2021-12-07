public with sharing class ChatterGroupSelector {
  private static String TRADE_REVIEWS_GROUP = 'Trade reviewers';
  @TestVisible
  private static String TEST_GROUP_NAME;

  private static Id tradeReviewersGroup = null;
  public static Id getTradeReviewersGroup() {
    System.debug(TEST_GROUP_NAME);
    if (tradeReviewersGroup == null) {
      String gropuName = Test.isRunningTest()
        ? TEST_GROUP_NAME
        : TRADE_REVIEWS_GROUP;
      tradeReviewersGroup = [
        SELECT id
        FROM CollaborationGroup
        WHERE Name = :gropuName
      ]
      .Id;
    }
    return tradeReviewersGroup;
  }
}
