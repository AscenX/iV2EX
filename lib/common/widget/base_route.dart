import 'package:flutter/material.dart';

class BaseRoute extends StatelessWidget {

  final Widget child;

  BaseRoute({Key? key, required this.child}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      color: themeData.primaryColor,
      child: child,
    );
  }
}