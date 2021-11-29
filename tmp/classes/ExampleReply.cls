/**
 * Class for handling reply retrieved from Example service
 */
public class ExampleReply extends CalloutReply {
  @AuraEnabled
  public ExampleResponse response;

  public ExampleReply(String errorMessage) {
    super(errorMessage);
  }

  public ExampleReply(Exception e) {
    super(e.getTypeName() + ' : ' + e.getMessage());
  }

  public ExampleReply(HttpResponse response) {
    super(response);
    if (checkResponseSucces(response)) {
      Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
        response.getBody()
      );
      parseResponse(responseMap);
    } else {
      this.message = response.getStatusCode() + ':' + response.getStatus();
      this.isSuccess = false;
    }
  }

  private void parseResponse(Map<String, Object> responseMap) {
    try {
      this.response = ExampleResponse.parse(JSON.serialize(responseMap));
      this.isSuccess = true;
    } catch (System.JSONException exc) {
      this.message = exc.getTypeName() + ' : ' + exc.getMessage();
      this.isSuccess = false;
    }
  }
}
