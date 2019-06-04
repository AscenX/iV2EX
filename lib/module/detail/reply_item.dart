import 'package:flutter/material.dart';
import './reply_item_view_model.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ReplyItem extends StatelessWidget {
  final ReplyItemViewModel _vm;

  ReplyItem(this._vm);

  @override
  Widget build(BuildContext context) {

        // 头像
    final iconWidget = Container(
              width: 56.0,
              height: 56.0,
              padding: EdgeInsets.only(left: 4.0, right: 8.0, top: 6.0, bottom: 6.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child:Image.network(
                    _vm.avatarURL, 
                    width: 44.0, 
                    scale: 1.0, 
                    fit: BoxFit.fill,
                  ),
              ),
            );

    final contentWidget = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(_vm.username),
              Text(_vm.timeNsource)
            ],
          ),
          Container(
              padding: EdgeInsets.only(right: 10),
              child: MarkdownBody(data: _vm.content),
          ),
        ],
      ),
    );
    
    return Container(
      child: Row(
        children: <Widget>[
          iconWidget,
          contentWidget,
        ],
      ),
    );
  }
}