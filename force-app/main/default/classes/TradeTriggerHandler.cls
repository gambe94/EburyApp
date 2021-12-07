public with sharing class TradeTriggerHandler {
  public static void afterInsert(List<Trade__c> triggerNew) {
    sendChatterNotification(triggerNew);
  }

  private static void sendChatterNotification(List<Trade__c> triggerNew) {
    PostToChatterService.postToChatterGroup(
      ChatterGroupSelector.getTradeReviewersGroup(),
      triggerNew
    );
  }
}
