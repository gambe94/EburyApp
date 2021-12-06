@IsTest
global with sharing class RateCalloutServiceTest {
  @IsTest
  private static void testRateCalloutSuccessfull() {
    HttpCalloutMock mySuccessMock = RateCalloutMockFactory.getMock(200);

    Test.setMock(HttpCalloutMock.class, mySuccessMock);
    RateCalloutWrapper.Rate actualRate;
    Test.startTest();
    RateCalloutService calloutService = new RateCalloutService('EUR', 'HUF');
    actualRate = calloutService.doCallout();
    Test.stopTest();
    System.assertEquals(365, actualRate.HUF);
    System.assertEquals(1.560132, actualRate.CAD);
  }

  @IsTest
  private static void testRateCalloutInvalidAccessKey() {
    HttpCalloutMock invalidMock = RateCalloutMockFactory.getMock(101);

    Test.setMock(HttpCalloutMock.class, invalidMock);
    RateCalloutWrapper.Rate actualRate;
    Boolean isExceptionOccured = false;
    Test.startTest();
    try {
      RateCalloutService calloutService = new RateCalloutService('EUR', 'HUF');
      actualRate = calloutService.doCallout();
    } catch (RateCalloutWrapper.RateCalloutWrapperException e) {
      isExceptionOccured = true;
      System.debug(e.customError);
    }
    Test.stopTest();
    System.assert(
      isExceptionOccured,
      'RateCalloutWrapperException not occured'
    );
  }
}
