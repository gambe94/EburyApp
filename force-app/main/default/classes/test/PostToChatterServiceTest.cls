@IsTest
public with sharing class PostToChatterServiceTest {
  @IsTest
  private static void testPostToChatterGroup() {
    Id groupId = TestFactory.createFakeChatterGroup();
    Integer recordNumber = 50;
    List<Trade__c> trades = TestFactory.createTrades(recordNumber);

    Test.startTest();
    insert trades;
    Test.stopTest();
    List<FeedItem> items = [SELECT id FROM FeedItem];
    System.assertEquals(
      recordNumber,
      items.size(),
      'FeedItem not created for every trade'
    );
  }
}
