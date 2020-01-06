import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:iv2ex/common/network/api.dart';

const requestTimeout = 1000 * 10;

class Networking {

  static Future request({@required APIType type, Map<String, dynamic> params}) async {
    API api = API(type: type);
    BaseOptions opts = BaseOptions(
        baseUrl: api.baseURL,
        receiveTimeout: requestTimeout,
        connectTimeout: requestTimeout,
        sendTimeout: requestTimeout,
        headers: api.headers,
        method: api.method
      );

    try {
      print("HTTP ${api.method} Request: ${api.baseURL}${api.path}, params: $params");
      Dio dio = Dio(opts);
      try {
      Future<ByteData> data = rootBundle.load("resource/mchain.pem");
      data.then((data) {
        print("wtf: $data ${data.lengthInBytes}");

          (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
            SecurityContext sc = SecurityContext();
            sc.useCertificateChainBytes(data.buffer.asInt8List());
            return HttpClient(context: sc);
          };
      });
      } on Exception catch (e) {
        print("eeeeee:$e");
      }
      return await dio.request(api.path, queryParameters: params).then( (resp){
        print("resp: ${resp.statusCode}, msg:${resp.statusMessage}, data:${resp.data}");
        if (resp.statusCode == 200) {
          return resp.data;
        }
      });
    } catch (e) {
      // 异常处理
      print("exception:${e.toString()}");
    }

  }

}
