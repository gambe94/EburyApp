Integration_Configs__c myConfig = new Integration_Configs__c(
  Org_domain__c = URL.getSalesforceBaseUrl().toExternalForm(),
  Fixer_Api_Key__c = 'b2dd3bc469487ef1af9ad2aaea908c3b'
);
Database.insert(myConfig, false);
