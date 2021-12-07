@IsTest
public with sharing class RateCalloutServiceTest {
  @IsTest
  private static void testRateCalloutSuccessfull() {
    HttpCalloutMock mySuccessMock = RateCalloutMockFactory.getMock(200);

    Test.setMock(HttpCalloutMock.class, mySuccessMock);
    RateCalloutWrapper.Rate actualRate;
    Test.startTest();
    RateCalloutService calloutService = new RateCalloutService('EUR', 'HUF');
    actualRate = calloutService.doCallout();
    Test.stopTest();
    System.assertEquals(
      365,
      actualRate.HUF,
      'Actual rate not same as defined in the mock'
    );
    System.assertEquals(
      1.560132,
      actualRate.CAD,
      'Actual rate not same as defined in the mock'
    );
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
    }
    Test.stopTest();
    System.assert(
      isExceptionOccured,
      'RateCalloutWrapperException not occured'
    );
  }
  @IsTest
  private static void testRateCalloutestrictedAccess() {
    HttpCalloutMock restrictedMock = RateCalloutMockFactory.getMock(105);

    Test.setMock(HttpCalloutMock.class, restrictedMock);
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
