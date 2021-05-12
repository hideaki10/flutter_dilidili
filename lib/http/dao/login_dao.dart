import 'package:flutter_dilidili/db/hi_cache.dart';
import 'package:flutter_dilidili/http/core/hi_net.dart';
import 'package:flutter_dilidili/requset/base_request.dart';
import 'package:flutter_dilidili/requset/login_request.dart';
import 'package:flutter_dilidili/requset/registration_request.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password, {imoocId, orderId}) async {
    BaseRequest baseRequest;

    if (imoocId != null && orderId != null) {
      baseRequest = RegistrationRequest();
      baseRequest.add("imoocId", imoocId).add("orderId", orderId);
    } else {
      baseRequest = LoginRequest();
    }

    baseRequest.add("userName", userName).add("password", password);

    dynamic result = await Hinet.gethinetInstance.fire(baseRequest);

    //设置令牌
    if (result['code'] == 0 && result['data'] != null) {
      dynamic cache = HiCache.getHicache;
      print("one cache  $cache ++++++++++++++++");
      cache.setString(BOARDING_PASS, result['data']);
    }

    //print("result : $result");
    return result;
  }

  //取得令牌
  static getBoardingPass() {
    dynamic cache = HiCache.getHicache;
    print("two cache  $cache ++++++++++++++++");
    return cache.get(BOARDING_PASS);
  }
}
