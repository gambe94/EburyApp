public with sharing class PostToChatterService {
  public static void postToChatterGroup(Id groupId, List<Trade__c> trades) {
    List<FeedItem> feedItems = new List<FeedItem>();
    for (Trade__c trade : trades) {
      feedItems.add(
        new FeedItem(
          ParentId = groupId,
          Title = trade.Name + 'trade created',
          Status = 'Published',
          Body = getBodyFromTemplate(trade)
        )
      );
    }
    insert feedItems;
  }

  private static String getBodyFromTemplate(Trade__c trade) {
    return 'A new trade has been created with the following data:' +
      '\nSell Currency: ' +
      trade.Sell_Currency__c +
      '\nSell Amount: ' +
      trade.Sell_Amount__c +
      '\nBuy Currency: ' +
      trade.Buy_Currency__c +
      '\nBuy Amount: ' +
      trade.Buy_Amount__c +
      '\nRate: ' +
      trade.Rate__c +
      '\nBooked Date: ' +
      trade.CreatedDate +
      '\nLink: ' +
      URL.getSalesforceBaseUrl().toExternalForm() +
      '/' +
      trade.Id;
  }
}
