@IsTest
global with sharing class RateCalloutServiceTest {
  public static final String successResponse =
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

  global class SucessMockCalloutMockImpl implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
      // Create a fake response
      HttpResponse res = new HttpResponse();
      res.setHeader('Content-Type', 'application/json');
      res.setBody(successResponse);
      res.setStatusCode(200);
      return res;
    }
  }

  @IsTest
  private static void testRateCalloutSuccessfull() {
    Test.setMock(HttpCalloutMock.class, new SucessMockCalloutMockImpl());
    Test.startTest();
    String response = RateCalloutService.doCallout(true, 'EUR', 'HUF');
    System.debug(response);
    Test.stopTest();
  }

  // @isTest
  // static void assertGetExampleReplySuccess() {
  //   Test.setMock(HttpCalloutMock.class, new ExampleMock(200));
  //   Account currentAccount = [SELECT Id FROM Account LIMIT 1];

  //   Test.startTest();
  //   ExampleReply reply = ExampleService.getExampleReply(
  //     currentAccount.Id,
  //     '123456',
  //     System.today().addDays(-10),
  //     System.today()
  //   );
  //   Test.stopTest();

  //   System.assert(reply.isSuccess, 'Reply was unsuccessful.');
  // }
}
