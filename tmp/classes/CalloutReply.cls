public abstract class CalloutReply {
  public HttpResponse response;
  @TestVisible
  @AuraEnabled
  public Boolean isSuccess;
  @AuraEnabled
  public String message;
  @AuraEnabled
  public DateTime timestampWatermark;

  public CalloutReply(String errorMessage) {
    this.isSuccess = false;
    this.message = errorMessage;
  }

  public CalloutReply(Exception e) {
    this(e.getTypeName() + ' : ' + e.getMessage());
  }

  public CalloutReply(HttpResponse response) {
    this.response = response;
  }

  public static Boolean checkResponseSucces(HttpResponse response) {
    return (response.getStatusCode() ==
    CalloutService.HTTP_REQUEST_SUCCESS_CODE);
  }
}
