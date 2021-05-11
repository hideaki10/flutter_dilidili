class HiNetError implements Exception {
  HiNetError(this.code, this.message, {this.data});
  final int code;
  final String message;
  final dynamic data;
}

class NeedAuth extends HiNetError {
  NeedAuth(String message, {int code: 403, data})
      : super(code, message, data: data);
}

class NeedLogin extends HiNetError {
  NeedLogin({String message: 'qingxiandenglu', int code: 401})
      : super(code, message);
}
