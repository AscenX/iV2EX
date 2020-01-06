import 'package:flutter/material.dart';

/// 最新主题
const String kAPILatestTopcis = '/api/topics/latest.json';

/// 最热
const String kAPIHotTopcis = '/api/topics/hot.json';

/// 帖子详情
const String kAPITopicsDetail = '/api/topics/show.json';


enum APIType {
  banner,
  home,
  test,
}

class API {

  final APIType type;

  API({@required this.type});

  /// 服务器base url
  String get baseURL {
    switch(type) {
      case APIType.home: return "https://httpbin.org/";
      case APIType.banner: return "https://py.mchain.one/pocket/security";
      default: return "https://www.v2ex.com";
    }
  }

  /// 接口路径
  String get path {
    switch(type) {
      case APIType.home: return "get";
      case APIType.banner: return "/pocket/find_all_banner";
      default: return "";
    }
  }

  /// 请求方法
  String get method {
    switch(type) {
      case APIType.home: return "GET";
      case APIType.banner: return "POST";
      default: return "GET";
    }
  }

  /// 请求头
  Map<String, String> get headers {
    return  { "Content-type" : "application/json"};
  }

}
