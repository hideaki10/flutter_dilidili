import 'package:flutter_dilidili/http/core/hi_net.dart';
import 'package:flutter_dilidili/requset/base_request.dart';
import 'package:flutter_dilidili/requset/login_request.dart';
import 'package:flutter_dilidili/requset/registration_request.dart';

class LoginDao {
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
    print("result : $result");
    return result;
  }
}
