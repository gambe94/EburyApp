sfdx force:org:create -f config/project-scratch-def.json -a Dev --setdefaultusername

sfdx force:source:push -u Dev

sfdx force:user:permset:assign --permsetname Ebury_Trading

# sfdx force:data:tree:export -q "SELECT Fixer_Api_Key__c FROM Integration_Configs__c" -d ./data

sfdx force:data:tree:import -f data/Integration_Configs__c.json