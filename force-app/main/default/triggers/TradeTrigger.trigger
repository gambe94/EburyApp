trigger TradeTrigger on Trade__c(after insert) {
  if (Trigger.isAfter && Trigger.isInsert) {
    TradeTriggerHandler.afterInsert(Trigger.new);
  }
}
