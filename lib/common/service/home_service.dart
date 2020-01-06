import 'dart:convert';

import 'package:iv2ex/common/network/networking.dart';
import 'package:iv2ex/common/network/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

import '../../module/home/model/topic.dart';
import '../../module/home/view_model/topic_item_view_model.dart';
import '../../module/home/model/index_data.dart';
import '../../module/detail/topics_detail.dart';
import '../../module/detail/reply.dart';

class HomeService {


  static Observable<int> fetchData(int test) {

    var params = {"test" : test };

    return Observable.fromFuture(Networking.request(type: APIType.iv2ex, params: params)).map( (data) {
//      Map<String, dynamic> json = data;
//      if (json.containsKey("args")) {
//        Map<String, dynamic> test = json["args"];
//        return int.parse(test["test"]);
//      }
      return 1;
    });
  }


  /// 获取首页html数据
  static Observable<dynamic> fetchIndexHTML({String tab}) {
    Map<String, Object> params = tab != null ? {'tab' : tab} : null;

    return Observable.fromFuture(Networking.request(type: APIType.iv2ex)).map( (data) {
      return IndexData.fromHTML()
    });
  }

  /// 获取最新帖子
  fetchLatestTopics() async* {
//    yield* _get(path:kAPILatestTopic).map((data){
//      Response resp = data;
//      return (resp.data as List).map((d){
//        return TopicItemViewModel(Topic.fromJson(d));
//      }).toList();
//    });
  }

  /// 获取热门帖子
  fetchHotTopics() async* {
//    yield* _get(path:kAPIHotTopic).map((data){
//      Response resp = data;
//      return (resp.data as List).map((d){
//        return TopicItemViewModel(Topic.fromJson(d));
//      }).toList();
//    });
  }

  /// 获取帖子id获取详情数据
  fetchTopicsDetail(int topicsId) async* {
//    yield* _get(path: kAPITopicDetail, param: {'id' : topicsId.toString()}).map((data){
//      Response resp = data;
//      return TopicsDetail.fromJson((resp.data as List).first);
//    });
  }

  fetchTopicsDetailHTML(int topicsId, {int page}) async* {
    String path = page != null ? '/t/$topicsId?p=$page' : '/t/$topicsId';
    print('path:$path');
    yield* _get(path: path).map((data){
      String htmlStr = (data as Response).data.toString();
      List replies = RegExp(r'<div id="r_[\s\S.]+?</table>', multiLine: true).allMatches(htmlStr).map((m){
        String replyStr = m.group(0);
        return Reply.fromHTML(replyStr);
      }).toList();
      return replies;
    });
  }
}
