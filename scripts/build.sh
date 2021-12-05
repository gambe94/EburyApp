sfdx force:org:create -f config/project-scratch-def.json -a Dev --setdefaultusername

sfdx force:source:push -u Dev

sfdx force:user:permset:assign --permsetname Ebury_Trading