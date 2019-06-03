import 'package:flutter/material.dart';

class ScrollViewRefresh extends StatefulWidget {

  final ListView scrollView;

  ScrollViewRefresh(this.scrollView);

  _ScrollViewRefreshState createState() => _ScrollViewRefreshState();
}

class _ScrollViewRefreshState extends State<ScrollViewRefresh> with TickerProviderStateMixin {

  @override
  initState() {
    super.initState();

    if (widget.scrollView.controller != null) {
      widget.scrollView.controller.addListener((){
        print('widget.scrollView.controller:${widget.scrollView.controller.offset}');
      });
    } 
  }

  buildHeader(){
    return Container(
      height: 88.0,
      child: Text('下拉刷新'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: 414.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildHeader(),
          widget.scrollView,
        ],
      ),
    );
  }
}