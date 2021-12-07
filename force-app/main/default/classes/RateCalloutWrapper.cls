public with sharing class RateCalloutWrapper {
  public class RateCalloutWrapperException extends Exception {
    @AuraEnabled
    public RateCalloutWrapper.Error customError;
    public RateCalloutWrapperException(RateCalloutWrapper.Error error) {
      this.customError = error;
      this.setMessage(String.isNotBlank(error.info) ? error.info : error.type);
    }
  }

  public Boolean success { get; set; }
  public String base { get; set; }
  @AuraEnabled
  public Rate rates { get; set; }
  @AuraEnabled
  public Error error { get; set; }

  public class Rate {
    @AuraEnabled
    public Double HUF;
    @AuraEnabled
    public Double EUR;
    @AuraEnabled
    public Double USD;
    @AuraEnabled
    public Double CHF;
    @AuraEnabled
    public Double GBP;
    @AuraEnabled
    public Double CAD;
  }

  public class Error {
    @AuraEnabled
    public Integer code { get; set; }
    @AuraEnabled
    public String type { get; set; }
    @AuraEnabled
    public String info { get; set; }
  }
}
