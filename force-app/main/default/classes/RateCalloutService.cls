public with sharing class RateCalloutService {
  public static String doCallout(String baseCurrency) {
    Map<String, String> headers = new Map<String, String>();

    CalloutUtils callout = new CalloutUtils();

    callout
      .endPoint('http://data.fixer.io/api/latest')
      .method('GET')
      .addHeader('Content-Type', 'application/json')
      .addParameter('accessKey', 'b2dd3bc469487ef1af9ad2aaea908c3b')
      .addParameter('base', baseCurrency)
      .addParameter('symbol', 'HUF,EUR')
      .timeout(10000);

    HttpResponse res = callout.send();
    return res.getBody();
  }
}
