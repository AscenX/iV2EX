import './topics.dart';
import 'package:intl/intl.dart';



class TopicsItemViewModel {

  int get topicsId => _topics.topicsId;
  String get title => _topics.title;
  String get time {
    if (_topics.timeStr != null) {
      return _topics.timeStr ?? '';
    }
    return _topics.replyCount > 0 ? timestamp2Str(_topics.lastReplyTime) : timestamp2Str(_topics.time);
  }
  String get userName => _topics.userName;
  String get url => _topics.url;
  String get avatarURL {
    if (_topics.avatarURL.startsWith('http')) {
      return _topics.avatarURL;
    }
   return _topics.avatarURL.replaceRange(0, 2, 'https://');
  }
  String get node => _topics.node;
  String get lastReply => _topics.lastReply;
  int get replyCount => _topics.replyCount;

  final Topics _topics;

  TopicsItemViewModel(this._topics);  

  String timestamp2Str(int? timestamp) {
    if (timestamp == null || timestamp.isNaN) return '';
    var now = DateTime.now();
    var format = DateFormat('yyyy-mm-dddd hh:MM');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inHours < 1) {
      time = '${diff.inMinutes}分钟前';
    } else if (diff.inDays < 1) {
      int min = diff.inMinutes % 60 == 0 ? 0 : diff.inMinutes - diff.inHours * 60;
      var minStr = min > 0 ? '$min分钟前' : '';
      time = min > 0 ? '${diff.inHours}小时$minStr' : '${diff.inHours}小时前';
    } else if (diff.inDays == 1) {
      time = '${diff.inDays}天前';
    } else {
      time = format.format(date);
    }
    return time;
  }

}