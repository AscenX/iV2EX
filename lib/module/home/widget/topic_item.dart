import 'package:flutter/material.dart';
import 'package:iv2ex/module/home/view_model/topic_item_view_model.dart';

/// 使用TopicsItemViewModel来初始化并赋值
class TopicItem extends StatelessWidget {

  final TopicItemViewModel _vm;

  TopicItem(this._vm);

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

    // 节点
    final nodeWidget = ClipRRect(
            borderRadius: BorderRadius.circular(2.0),
            child: Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              color: Color(0xfff5f5f5),
              child: Text('${_vm.node}', style: TextStyle(color: Color(0xffa6a6a6), fontSize: 12.0)),
              ),
          );

    // 标题和其他信息
    final contentWidget = Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 30.0),
                    child: Text(_vm.title,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff333333),
                        // fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      nodeWidget,
                      Container(width: 4.0),
                      Text('${_vm.userName} ', style: TextStyle(color: Color(0xff778087), fontSize: 12.0)),
                      Text('${_vm.time} ', style: TextStyle(color: Color(0xffd0d0d0), fontSize: 12.0)),
                      _vm.lastReply.length > 0 ? Text(_vm.lastReply, style: TextStyle(color: Color(0xff778087), fontSize: 12.0)) : Container()
                    ],
                  )
                ],
              ),
            ),
          );

    // 回复数量
    final replyCountWidget = Container(
      padding: EdgeInsets.only(top: 6.0 + 10.0, left: 5.0),
      child: _vm.replyCount > 0 ? ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              height: 18.0,
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0),
              color: Color(0xffaab0c5),
              child: Text(_vm.replyCount.toString(), style: TextStyle(color: Colors.white, fontSize: 10.0)),
              ),
          ) : null,
    );

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          iconWidget,
          contentWidget,
          replyCountWidget,
        ],
      )
    );
  }
}