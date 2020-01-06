
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BaseScaffold extends StatelessWidget {

  final Widget child;
  final bool showNavBar;
  final bool showBackBtn;
  final String title;
  final Color tintColor;
  final Widget rightBarItem;
  final Color navBarColor;

  BaseScaffold({Key key,
    @required this.child,
    this.showNavBar = true,
    this.showBackBtn = true,
    this.title,
    this.tintColor,
    this.rightBarItem,
    this.navBarColor}): super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return CupertinoPageScaffold(
      navigationBar: showNavBar ? CupertinoNavigationBar(
        backgroundColor: navBarColor,
        middle: title != null ? Text(title, style: TextStyle(color: tintColor),) : null,
        leading: showBackBtn ? Container(
          width: 45.0,
          child: FlatButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Icon(CupertinoIcons.back, color: tintColor,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ) : null,
        trailing: rightBarItem,
        padding: EdgeInsetsDirectional.only(start: 5.0, end: 15.0),
      ) : null,
      child: child
      );
  }
}