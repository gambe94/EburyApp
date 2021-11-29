/**
 * Class containing mapping for Example response
 */
public with sharing class ExampleResponse {
  @AuraEnabled
  public Status status;
  @AuraEnabled
  public String correlationId;

  public class Status {
    @AuraEnabled
    public String result;
    @AuraEnabled
    public String message;
  }

  public static ExampleResponse parse(String json) {
    return (ExampleResponse) System.JSON.deserialize(
      json,
      ExampleResponse.class
    );
  }
}
