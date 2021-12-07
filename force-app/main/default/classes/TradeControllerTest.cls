@IsTest
public with sharing class TradeControllerTest {
  @IsTest
  private static void testGetAllTrade() {
    String GROUP_NAME = 'GABOR GROUP work';
    ChatterGroupSelector.TEST_GROUP_NAME = GROUP_NAME;

    CollaborationGroup myGroup = new CollaborationGroup();
    myGroup.Name = GROUP_NAME;
    myGroup.CollaborationType = 'Public';
    insert myGroup;

    List<Trade__c> trades = new List<Trade__c>();
    for (Integer i = 0; i < 10; i++) {
      trades.add(
        new Trade__c(
          Buy_Amount__c = 200,
          Buy_Currency__c = 'HUF',
          Sell_Amount__c = 300,
          Sell_Currency__c = 'EUR',
          Rate__c = 1.145
        )
      );
    }
    insert trades;
    List<Trade__c> result;
    Test.startTest();
    result = TradesController.getAllTrade();
    Test.stopTest();
    System.assertEquals(10, result.size(), 'Not 10 Trade record was retreived');
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
