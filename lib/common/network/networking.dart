import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:iv2ex/common/network/api.dart';
import 'package:rxdart/rxdart.dart';

const requestTimeout = 1000 * 10;

class Networking {

  static Observable request({@required APIType type, Map<String, dynamic> params}) {
    API api = API(type: type);
    BaseOptions opts = BaseOptions(
        baseUrl: api.baseURL,
        receiveTimeout: requestTimeout,
        connectTimeout: requestTimeout,
        sendTimeout: requestTimeout,
        headers: api.headers,
        method: api.method
      );

    Dio dio = Dio(opts);
    print("path: ${api.path}, params:$params");
    final request = dio.request(api.path, queryParameters: params).then( (resp){
      print("resp: ${resp.statusCode}, msg:${resp.statusMessage}, data:${resp.data}");
      if (resp.statusCode == 200) {
        return resp.data;
      }
    });
    return Observable.fromFuture(request);

  }

}
