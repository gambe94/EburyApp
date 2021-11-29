/**
 * Service class for sending example request and handling the response
 */
public with sharing class ExampleService {
  // Retrieve named credential from custom setting
  private static final String ESB_NAMED_CREDENTIAL = WebserviceSettings__c.getOrgDefaults()
    .NamedCredentialAPIName__c;
  private static final String EXAMPLE_PATH = '/getExampleReply';

  /**
   * This method sends the request
   *
   * @param recordId - record from which the request is sent
   * @param companyNumber - external account id
   * @param dateFrom - used to filter results by date
   * @param dateTo - used to filter results by date
   */
  @AuraEnabled
  public static ExampleReply getExampleReply(
    Id recordId,
    String companyNumber,
    Date dateFrom,
    Date dateTo
  ) {
    ExampleRequest request = new ExampleRequest(
      new Request(recordId, companyNumber, dateFrom, dateTo)
    );
    String body = JSON.serialize(request);
    String endpoint = 'callout:' + ESB_NAMED_CREDENTIAL + EXAMPLE_PATH;
    String method = HttpUtility.HTTP_POST;
    ExampleReply reply;
    try {
      HttpResponse response = HttpUtility.buildAndSendHttpRequest(
        body,
        endpoint,
        method,
        null
      );
      reply = new ExampleReply(response);
      if (reply.isSuccess && reply.ExampleResponse.status.result == 'OK') {
        // Do some logic using the retrieved response
      } else if (
        reply.isSuccess && reply.ExampleResponse.status.result != 'OK'
      ) {
        reply.isSuccess = false;
        reply.errorMessage = reply.ExampleResponse.status.message;
      }
    } catch (HttpUtility.HttpUtilityCalloutException e) {
      reply = new ExampleReply(e);
    }
    if (!reply.isSuccess) {
      // Do some logic when retrieved reply is unsuccessful
    }

    // Optionally - create a log record in Salesforce
    RequestLogger.log(reply.isSuccess, reply.errorMessage);

    return reply;
  }

  /**
   * Mapping for request
   */
  public class ExampleRequest {
    public Request request;

    public ExampleRequest(Request request) {
      this.request = request;
    }
  }

  public class Request {
    public String companyNumber;
    public String dateFrom;
    public String dateTo;
    public String recordId;

    public Request(
      Id recordId,
      String companyNumber,
      Date dateFrom,
      Date dateTo
    ) {
      this.companyNumber = companyNumber;
      this.dateFrom = String.valueOf(dateFrom);
      this.dateTo = String.valueOf(dateTo);
      this.recordId = String.valueOf(recordId);
    }
  }
}
