
import 'package:rxdart/rxdart.dart';
import 'package:iv2ex/common/network/api.dart';
import 'package:iv2ex/common/network/networking.dart';


import 'package:iv2ex/module/home/model/topic.dart';
import 'package:iv2ex/module/home/model/index_data.dart';
import 'package:iv2ex/module/detail/topics_detail.dart';
import 'package:iv2ex/module/detail/reply.dart';

class HomeService {

  /// 获取首页html数据
  static Observable fetchIndexHTML({int tab}) {
    Map<String, Object> params = tab != null ? {'tab' : tab} : null;

    return Networking.request(type: APIType.v2ex).map( (data) {
      return IndexData.fromHTML(data);
    });
  }

  /// 获取最新帖子
  static Observable fetchLatestTopics() {
    return Networking.request(type: APIType.latest).map( (data) {
      return Topic.fromJson(data);
    });
  }

  /// 获取热门帖子
  static Observable fetchHottestTopics() {
    return Networking.request(type: APIType.hottest).map( (data) {
      return Topic.fromJson(data);
    });
  }

  /// 获取帖子id获取详情数据
  static Observable fetchTopicsDetail(int topicsId) {
    return Networking.request(type: APIType.topicDetail, params: {'id' : topicsId.toString()}).map( (data) {
      return TopicsDetail.fromJson((data as List).first);
    });
  }

  /// 获取帖子的回复
  static fetchTopicsDetailHTML(int topicsId, {int page}) {
    String path = page != null ? '/t/$topicsId?p=$page' : '/t/$topicsId';
    return Networking.request(type: APIType.v2ex, params: {"" : path }).map((data) {
      String htmlStr = data.toString();
      List replies = RegExp(r'<div id="r_[\s\S.]+?</table>', multiLine: true).allMatches(htmlStr).map((m){
        String replyStr = m.group(0);
        return Reply.fromHTML(replyStr);
      }).toList();
    });
  }
}
