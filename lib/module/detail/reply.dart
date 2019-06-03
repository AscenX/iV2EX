
class Reply {
  String username;
  String timeNsource;
  String avatarURL;
  int likeCount;
  String content;
  bool isLike;

  Reply(this.username, this.timeNsource, this.avatarURL, this.content, this.likeCount, this.isLike);

  factory Reply.fromHTML(String htmlStr){
    
    String usernameStr = RegExp(r'class="dark">.+?</a>').stringMatch(htmlStr);
    String username = usernameStr.substring(13, usernameStr.length - 4);

    String timeNsourceStr = RegExp(r'"ago">.+?</span>').stringMatch(htmlStr);
    String timeNsource = timeNsourceStr.substring(7, timeNsourceStr.length - 7);

    String contentStr = RegExp(r'content">.+?</div>').stringMatch(htmlStr);
    String content = contentStr.substring(9, contentStr.length - 6);

    String avatarURLStr = RegExp(r'src=".+?"').stringMatch(htmlStr);
    String avatarURL = avatarURLStr.substring(7, avatarURLStr.length - 1);


    String likeCountStr = RegExp(r'fade">.+?</span>').stringMatch(htmlStr);
    int like = 0;
    if (likeCountStr != null) {
      String likeCount = likeCountStr.substring(8, likeCountStr.length - 7);
      like = int.parse(likeCount);
    }

    bool isLike = htmlStr.contains('已感谢', 0);

    return Reply(username, timeNsource, avatarURL, content, like, isLike);
  }

}