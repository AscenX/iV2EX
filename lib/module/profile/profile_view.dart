import 'package:flutter/material.dart';
import './profile_view_model.dart';
import 'dart:math' as math;


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class ProfileView extends ProfileViewModel {

  final _controller = ScrollController();

  bool showTitle = false;

  bool _isShow = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener((){
        double offset = _controller.offset;

        if (offset > 244) {
          showTitle = true;
          if (_isShow == false) {
            setState(() {  
            }); 
            _isShow = true;
          }
          _isShow = true;
        } else {
          showTitle = false;
          if (_isShow ==true) {
            setState(() {
            });
            _isShow =false;
          }
          _isShow =false;
        }
      });

  }

  List buildTextViews(int count) {
    List<Widget> strings = List();
    for (int i = 0; i < count; i++) {
      strings.add(Padding(padding: EdgeInsets.all(16.0),
          child: Text("Item number " + i.toString(),
              style: TextStyle(fontSize: 20.0))));
    }
    return strings;
  }
    
  @override
  Widget build(BuildContext context) {

    // 头像
    final iconWidget = Hero(
      tag: 'icon',
      child: Container(
              width: 64.0,
              height: 64.0,
              // padding: EdgeInsets.only(left: 4.0, right: 8.0, top: 6.0, bottom: 6.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child:Image.asset('images/stan.png'),
              ),
            )
    );

    final infoWidget = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('AscenZ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          Text('life\'s a struggle'),
          Text('iOS Dev'),
          Text('V2EX 第 165141 号会员'),
          Text('加入于 2016-03-28 10:59:26 +08:00'),
          Text('今日活跃度排名 4122'),
        ],
    ),
    );


    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
            SliverAppBar(
              title: Text(showTitle ? 'Ascen' : ''),
              expandedHeight: 250.0,
              pinned: true,
              centerTitle: true,
              backgroundColor: Colors.blue,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                // title: Text('Ascen'),
                background: SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(top: 72.0, left: 15.0, right: 15.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            iconWidget,
                            Container(width: 15,),
                            infoWidget
                          ],
                        ),
                      ),
                )
              )
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                minHeight: 44.0, 
                maxHeight: 44.0, 
                child: Container(
                  padding: EdgeInsets.only(left: 15.0),
                  color: Colors.grey[300], 
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('全部主题'),
                  )
                  )
                ),
              pinned: true,
              floating: false,
            ),

            SliverList(
                delegate: SliverChildListDelegate(buildTextViews(50)))
        ],
        controller: _controller,
      )
    );
  }
}
