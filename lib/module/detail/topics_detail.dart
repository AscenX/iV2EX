import './reply.dart';

class TopicsDetail {
  int topicsId;
  String nodeTitle;
  String nodeName;
  String avatarURL;
  String title;
  int created;
  String timeStr;

  String userName;
  int userId;
  String url;
  String lastReply;
  int lastReplyTime;
  String lastReplyTimeStr;
  int replyCount;

  /// markdown content
  String content;

  TopicsDetail(
    this.topicsId, 
    this.nodeTitle, 
    this.nodeName, 
    this.avatarURL, 
    this.title, 
    this.created,
    this.userName,
    this.userId,
    this.url,
    this.lastReply,
    this.lastReplyTime,
    this.replyCount,
    this.content,
    {this.lastReplyTimeStr,
    this.timeStr}
    );

  factory TopicsDetail.fromJson(dynamic json) {
    return TopicsDetail(
      json['id'] as int,
      (json['node'] as Map<String, Object>)['title'] as String,
      (json['node'] as Map<String, Object>)['name'] as String,
      (json['member'] as Map<String, Object>)['avatar_large'] as String,
      json['title'] as String,
      json['created'] as int,
      (json['member'] as Map<String, Object>)['username'] as String,
      (json['member'] as Map<String, Object>)['id'] as int,
      json['url'] as String,
      json['last_reply_by'] as String,
      json['last_touched'] as int,
      json['replies'] as int,
      json['content'] as String,
    );
  }

}
