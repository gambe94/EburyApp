# Ebury Trading App

User easily can create Trade records in the Ebury Trading Salesforce Application.
Use fixer.io api for rate currency conversion.

## Deployment

There is a deployment script in place which you need to use from the root:

```sh
./scripts/build.sh
```

## Queue members insert

There is a command which run anonymus apex to insert queue member into Trade reviewer.
After pushing the metadata sometimes need to wait to be able to query the queue

If command in script ,failed pls run this command again

```sh
sfdx force:apex:execute -f ./scripts/apex/addQueueMember.apex
```
