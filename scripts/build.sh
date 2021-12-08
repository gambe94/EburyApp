#Create sratchOrg
sfdx force:org:create -f config/project-scratch-def.json -a QAEbury2 --setdefaultusername

sfdx force:source:push

#To give access to our system admin user
sfdx force:user:permset:assign --permsetname Ebury_Trading

#Import test trade records
sfdx force:data:tree:import -f data/Trade__c.json


#Create test User
sfdx force:user:create --setalias qa-user --definitionfile config/qa-userDef.json

#After metadatapush we some times tu run query to retrieve the queue
#Add queue members
sfdx force:apex:execute -f ./scripts/apex/addQueueMember.apex 

#Init customsetting
sfdx force:apex:execute -f ./scripts/apex/initCustomSetting.apex 

#Display Login info for testing user
sfdx force:user:display -u qa-user

#Open the org as qa-user
sfdx force:org:open -u qa-user

