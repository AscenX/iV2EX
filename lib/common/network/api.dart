import 'package:flutter/material.dart';

/// 最新主题
const String kAPILatestTopic = '/api/topics/latest.json';
/// 最热
const String kAPIHotTopic = '/api/topics/hot.json';
/// 帖子详情
const String kAPITopicDetail = '/api/topics/show.json';


enum APIType {
  iv2ex,
  lastest,
  hotest,
  tabTopic,
  topicDetail
}

class API {

  final APIType type;

  API({@required this.type});

  /// 服务器base url
  String get baseURL {
    switch(type) {
      default: return "https://www.v2ex.com";
    }
  }

  /// 接口路径
  String get path {
    switch(type) {
      case APIType.hotest: return kAPIHotTopic;
      case APIType.lastest: return kAPILatestTopic;
      case APIType.topicDetail: return kAPITopicDetail;
      default: return "";
    }
  }

  /// 请求方法
  String get method {
    switch(type) {
      default: return "GET";
    }
  }

  /// 请求头
  Map<String, String> get headers {
    return  { "Content-type" : "application/json;text/html"};
  }

}
