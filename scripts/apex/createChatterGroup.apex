CollaborationGroup myGroup = new CollaborationGroup();
myGroup.Name = 'Trade reviewers';
myGroup.CollaborationType = 'Public'; //can be 'Public' or 'Private'
insert myGroup;

CollaborationGroupMember groupMember = new CollaborationGroupMember();
groupMember.memberid = [
  SELECT Id
  FROM User
  WHERE username LIKE 'tester1@ebury%'
]
.Id;
groupMember.CollaborationGroupId = myGroup.Id; //Id of group created above
insert groupMember;
