/**
 * Common utility class for invoking Http requests.
 *
 */
public with sharing class HttpUtility {
  private static final Set<String> ALLOWED_HTTP_METHODS = new Set<String>{
    'GET',
    'POST',
    'PUT',
    'DELETE',
    'PATCH'
  };
  public static final String HTTP_GET = 'GET';
  public static final String HTTP_POST = 'POST';
  private static final Integer DEFAULT_TIMEOUT = 30000;

  public static HttpResponse buildAndSendHttpRequest(
    String body,
    String endPoint,
    String httpMethod,
    Map<String, String> headerMap,
    Integer timeout
  ) {
    HttpRequest request = buildRequest(
      body,
      endPoint,
      httpMethod,
      headerMap,
      timeout
    );
    return sendRequest(request);
  }

  public static HttpResponse buildAndSendHttpRequest(
    String body,
    String endPoint,
    String httpMethod,
    Map<String, String> headerMap
  ) {
    HttpRequest request = buildRequest(
      body,
      endPoint,
      httpMethod,
      headerMap,
      null
    );
    return sendRequest(request);
  }

  /**
   * Constructs a REST message. The HTTP request is not sent with this method.
   *
   * @param  body               The payload of the REST message to be included in the HTTP request body.
   * @param  endPoint           The endpoint of the web service where the message will be sent to.
   * @param  httpMethod         The type of http method (GET/POST/PATCH etc.)
   * @param  headerMap          When set Key value pair for http headers
   * @return                    A HTTP response using the given input parameters
   */
  private static HttpRequest buildRequest(
    String body,
    String endPoint,
    String httpMethod,
    Map<String, String> headerMap,
    Integer timeout
  ) {
    HttpRequest request = new HttpRequest();

    if (body != null) {
      request.setBody(body);
    }

    if (endPoint != null) {
      request.setEndpoint(endPoint);
    }

    if (
      httpMethod != null &&
      ALLOWED_HTTP_METHODS.contains(httpMethod.toUpperCase())
    ) {
      request.setMethod(httpMethod.toUpperCase());
    }

    // Set the asynchronous timeout for the callout
    if (timeout != null) {
      request.setTimeout(timeout);
    } else {
      request.setTimeout(DEFAULT_TIMEOUT);
    }

    if (headerMap != null) {
      for (String headerKey : headerMap.keySet()) {
        request.setHeader(headerKey, headerMap.get(headerKey));
      }
    }
    request.setHeader('client_id', '{!$Credential.Username}');
    request.setHeader('client_secret', '{!$Credential.Password}');
    request.setHeader('api-consumer', 'Salesforce');
    request.setHeader('Content-Type', 'application/json');

    System.debug(
      LoggingLevel.ERROR,
      '*** HttpUtility EndPoint: ' + request.getEndpoint()
    );
    System.debug(
      LoggingLevel.ERROR,
      '*** HttpUtility Content-Type: ' + request.getHeader('Content-Type')
    );
    System.debug(
      LoggingLevel.ERROR,
      '*** HttpUtility BODY: ' + request.getBody()
    );

    return request;
  }

  /**
   * Sends the provided HTTP request to the external web service.
   *
   * @param  request The HTTP request to send.
   * @return         The HTTP response from the sending of the request.
   */
  private static HttpResponse sendRequest(HttpRequest request) {
    // Begin sending of the request
    HttpResponse response;

    try {
      response = new Http().send(request);
    } catch (Exception ex) {
      System.debug(LoggingLevel.ERROR, 'ex.getMessage(): ' + ex.getMessage());
      System.debug(
        LoggingLevel.ERROR,
        'ex.getStackTraceString(): ' + ex.getStackTraceString()
      );
      throw new HttpUtilityCalloutException(ex);
    }

    // Print out the response to the debug log to help debugging
    if (response != null) {
      System.debug(
        LoggingLevel.ERROR,
        '*** HttpUtility Response: ' + String.valueOf(response)
      );
      System.debug(
        LoggingLevel.ERROR,
        '*** HttpUtility Response Status Code: ' + response.getStatusCode()
      );
      System.debug(
        LoggingLevel.ERROR,
        '*** HttpUtility Response BODY: ' + response.getBody()
      );
    }

    return response;
  }

  public class HttpUtilityCalloutException extends Exception {
  }
}
