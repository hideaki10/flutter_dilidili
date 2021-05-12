import 'package:flutter_dilidili/http/dao/login_dao.dart';

enum HttpMethod {
  GET,
  POST,
  DELETE,
}

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  // 定义域名
  String anthority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();

    //拼接path参数 有没有 /
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    //http和https切换
    if (useHttps) {
      uri = Uri.https(anthority(), pathStr, params);
    } else {
      uri = Uri.http(anthority(), pathStr, params);
    }

    if (needLogin()) {
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }

    print('url:${uri.toString()}');
    return uri.toString();
  }

  //　判断是否需要login
  bool needLogin();

  // 追加参数的map
  Map<String, String> params = Map();

  // 追加参数方法
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // 追加header参数
  Map<String, dynamic> header = {
    'course-flag': 'fa',
    'auth-token': 'ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa',
  };
  // 追加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
