import './topic.dart';
import 'package:intl/intl.dart';



class TopicsItemViewModel {

  int get topicsId => _topic.topicId;
  String get title => _topic.title;
  String get time {
    if (_topic.timeStr != null) {
      return _topic.timeStr;
    }
    return _topic.replyCount > 0 ? timestamp2Str(_topic.lastReplyTime) : timestamp2Str(_topic.time);
  }
  String get userName => _topic.userName;
  String get url => _topic.url;
  String get avatarURL {
    if (_topic.avatarURL.startsWith('http')) {
      return _topic.avatarURL;
    }
   return _topic.avatarURL.replaceRange(0, 2, 'https://');
  }
  String get node => _topic.node;
  String get lastReply => _topic.lastReply;
  int get replyCount => _topic.replyCount;

  final Topic _topic;

  TopicsItemViewModel(this._topic);

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