sfdx force:org:create -f config/project-scratch-def.json -a Dev --setdefaultusername

sfdx force:source:push -u Dev

sfdx force:user:permset:assign --permsetname Ebury_Trading

# sfdx force:data:tree:export -q "SELECT Fixer_Api_Key__c FROM Integration_Configs__c" -d ./data
#sfdx force:data:tree:export -q "SELECT  Id,  Name, Buy_Amount__c, Buy_Currency__c, Sell_Amount__c, Sell_Currency__c, Rate__c  FROM Trade__c" -d ./data

sfdx force:data:tree:import -f data/Integration_Configs__c.json
sfdx force:data:tree:import -f data/Trade__c.json


sfdx force:user:create --setalias qa-user --definitionfile config/qa-userDef.json 
sfdx force:user:display -u tester1@ebury.fake9999.org

 sfdx force:source:deploy -p force-app/main/default/flows/Trade_Created.flow-meta.xml