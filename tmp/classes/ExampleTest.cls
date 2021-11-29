/**
 * Test class for Example service
 */
@isTest
public with sharing class ExampleTest {
  @testSetup
  static void setup() {
    Account testAccount = new Account(Name = 'TestAccount');
    insert testAccount;
  }

  @isTest
  static void assertGetExampleReplySuccess() {
    Test.setMock(HttpCalloutMock.class, new ExampleMock(200));
    Account currentAccount = [SELECT Id FROM Account LIMIT 1];

    Test.startTest();
    ExampleReply reply = ExampleService.getExampleReply(
      currentAccount.Id,
      '123456',
      System.today().addDays(-10),
      System.today()
    );
    Test.stopTest();

    System.assert(reply.isSuccess, 'Reply was unsuccessful.');
  }

  @isTest
  static void assertGetMosCalculateReplyBadRequest() {
    Test.setMock(HttpCalloutMock.class, new ExampleMock(400));
    Account currentAccount = [SELECT Id FROM Account LIMIT 1];

    Test.startTest();
    try {
      ExampleReply reply = ExampleService.getExampleReply(
        currentAccount.Id,
        '123456',
        System.today().addDays(-10),
        System.today()
      );
    } catch (Exception e) {
      System.assert(
        e.getMessage().containsIgnoreCase('Bad request'),
        'Error message does not contain bad request'
      );
    }
    Test.stopTest();
  }
}
