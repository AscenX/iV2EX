
class Topics {

  final int topicsId;
  final String title;
  final int time;
  final String timeStr;
  final String userName;
  final String url;
  final String avatarURL;
  final String node;
  final String lastReply;
  final int lastReplyTime;
  final String lastReplyTimeStr;
  final int replyCount;

  Topics(
    this.topicsId,
    this.title, 
    this.userName, 
    this.url, 
    this.avatarURL, 
    this.node,
    this.lastReply,  
    this.replyCount,
    {this.time,
    this.timeStr,
    this.lastReplyTimeStr,
    this.lastReplyTime}
    );

  factory Topics.fromJson(Map<String, Object> json) {
    return Topics(
      json['id'] as int,
      json['title'] as String,
      (json['member'] as Map<String, Object>)['username'] as String,
      json['url'] as String,
      (json['member'] as Map<String, Object>)['avatar_large'] as String,
      (json['node'] as Map<String, Object>)['title'] as String,
      json['last_reply_by'] as String,
      json['replies'] as int,
      time: json['created'] as int,
      lastReplyTime:json['last_touched'] as int,
    );
  }
}