import 'dart:convert';

import 'package:flutter_dilidili/requset/base_request.dart';

abstract class HiNetAdadpter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

class HiNetResponse<T> {
  HiNetResponse({
    this.data,
    this.baseRequest,
    this.statusCode,
    this.extra,
    this.statusMessage,
  });

  Map? data;
  BaseRequest? baseRequest;
  int? statusCode;
  String? statusMessage;
  dynamic? extra;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
