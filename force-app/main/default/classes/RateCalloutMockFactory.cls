public with sharing class RateCalloutMockFactory {
  public class RateCalloutMockFactoryException extends Exception {
  }

  public static HttpCalloutMock getMock(Integer statusCode) {
    switch on statusCode {
      when 200 {
        return new RateCallouSuccessMock();
      }
      when 101 {
        return new RateCallouInvalidKeyMock();
      }
      when 105 {
        return new RateCallouBaseCurrencyRestricted();
      }
      when else {
        throw new RateCalloutMockFactoryException(
          'The following status code not implemented: ' + statusCode
        );
      }
    }
  }

  public class RateCallouSuccessMock implements HttpCalloutMock {
    String response =
      '{ ' +
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
      '     "USD": 1.23396' +
      '}' +
      '}';

    public HTTPResponse respond(HTTPRequest req) {
      // Create a fake response
      HttpResponse res = new HttpResponse();
      res.setHeader('Content-Type', 'application/json');
      res.setBody(response);
      res.setStatusCode(200);
      return res;
    }
  }
  public class RateCallouInvalidKeyMock implements HttpCalloutMock {
    String response =
      '{ ' +
      '"success": false,' +
      '"error": {' +
      '    "code": 101,' +
      '    "type": "invalid_access_key",' +
      '    "info": "You have not supplied a valid API Access Key. [Technical Support: support@apilayer.com]"' +
      '}' +
      '}';

    public HTTPResponse respond(HTTPRequest req) {
      // Create a fake response
      HttpResponse res = new HttpResponse();
      res.setHeader('Content-Type', 'application/json');
      res.setBody(response);
      res.setStatusCode(101);
      return res;
    }
  }

  public class RateCallouBaseCurrencyRestricted implements HttpCalloutMock {
    String response =
      '{' +
      '  "success": false,' +
      '  "error": {' +
      '      "code": 105,' +
      '      "type": "base_currency_access_restricted"' +
      '  }' +
      '}';
    public HTTPResponse respond(HTTPRequest req) {
      // Create a fake response
      HttpResponse res = new HttpResponse();
      res.setHeader('Content-Type', 'application/json');
      res.setBody(response);
      res.setStatusCode(105);
      return res;
    }
  }
}
