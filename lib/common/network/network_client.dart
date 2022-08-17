import 'package:dio/dio.dart';
import './api.dart';
// import '../../module/index/topics.dart';
// import '../../module/index/topics_item_view_model.dart';
import '../../module/index/index_data.dart';
// import '../../module/detail/topics_detail.dart';
// import '../../module/detail/reply.dart';

class NetWorkClient {

  Dio? _dio;

  // 使用单例
  factory NetWorkClient() =>_getInstance();
  static NetWorkClient get shared => _getInstance();
  static NetWorkClient? _shared;
  NetWorkClient._internal() {
    if (_dio == null) {
        BaseOptions options = BaseOptions();
        options.baseUrl = kBaseURL;
        options.receiveTimeout = 1000 * 10; //10秒
        options.connectTimeout = 1000 * 10;
        _dio = Dio(options);
    }
  }
  static NetWorkClient _getInstance() {
    _shared ??= NetWorkClient._internal();
    return _shared!;
  }

  Stream _get({required String path, Map<String, dynamic>? param}) async* {
    try {
      print('HTTP get,path:$kBaseURL$path param:$param');
      if (param != null) {
        yield await _dio!.get(path, queryParameters: param);
      } else {
        yield await _dio!.get(path);
      }
    } catch (e) {
      print('HTTP GET error:$e');
      yield e;
    }
  }

  Stream _post({required String path, Map<String, Object>? param}) async* {
      try {
        if (param != null) {
          yield await _dio!.post(path, data: param);
        } else {
          yield await _dio!.post(path);
        }
      } catch (e) {
        yield e;
      }
  }

  /// 获取首页html数据
  fetchIndexHTML({String? tab}) async* {
    Map<String, Object>? param = tab != null ? {'tab' : tab} : null;
    yield* _get(path:'', param: param).map((data){
      String htmlStr = (data as Response).data.toString();
      return IndexData.fromHTML(htmlStr);
    });
  }

  // /// 获取最新帖子
  // fetchLatestTopics() async* {
  //   yield* _get(path:kAPILatestTopcis).map((data){
  //     Response resp = data;
  //     return (resp.data as List).map((d){
  //       return TopicsItemViewModel(Topics.fromJson(d));
  //     }).toList();
  //   });
  // }

  // /// 获取热门帖子
  // fetchHotTopics() async* {
  //   yield* _get(path:kAPIHotTopcis).map((data){
  //     Response resp = data;
  //     return (resp.data as List).map((d){
  //       return TopicsItemViewModel(Topics.fromJson(d));
  //     }).toList();
  //   });
  // }

  // /// 获取帖子id获取详情数据
  // fetchTopicsDetail(int topicsId) async* {
  //   yield* _get(path: kAPITopicsDetail, param: {'id' : topicsId.toString()}).map((data){
  //     Response resp = data;
  //     return TopicsDetail.fromJson((resp.data as List).first);
  //   });
  // }

  // fetchTopicsDetailHTML(int topicsId, {int page}) async* {
  //   String path = page != null ? '/t/$topicsId?p=$page' : '/t/$topicsId';
  //   print('path:$path');
  //   yield* _get(path: path).map((data){
  //     String htmlStr = (data as Response).data.toString();
  //     List replies = RegExp(r'<div id="r_[\s\S.]+?</table>', multiLine: true).allMatches(htmlStr).map((m){
  //       String replyStr = m.group(0);
  //       return Reply.fromHTML(replyStr);
  //     }).toList();
  //     return replies;
  //   });
  // }

}