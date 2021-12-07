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
      ORDER BY CreatedDate DESC
      LIMIT 100
    ];
  }

  /**
   * @description
   * Do a Callout to Flexi api to Fetch the actual currency rate
   * @param baseCurrency
   * @param targetCurrency
   * @return
   * @example
   */
  @AuraEnabled
  public static RateCalloutWrapper.Rate getRate(
    String baseCurrency,
    String targetCurrency
  ) {
    RateCalloutService calloutService = new RateCalloutService(
      baseCurrency,
      targetCurrency
    );
    RateCalloutWrapper.Rate fetchedRate = calloutService.doCallout();
    return fetchedRate;
  }
}
