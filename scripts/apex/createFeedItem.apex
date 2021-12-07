// FeedItem post = new FeedItem();
// post.Body = 'A new trade has been created with the following data:\nSell Currency: EUR\nSell Amount: 784\nBuy Currency: GBP\nBuy Amount:666.482\nRate: 0.85\nBooked Date: 12/7/2021, 9:23 AM\nhttps://nosoftware-drive-6670-dev-ed.lightning.force.com/a011x000006x2ViAAI\n\nAPI KEY: $Setup.Integration_Configs__c.Fixer_Api_Key__c';
// post.ParentId = '0F91x0000004gYNCAY';
// post.Title = 'Trade created';
// post.Status = 'Published';

// insert post;
Trade__c myTrade = new Trade__c(
  Buy_Amount__c = 200,
  Buy_Currency__c = 'HUF',
  Sell_Amount__c = 300,
  Sell_Currency__c = 'EUR',
  Rate__c = 1.145
);

PostToChatterService.postToChatterGroup(
  '0F91x0000004gYNCAY',
  new List<Trade__c>{ myTrade }
);
