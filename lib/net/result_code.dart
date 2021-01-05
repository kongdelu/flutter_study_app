
enum StatusCode {
  SUCCESS,
  FAILURE,
}
class ResultCode {
  final StatusCode code;
  final String msg;

  ResultCode(this.code, this.msg);

  static String getMessage(StatusCode code) {
    String msg;
    switch (code) {
      case StatusCode.SUCCESS:
        msg = "成功";
        break;
      case StatusCode.FAILURE:
        msg = "失败";
        break;
    }
    return msg;
  }
}