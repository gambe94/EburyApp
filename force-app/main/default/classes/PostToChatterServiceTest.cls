@IsTest
public with sharing class PostToChatterServiceTest {
  @IsTest
  private static void testPostToChatterGroup() {
    String GROUP_NAME = 'GABOR GROUP work';
    ChatterGroupSelector.TEST_GROUP_NAME = GROUP_NAME;

    CollaborationGroup myGroup = new CollaborationGroup();
    myGroup.Name = GROUP_NAME;
    myGroup.CollaborationType = 'Public';
    insert myGroup;

    List<Trade__c> trades = new List<Trade__c>();
    for (Integer i = 0; i < 10; i++) {
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

    Test.startTest();
    insert trades;
    Test.stopTest();
    List<FeedItem> items = [SELECT id FROM FeedItem];
    System.assertEquals(
      10,
      items.size(),
      'FeedItem not created for every trade'
    );
  }
}
