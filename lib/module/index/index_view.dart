import 'package:flutter/material.dart';
import 'package:iv2ex/common/extension/image_ext.dart';
import './index_view_model.dart';
import './topic_item.dart';

import '../detail/detail_route.dart';
import '../../common/widget/base_route.dart';
import '../profile/profile_route.dart';

class IndexView extends IndexViewModel with TickerProviderStateMixin {

  TabController _tabContrlller;
  var _refreshSub;

  int _preIndex;
  int _index;

  final _scrollController = ScrollController();

  @override
  void initState() {

    super.initState();

    _tabContrlller = TabController(
      vsync: this,
      length: tabs.length,
    )..addListener((){
      if (_preIndex == _tabContrlller.previousIndex &&
          _index == _tabContrlller.index) return;
      fetchTopcis(_tabContrlller.index);
      _preIndex = _tabContrlller.previousIndex;
      _index = _tabContrlller.index;
    });

    _refreshSub = refreshTopicsSubject.listen((d){
      setState(() {
      });
    });
    
    fetchTopcis(0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabContrlller.dispose();
    _refreshSub.cancel();
  }

  // 创建Tab
  List<Tab> buildTabs(List tabs) {
     return tabs.map((tab) => Tab(text:tab)).toList();
  }

  // 创建列表
  RefreshIndicator buildTabbarView(List dataSource, Function() callBack) {
    return RefreshIndicator(
      onRefresh: ()=>Future.sync(callBack),
      backgroundColor: Colors.white,
      color: Colors.grey[300],
      child: ListView.separated(
                  itemCount: dataSource != null ? dataSource.length : 0,
                  itemBuilder: ((ctx,index){
                    return GestureDetector(
                      child: TopicsItem(dataSource[index]),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return BaseRoute(child: DetailRoute(topicsVm:dataSource[index]));
                          }
                        ));
                      }
                    );
                  }),
                  separatorBuilder: ((ctx,index){
                    return Divider(color: Colors.grey, height: 1.0, indent: 8.0,);
                  }),
                  controller: _scrollController,
                ),
    );
  }

  List<Widget> setupTabbarView(){
    List<Widget> tabbarViews = List();
    for (int i = 0; i < tabs.length; ++i) {
      List topicses = i < topicsList.length  ? topicsList[i]: null;
      Widget tabbarView = Container();
      if (topicses.length > 0) {
         tabbarView = buildTabbarView(topicsList[i], (){
           fetchTopcis(i);
           });
      }
      tabbarViews.add(tabbarView);
    }
    return tabbarViews;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(414, 44),
          child: Container(
            color: themeData.primaryColor,
            alignment: Alignment.bottomCenter,
            child: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              controller: _tabContrlller,
              isScrollable: true,
              tabs: buildTabs(tabs)
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabContrlller,
          children: setupTabbarView()
        ),
        floatingActionButton: Hero(
          child: GestureDetector(
            child: ClipRRect(
                child: Container(
                  width: 44.0,
                  height: 44.0,
                  child: ImageAssets.stan(),
                ),
                borderRadius: BorderRadius.circular(22.0),
            ),
            onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return BaseRoute(child: ProfileRoute());
                }
              ));
            },
          ),
          tag: 'icon',
        ),
        //   ),
        //   heroTag: 'icon',
        //   onPressed: (){
        //     Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (BuildContext context) {
        //                     return BaseRoute(child: ProfileRoute());
        //                   }
        //                 ));
        //   },
        //   elevation: 0.0,
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      );
  }
}