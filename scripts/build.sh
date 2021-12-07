sfdx force:org:create -f config/project-scratch-def.json -a Dev --setdefaultusername

sfdx force:source:push -u Dev

#To give access to our system admin user
sfdx force:user:permset:assign --permsetname Ebury_Trading

# sfdx force:data:tree:export -q "SELECT Fixer_Api_Key__c FROM Integration_Configs__c" -d ./data
#sfdx force:data:tree:export -q "SELECT  Id,  Name, Buy_Amount__c, Buy_Currency__c, Sell_Amount__c, Sell_Currency__c, Rate__c  FROM Trade__c" -d ./data

#Import config records
sfdx force:data:tree:import -f data/Integration_Configs__c.json
#Import test trade records
sfdx force:data:tree:import -f data/Trade__c.json

#Create chatterGroup and add member
sfdx force:apex:execute -f ./scripts/apex/createChatterGroup.apex 

#Create test User
sfdx force:user:create --setalias qa-user --definitionfile config/qa-userDef.json 
sfdx force:user:display -u qa-user



