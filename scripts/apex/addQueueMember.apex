Group tradeViewersGroup = [
  SELECT id
  FROM Group
  WHERE DeveloperName = 'Trade_reviewers'
];

List<GroupMember> members = new List<GroupMember>();
GroupMember createdUser = new GroupMember(
  UserOrGroupId = [SELECT Id FROM User WHERE username LIKE 'tester1@ebury%']
  .Id,
  GroupId = tradeViewersGroup.Id
);

members.add(createdUser);

GroupMember myUser = new GroupMember(
  UserOrGroupId = UserInfo.getUserId(),
  GroupId = tradeViewersGroup.Id
);

members.add(myUser);

Database.insert(members, false)
