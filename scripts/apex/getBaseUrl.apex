delete [ SELECT
        Id,
        Name,
        Buy_Amount__c,
        Buy_Currency__c,
        Sell_Amount__c,
        Sell_Currency__c,
        Rate__c,
        CreatedDate
      FROM Trade__c LIMIT 15];
