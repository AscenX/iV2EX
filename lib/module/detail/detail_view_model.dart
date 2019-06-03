import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';
import './detail_route.dart';
import '../../common/network/network_client.dart';
import './topics_detail.dart';
import './reply_item_view_model.dart';

abstract class DetailViewModel extends State<DetailRoute> {

  String title;
  String time;
  String userName;
  String url;
  String avatarURL;
  String node;
  String lastReply;
  int replyCount;
  String content;

  List replies;


  @override
  initState(){
    super.initState();

    title = widget.topicsVm.title;
    time = widget.topicsVm.time;
    userName = widget.topicsVm.userName;
    url = widget.topicsVm.url;
    avatarURL = widget.topicsVm.avatarURL;
    node = widget.topicsVm.node;
    lastReply = widget.topicsVm.lastReply;
    replyCount = widget.topicsVm.replyCount;
    content = '<html><head></head><body><div>loading...</div></body></html>';

    replies = [];

  }

  
  PublishSubject _topicsDetailSubject;
  PublishSubject get topicsDetailSubject {
    if (_topicsDetailSubject == null) {
      _topicsDetailSubject = PublishSubject();
    }
    return _topicsDetailSubject;
  }

  final comments = List();

  fetchTopicsDetailHtml(){
    Observable(NetWorkClient.shared.fetchTopicsDetailHTML(widget.topicsVm.topicsId)).listen((d){
      replies = (d as List).map((d) => ReplyItemViewModel(d)).toList();

      _topicsDetailSubject.add(1);
      _topicsDetailSubject.publish();
    });
  }

  fetchTopicsDetailInfo(){
    Observable(NetWorkClient.shared.fetchTopicsDetail(widget.topicsVm.topicsId)).listen((d){
      TopicsDetail detail = d;
      title = detail.title;
      time = timestamp2Str(detail.created);
      userName = detail.userName;
      url = detail.url;
      avatarURL = detail.avatarURL.replaceRange(0, 2, 'https://');
      node = detail.nodeTitle;
      lastReply = detail.lastReply;
      replyCount = detail.replyCount;
      // content = '<html><head><style>ul {margin: 45px 0 15px 20px;padding: 0;}</style></head><body><div class=\'cell\'>${detail.content}</div></body></html>';
      content = detail.content;

      _topicsDetailSubject.add(1);
      _topicsDetailSubject.publish();
    });
  }

  String timestamp2Str(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('yyyy-mm-dddd hh:MM');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inHours < 1) {
      time = (diff.inMinutes).toString() + '分钟前';
    } else if (diff.inDays < 1) {
      int min = diff.inMinutes % 60 == 0 ? 0 : diff.inMinutes - diff.inHours * 60;
      var minStr = min > 0 ? min.toString() + '分钟前' : '';
      time = min > 0 ? diff.inHours.toString() + '小时' + minStr : diff.inHours.toString() + '小时前';
    } else if (diff.inDays == 1) {
      time = diff.inDays.toString() + '天前';
    } else {
      time = format.format(date);
    }
    return time;
  }

}
