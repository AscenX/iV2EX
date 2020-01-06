import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iv2ex/common/extension/image_ext.dart';
import '../home/route/home_route.dart';

class TabBarRoute extends StatefulWidget {
  TabBarRoute({Key key}) : super(key: key);

  @override
  _TabBarRouteState createState() => _TabBarRouteState();
}

class _TabBarRouteState extends State<TabBarRoute> {

  Widget bodyRoute(int index) {
    Widget route;
    if (index == 0) {
      route = HomeRoute();
    } else {
      route = Container(color: Colors.blue);
    }
    return route;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
//      tabBar: CupertinoTabBar(
//        activeColor: Color(0xFF6B50F8),
//        inactiveColor: Color(0xFFC5C7D2),
//        items: [
//          BottomNavigationBarItem(
//              icon: ImageAssets.tabHome(color: Color(0xFFC5C7D2)), // 非选中状态
//              activeIcon: ImageAssets.tabHome(), // 选中状态
//              title: Text('首页')
//          ),
//          BottomNavigationBarItem(
//              icon: ImageAssets.tabWallet(color: Color(0xFFC5C7D2)),
//              activeIcon: ImageAssets.tabWallet(),
//              title: Text('钱包')
//          ),
//          BottomNavigationBarItem(
//              icon: ImageAssets.tabExchange(color: Color(0xFFC5C7D2)),
//              activeIcon: ImageAssets.tabExchange(),
//              title: Text('交易')
//          ),
//          BottomNavigationBarItem(
//              icon: ImageAssets.tabCommunity(color: Color(0xFFC5C7D2)),
//              activeIcon: ImageAssets.tabCommunity(),
//              title: Text('社区')
//          ),
//          BottomNavigationBarItem(
//              icon: ImageAssets.tabMine(color: Color(0xFFC5C7D2)),
//              activeIcon: ImageAssets.tabMine(),
//              title: Text('我的')
//          )
//        ],
//      ),
      tabBuilder: (context, index) {
        return bodyRoute(index);
      },

    );
  }

}