public with sharing class RateCalloutService {
  @AuraEnabled
  public static String doCallout(
    Boolean isMock,
    String baseCurrency,
    String targetCurrency
  ) {
    if (isMock) {
      return '{ ' +
        ' "success": true,' +
        ' "timestamp": 1519296206,' +
        ' "base": "EUR",' +
        ' "date": "2021-11-26",' +
        ' "rates": {' +
        '     "AUD": 1.566015,' +
        '     "HUF": 365,' +
        '     "CAD": 1.560132,' +
        '     "CHF": 1.154727,' +
        '     "CNY": 7.827874,' +
        '     "GBP": 0.882047,' +
        '     "JPY": 132.360679,' +
        '     "USD": 1.23396,' +
        '}' +
        '}';
    }

    String fullURLTemplate = '/latest?access_key={0}&base={1}&symbols={2}';

    String fullPath = String.format(
      fullURLTemplate,
      new List<String>{
        Integration_Configs__c.getInstance().Fixer_Api_Key__c,
        baseCurrency,
        targetCurrency
      }
    );
    HttpRequest req = new HttpRequest();
    req.setEndpoint('callout:Fixer_Api' + fullPath);
    req.setMethod('GET');

    System.debug(req.getEndpoint());

    Http http = new Http();
    HTTPResponse res = http.send(req);
    System.debug(res.getBody());

    return res.getBody();
  }
}
