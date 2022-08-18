import 'package:flutter/material.dart';
import './module/index/tab_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iV2ex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabRoute()
    );
  }
}
