//  String response = RateCalloutService.doCallout('EUR', 'HUF,USD');

String mock = '{"success":true,"timestamp":1637939043,"base":"EUR","date":"2021-11-26","rates":{ "HUF": 369.327743, "USD": 1.129349 }}';
System.debug(new RateCalloutResponseWrapper(mock).data);

// {base=EUR, date=2021-11-26, rates={HUF=369.327743, USD=1.129349}, success=true, timestamp=1637939043}

// Map<String, Object> rates = (Map<String, Object>) data.get('rates');

// System.debug(rates.get('HUF'));

// string viewPersonValue = '{"name":"John","age":30, "cars":  {"car1":"Ford","car2":"BMW", "car3":"Fiat"}}';

// Map<String, Object> meta = (Map<String, Object> JSON.deserializeUntyped(viewPersonValue);
// Map<String, Object>  carMap = (Map<String, Object>) meta.get('cars');
// system.debug(carMap.get('car1'));

