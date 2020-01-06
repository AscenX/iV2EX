import 'package:flutter/material.dart';
import 'package:iv2ex/module/home/view_model/home_view_model.dart';
import 'package:iv2ex/module/home/widget/topic_item.dart';
import 'package:iv2ex/module/profile/profile_route.dart';
import 'package:iv2ex/module/detail/detail_route.dart';
import 'package:iv2ex/common/extension/image_ext.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with TickerProviderStateMixin {

  HomeViewModel _viewModel;

  TabController _tabContrlller;
  var _refreshSub;

  int _preIndex;
  int _index;

  final _scrollController = ScrollController();

  @override
  void initState() {

    super.initState();

    _viewModel = HomeViewModel();

    _tabContrlller = TabController(
      vsync: this,
      length: _viewModel.tabs.length,
    )..addListener((){
      if (_preIndex == _tabContrlller.previousIndex &&
          _index == _tabContrlller.index) return;
      _viewModel.fetchTopcis(_tabContrlller.index);
      _preIndex = _tabContrlller.previousIndex;
      _index = _tabContrlller.index;
    });

    _refreshSub = _viewModel.refreshTopicsSubject.listen((d){
      setState(() {
      });
    });

    _viewModel.fetchTopcis(0);
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
              child: TopicItem(dataSource[index]),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return DetailRoute(topicsVm:dataSource[index]);
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
    for (int i = 0; i < _viewModel.tabs.length; ++i) {
      List topicses = i < _viewModel.topicsList.length  ? _viewModel.topicsList[i]: null;
      Widget tabbarView = Container();
      if (topicses.length > 0) {
        tabbarView = buildTabbarView(_viewModel.topicsList[i], (){
          _viewModel.fetchTopcis(i);
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
              tabs: buildTabs(_viewModel.tabs)
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
                  return ProfileRoute();
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
