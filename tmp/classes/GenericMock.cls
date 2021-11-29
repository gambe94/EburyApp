public with sharing abstract class GenericMock {
  private HttpRequest request;
  private HttpResponse response;
  private Integer statusCode;
  private String status;
  private Map<String, String> headerMap;
  @TestVisible
  private String jsonBody;

  private GenericMock() {
    headerMap = new Map<String, String>();
  }

  public GenericMock(Integer statusCode) {
    this();
    switch on statusCode {
      when 200 {
        jsonBody = getJsonResponseBodySuccess();
        status = 'OK';
      }
      when 400 {
        jsonBody = getJsonResponseBodyBadRequest();
        status = 'Bad request';
      }
      when 500 {
        jsonBody = getJsonResponseBodyServerError();
        status = 'Server Error';
      }
      when else {
        System.assert(false, statusCode + ' not implemented!');
      }
    }
    this.statusCode = statusCode;
    this.headerMap.put('Content-Type', 'application/json');
    this.headerMap.put('api-consumer', 'Salesforce');
  }

  public HttpResponse respond(HttpRequest request) {
    request = request;
    response = new HttpResponse();
    response.setStatusCode(statusCode);
    response.setStatus(status);
    for (String key : headerMap.keySet()) {
      response.setHeader(key, headerMap.get(key));
    }
    response.setBody(jsonBody);
    return response;
  }

  public GenericMock(String body) {
    this();
    jsonBody = body;
    status = 'OK';
    this.statusCode = 200;
    this.headerMap.put('Content-Type', 'application/json');
    this.headerMap.put('api-consumer', 'Salesforce');
  }

  protected abstract String getJsonResponseBodySuccess();

  private static String getJsonResponseBadBodySuccess() {
    return '{' +
      '"result": {' +
      '"status": "Error",' +
      '"message": "Bad request"' +
      '}';
  }

  private static String getJsonResponseBodyBadRequest() {
    return '{' +
      '"result": {' +
      '"status": "Error",' +
      '"message": "Bad request"' +
      '}' +
      '}';
  }

  private static String getJsonResponseBodyServerError() {
    return '{' +
      '"result": {' +
      '"status": "Error",' +
      '"message": "Server Error"' +
      '}' +
      '}';
  }
}
