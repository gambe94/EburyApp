public abstract class CalloutService {
  public static final Integer HTTP_REQUEST_SUCCESS_CODE = 200;

  public abstract CalloutReply sendGetRequest();

  public class CalloutServiceException extends Exception {
  }
}
