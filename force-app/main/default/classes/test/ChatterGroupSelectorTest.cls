@Istest
public with sharing class ChatterGroupSelectorTest {
  @Istest
  private static void testGetTradeReviewersGroup() {
    Id groupId = TestFactory.createFakeChatterGroup();

    Id selectedId;
    Test.startTest();
    selectedId = ChatterGroupSelector.getTradeReviewersGroup();
    Test.stopTest();
    System.assertEquals(
      groupId,
      selectedId,
      'Dont find the right chatter group'
    );
  }
}
