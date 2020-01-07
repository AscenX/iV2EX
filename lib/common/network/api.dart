import 'package:flutter/material.dart';

const String kBaseURL = "https://www.v2ex.com";
/// 最新主题
const String kLatestTopic = '/api/topics/latest.json';
/// 最热
const String kHotTopic = '/api/topics/hot.json';
/// 帖子详情
const String kTopicDetail = '/api/topics/show.json';


enum APIType {
  v2ex,
  latest,
  hottest,
  tabTopic,
  topicDetail
}

class API {

  final APIType type;

  API({@required this.type});

  /// 服务器base url
  String get baseURL {
    switch(type) {
      default: return kBaseURL;
    }
  }

  /// 接口路径
  String get path {
    switch(type) {
      case APIType.hottest: return kHotTopic;
      case APIType.latest: return kLatestTopic;
      case APIType.topicDetail: return kTopicDetail;
      default: return "/";
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
