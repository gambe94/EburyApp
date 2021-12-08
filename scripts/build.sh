#Create sratchOrg
#sfdx force:org:create -f config/project-scratch-def.json -a QAEbury --setdefaultusername

sfdx force:source:push

#To give access to our system admin user
sfdx force:user:permset:assign --permsetname Ebury_Trading

#Import test trade records
sfdx force:data:tree:import -f data/Trade__c.json

#Add queue members
sfdx force:apex:execute -f ./scripts/apex/addQueueMember.apex 

#Init customsetting
sfdx force:apex:execute -f ./scripts/apex/initCustomSetting.apex 

#Create test User
sfdx force:user:create --setalias qa-user --definitionfile config/qa-userDef.json 

#Display Login info for testing user
sfdx force:user:display -u qa-user



