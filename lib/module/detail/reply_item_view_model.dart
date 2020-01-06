import './reply.dart';
import '../../common/network/api.dart';

class ReplyItemViewModel {

  String get username => _reply.username;
  String get timeNsource => _reply.timeNsource;
  String get avatarURL {
    if (_reply.avatarURL.startsWith('http')) {
      return _reply.avatarURL;
    }
   return _reply.avatarURL.replaceRange(0, 0, 'https://');
  }
  String get content {

    // [user](userLink)

    List userStrs = RegExp(r'@<a href=".+?</a>').allMatches(_reply.content).map((m){ return m.group(0);}).toList();

    List userAts = RegExp(r'@<a href=".+?">').allMatches(_reply.content).map((m){
      String userStr = m.group(0);
      String userLink = userStr.substring(10, userStr.length - 2);
      String user = userLink.split("/").last;
      return '[@'+user+']('+ "https://www.v2ex.com" + userLink+')';
    }).toList();

    String content = _reply.content;
    for(int i = 0; i < userStrs.length; ++i) {
      String userStr = userStrs[i];
      int start = content.indexOf(userStr);
      String userAt = userAts[i];
      content = content.replaceRange(start, start+userStr.length, userAt);
    }

     return content;
  }
  bool get isLike => _reply.isLike;
  int get likeCount => _reply.likeCount;

  final Reply _reply;

  ReplyItemViewModel(this._reply);  
    
}