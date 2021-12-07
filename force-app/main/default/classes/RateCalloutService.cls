public with sharing class RateCalloutService {
  private String baseCurrency;
  private String targetCurrency;

  public RateCalloutService(String baseCurrency, String targetCurrency) {
    this.baseCurrency = baseCurrency;
    this.targetCurrency = targetCurrency;
  }

  public RateCalloutWrapper.Rate doCallout() {
    String fullURLTemplate = '/latest?access_key={0}&base={1}&symbols={2}';

    String fullPath = String.format(
      fullURLTemplate,
      new List<String>{
        Integration_Configs__c.getInstance().Fixer_Api_Key__c,
        this.baseCurrency,
        this.targetCurrency
      }
    );
    HttpRequest req = new HttpRequest();
    req.setEndpoint('callout:Fixer_Api' + fullPath);
    req.setMethod('GET');

    Http http = new Http();
    HttpResponse response = http.send(req);
    return parse(response.getBody());
    //return parse(RateCalloutMockFactory.getMock(200).respond(null).getBody());
  }

  public RateCalloutWrapper.Rate parse(String responseBody) {
    try {
      RateCalloutWrapper myresponse = (RateCalloutWrapper) JSON.deserialize(
        responseBody,
        RateCalloutWrapper.class
      );

      return handleResponse(myresponse);
    } catch (JSONException e) {
      System.debug(LoggingLevel.ERROR, e.getMessage());
      throw e;
    }
  }

  public RateCalloutWrapper.Rate handleResponse(
    RateCalloutWrapper rateWrapper
  ) {
    try {
      if (rateWrapper.success) {
        return rateWrapper.rates;
      } else {
        throw new RateCalloutWrapper.RateCalloutWrapperException(
          rateWrapper.error
        );
      }
    } catch (NullPointerException e) {
      System.debug(LoggingLevel.ERROR, e.getMessage());
      throw e;
    }
  }
}
