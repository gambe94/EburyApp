//  String response = RateCalloutService.doCallout('EUR', 'HUF,USD');

String mock = '{"success":true,"timestamp":1637939043,"base":"EUR","date":"2021-11-26","rates":{ "HUF": 369.327743, "USD": 1.129349 }}';
Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(mock);
Object rates = data.get('rates');
System.debug(JSON.deserializeUntyped(rates.toString()));
