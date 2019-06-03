import 'package:flutter/material.dart';
import './detail_view_model.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import './reply_item.dart';
  
class DetailView extends DetailViewModel {

  @override
  void initState() {
    super.initState();

    topicsDetailSubject.listen((d){
      print('content:$content');
      setState(() {
      });
    });

    fetchTopicsDetailInfo();
    fetchTopicsDetailHtml();
  }
    
  @override
  Widget build(BuildContext context) {

    // 头像
    final iconWidget = Container(
              width: 48.0,
              height: 48.0,
              padding: EdgeInsets.only(left: 4.0, right: 8.0, top: 6.0, bottom: 6.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child:Image.network(
                    avatarURL, 
                    width: 36.0, 
                    scale: 1.0, 
                    fit: BoxFit.fill,
                  ),
              ),
            );

    final contentViewWidget = Container(
          color: Color(0xfff5f5f5),
          padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
          child: Container(
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                    child: Text(title, style: TextStyle(fontSize: 18.0, color: Color(0xff333333),)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                    child: Row(
                      children: <Widget>[
                        iconWidget,
                        Text(userName, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                        Container(width: 8.0,),
                        Text(time),
                        Container(width: 8.0,),
                        Text('123次点击')
                      ],
                    ),
                  ),
                  Container(width: 414.0, height: 3.0, color: Color(0xfff5f5f5),),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: MarkdownBody(data: content),
                  ),
                ],
              ),
          ),
      );

    return Scaffold(
      appBar: AppBar(title: Text(title), elevation: 0.0,),
      body: ListView.separated(
        itemCount: replies.length + 1,
        itemBuilder: (ctx, index){
          if (index == 0){
            return contentViewWidget;
          } else {
            return ReplyItem(replies[index-1]);
          }
        },
        separatorBuilder: (ctx, index) {
          return Divider(color: Colors.grey, height: 1.0, indent: 8.0,);
        },
      )
    );
  }
}

