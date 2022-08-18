

import 'package:flutter/material.dart';
import './index_view_model.dart';
import 'topics_item.dart';
import '../../common/widget/base_route.dart';
import 'package:rxdart/rxdart.dart';

class IndexView extends IndexViewModel with TickerProviderStateMixin {

  late TabController _tabController;

  late var _refreshSub;

  final _scrollController = ScrollController();

  int _preIndex = 0;
  int _index = 0;

  @override
  void initState() {

    super.initState();

    _tabController = TabController(
      vsync: this,
      length: tabs.length
    )..addListener(() {
      if (_preIndex == _tabController.previousIndex &&
          _index == _tabController.index) return;
      fetchTopcis(_tabController.index);
      _preIndex = _tabController.previousIndex;
      _index = _tabController.index;
    });

    _refreshSub = refreshTopcisSubject.listen((d){
      setState(() {
      });
    });
    
    fetchTopcis(0);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(414, 44),
          child: Container(
            color: themeData.primaryColor,
            alignment: Alignment.bottomCenter,
            child: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              controller: _tabController,
              isScrollable: true,
              tabs: buildTabs(tabs)
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: setupTabbarView()
        ),
        floatingActionButton: Hero(
          tag: 'icon',
          child: GestureDetector(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(22.0),
                child: SizedBox(
                  width: 44.0,
                  height: 44.0,
                  child: Image.asset('images/stan.png'),
                ),
            ),
            onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return BaseRoute(child: Container());
                }
              ));
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      );
  }

  // 创建Tab
  List<Tab> buildTabs(List tabs) {
    return tabs.map((tab) => Tab(text: tab,)).toList();
  }

  List<Widget> setupTabbarView(){
    List<Widget> tabbarViews = <Widget>[];
    for (int i = 0; i < tabs.length; ++i) {
      List topicses = i < topicsList.length  ? topicsList[i]: [];
      Widget tabbarView = Container();
      if (topicses.isNotEmpty) {
         tabbarView = buildTabbarView(topicsList[i], (){
           fetchTopcis(i);
           });
      }
      tabbarViews.add(tabbarView);
    }
    return tabbarViews;
  }


  // 创建列表
  RefreshIndicator buildTabbarView(List dataSource, Function() callBack) {
    return RefreshIndicator(
      onRefresh: ()=>Future.sync(callBack),
      backgroundColor: Colors.white,
      color: Colors.grey[300],
      child: ListView.separated(
                  itemCount: dataSource.length,
                  itemBuilder: ((ctx,index){
                    return GestureDetector(
                      child: TopicsItem(dataSource[index]),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            // return BaseRoute(child: DetailRoute(topicsVm:dataSource[index]));
                            return BaseRoute(child: Container());
                          }
                        ));
                      }
                    );
                  }),
                  separatorBuilder: ((ctx,index){
                    return const Divider(color: Colors.grey, height: 1.0, indent: 8.0,);
                  }),
                  controller: _scrollController,
                ),
    );
  }

}