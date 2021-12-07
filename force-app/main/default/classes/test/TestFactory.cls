@IsTest
public with sharing class TestFactory {
  public static final String GROUP_NAME = 'Not exist Chatter Group';
  public static Id createFakeChatterGroup() {
    ChatterGroupSelector.TEST_GROUP_NAME = GROUP_NAME;

    CollaborationGroup myGroup = new CollaborationGroup();
    myGroup.Name = GROUP_NAME;
    myGroup.CollaborationType = 'Public';
    insert myGroup;
    return myGroup.Id;
  }

  public static List<Trade__c> createTrades(Integer recordNumber) {
    List<Trade__c> trades = new List<Trade__c>();
    for (Integer i = 0; i < recordNumber; i++) {
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
    return trades;
  }
}
