import './reply.dart';

class ReplyItemViewModel {

  String get username => _reply.username;
  String get timeNsource => _reply.timeNsource;
  String get avatarURL {
    if (_reply.avatarURL.startsWith('http')) {
      return _reply.avatarURL;
    }
   return _reply.avatarURL.replaceRange(0, 0, 'https://');
  }
  String get content => _reply.content;
  bool get isLike => _reply.isLike;
  int get likeCount => _reply.likeCount;

  final Reply _reply;

  ReplyItemViewModel(this._reply);  
    
}