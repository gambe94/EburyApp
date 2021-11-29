/**
 * Class containing Example mock response
 */
@isTest
public with sharing class ExampleMock extends GenericMock implements HttpCalloutMock {
  public ExampleMock(Integer statusCode) {
    super(statusCode);
  }

  protected override String getJsonResponseBodySuccess() {
    return '{ ' +
      ' "success": true,' +
      ' "timestamp": 1519296206,' +
      ' "base": "EUR",' +
      ' "date": "2021-11-26",' +
      ' "rates": {' +
      '     "AUD": 1.566015,' +
      '     "CAD": 1.560132,' +
      '     "CHF": 1.154727,' +
      '     "CNY": 7.827874,' +
      '     "GBP": 0.882047,' +
      '     "JPY": 132.360679,' +
      '     "USD": 1.23396,' +
      '}' +
      '}';
  }
}
