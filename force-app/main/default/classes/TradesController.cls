public with sharing class TradesController {
  @AuraEnabled(cacheable=true)
  public static List<Trade__c> getAllTrade() {
    return [
      SELECT
        Id,
        Name,
        Buy_Amount__c,
        Buy_Currency__c,
        Sell_Amount__c,
        Sell_Currency__c,
        Rate__c,
        CreatedDate
      FROM Trade__c
      WITH SECURITY_ENFORCED
      LIMIT 10
    ];
  }

  public static void getRate(
    String baseCurrency,
    List<String> targetCurrencies
  ) {
  }
}
