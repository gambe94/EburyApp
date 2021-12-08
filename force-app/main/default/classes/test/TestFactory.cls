@IsTest
public with sharing class TestFactory {
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
