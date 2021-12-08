@IsTest
public with sharing class TradeControllerTest {
  @IsTest
  private static void testGetAllTrade() {
    Integer recordNumber = 50;
    List<Trade__c> trades = TestFactory.createTrades(recordNumber);

    insert trades;
    List<Trade__c> result;
    Test.startTest();
    result = TradesController.getAllTrade();
    Test.stopTest();
    System.assertEquals(
      recordNumber,
      result.size(),
      'Not 10 Trade record was retreived'
    );
  }

  @IsTest
  private static void testGetRate() {
    HttpCalloutMock mySuccessMock = RateCalloutMockFactory.getMock(200);

    Test.setMock(HttpCalloutMock.class, mySuccessMock);

    RateCalloutWrapper.Rate result = null;
    Test.startTest();
    result = TradesController.getRate('EUR', 'HUF');
    Test.stopTest();
    System.assertEquals(
      365,
      result.HUF,
      'Succes Rate Callout Mock HUF rate is diffrent'
    );
  }
}
