@Istest
public with sharing class ChatterGroupSelectorTest {
  @Istest
  private static void testGetTradeReviewersGroup() {
    ChatterGroupSelector.TRADE_REVIEWS_GROUP = 'Not exist group';

    CollaborationGroup myGroup = new CollaborationGroup();
    myGroup.Name = ChatterGroupSelector.TRADE_REVIEWS_GROUP;
    myGroup.CollaborationType = 'Public';
    insert myGroup;

    Id selectedId;
    Test.startTest();
    selectedId = ChatterGroupSelector.getTradeReviewersGroup();
    Test.stopTest();
    System.assertEquals(
      myGroup.Id,
      selectedId,
      'Dont find the right chatter group'
    );
  }
}
