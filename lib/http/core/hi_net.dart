import 'package:flutter_dilidili/requset/base_request.dart';

import 'dio_adapter.dart';
import 'hi_error.dart';
import 'hi_net_adapter.dart';

///
class Hinet {
  Hinet._();
  static Hinet? _instance;
  // factory Hinet() {
  //   return _instance!;
  // }
  ///
  static Hinet get gethinetInstance => _instance ??= Hinet._();

  ///
  Future<dynamic> fire(BaseRequest request) async {
    HiNetResponse? hiNetResponse;

    dynamic error;

    try {
      hiNetResponse = await send(request);
    } on HiNetError catch (e) {
      error = e;
      hiNetResponse = e.data;
      printLog(e.message);
    } on Exception catch (e) {
      error = e;
      printLog(e);
    }

    if (hiNetResponse == null) {
      printLog(error);
    }

    final dynamic result = hiNetResponse?.data;

    //var reponse = await send(request);
    // var result = hiNetResponse["data"];

    final dynamic status = hiNetResponse?.statusCode;
    printLog(result);
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status!, result.toString(), data: result);
    }
  }

  ///
  Future<dynamic> send<T>(BaseRequest baseRequest) {
    //print('url:${baseRequest.url()}');
    //print('method: ${baseRequest.httpMethod()}');
    baseRequest.addHeader('token', '123');
    // print('header:${baseRequest.header}');
    final HiNetAdadpter adadpter = DioAdapter();

    return adadpter.send(baseRequest);
    // return Future.value({
    //   "statusCode": 200,
    //   "data": {"code": 0, "message": "success"}
    // });
  }

  ///
  void printLog(dynamic log) {
    print('hi_net: + ${log.toString()}');
  }
}
