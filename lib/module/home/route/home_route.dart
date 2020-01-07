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

  TabController _tabController;

  int _preIndex;
  int _index;

  final _scrollController = ScrollController();

  @override
  void initState() {

    super.initState();

    _viewModel = HomeViewModel();

    _tabController = TabController(
      vsync: this,
      length: _viewModel.tabs.length,
    )..addListener((){
      if (_preIndex == _tabController.previousIndex &&
          _index == _tabController.index) return;
      _viewModel.refreshCmd.execute(_tabController.index);
      _preIndex = _tabController.previousIndex;
      _index = _tabController.index;
    });

    _viewModel.refreshCmd.execute(0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  // 创建Tab
  List<Tab> buildTabs(List tabs) {
    return tabs.map((tab) => Tab(text:tab)).toList();
  }

  // 创建列表
  RefreshIndicator buildTabView(List dataSource, Function() callBack) {
    return RefreshIndicator(
      onRefresh: ()=> Future.sync(callBack),
      backgroundColor: Colors.white,
      color: Colors.grey[300],
      child: StreamBuilder(
        stream: _viewModel.refreshCmd,
        builder: (ctx, data) {
          return ListView.separated(
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
          );
        },
      )
    );
  }

  List<Widget> setupTabView(){
    List<Widget> tabViews = List();
    for (int i = 0; i < _viewModel.tabs.length; ++i) {
      List topics = i < _viewModel.topicsList.length  ? _viewModel.topicsList[i]: null;
      Widget tabView = Container();
      if (topics.length > 0) {
        tabView = buildTabView(_viewModel.topicsList[i], (){
          _viewModel.refreshCmd.execute(i);
        });
      }
      tabViews.add(tabView);
    }
    return tabViews;
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
              controller: _tabController,
              isScrollable: true,
              tabs: buildTabs(_viewModel.tabs)
          ),
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: setupTabView()
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
