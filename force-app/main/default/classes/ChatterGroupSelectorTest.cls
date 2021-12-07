@Istest
public with sharing class ChatterGroupSelectorTest {
  @Istest
  private static void testGetTradeReviewersGroup() {
    String GROUP_NAME = 'GABOR GROUP work';
    ChatterGroupSelector.TEST_GROUP_NAME = GROUP_NAME;

    CollaborationGroup myGroup = new CollaborationGroup();
    myGroup.Name = GROUP_NAME;
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
