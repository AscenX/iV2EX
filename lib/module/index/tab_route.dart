import 'package:flutter/material.dart';
import '../../common/widget/base_route.dart';
import './index_route.dart';

class TabRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseRoute(child: IndexRoute());
  }
}