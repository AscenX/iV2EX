import 'package:flutter/material.dart';
//import 'package:iv2ex/module/base/tab_bar_route.dart';
import 'package:iv2ex/module/home/route/tab_route.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iV2ex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabRoute()
    );
  }
}
