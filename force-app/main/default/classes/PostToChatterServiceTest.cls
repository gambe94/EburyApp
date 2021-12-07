@IsTest
public with sharing class PostToChatterServiceTest {
  @TestSetup
  static void testSetup() {
    ChatterGroupSelector.TRADE_REVIEWS_GROUP = 'Not exist group';

    CollaborationGroup myGroup = new CollaborationGroup();
    myGroup.Name = ChatterGroupSelector.TRADE_REVIEWS_GROUP;
    myGroup.CollaborationType = 'Public';
    insert myGroup;

    Id groupId = ChatterGroupSelector.getTradeReviewersGroup();
    System.debug(groupId);
  }

  @IsTest
  private static void testPostToChatterGroup() {
    List<Trade__c> trades = new List<Trade__c>();
    for (Integer i = 0; i < 1; i++) {
      trades.add(
        new Trade__c(
          Buy_Amount__c = 200,
          Buy_Currency__c = 'HUF',
          Sell_Amount__c = 300,
          Sell_Currency__c = 'EUR',
          Rate__c = 1.145
        )
      );
    }
    insert trades;

    Id groupId = ChatterGroupSelector.getTradeReviewersGroup();
    System.debug(groupId);
    Test.startTest();
    PostToChatterService.postToChatterGroup(groupId, trades);
    Test.stopTest();
    List<FeedItem> items = [SELECT id FROM FeedItem];
    // System.assertEquals(
    //   10,
    //   items.size(),
    //   'FeedItem not created for every trade'
    // );
  }
}
