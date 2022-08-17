import 'package:flutter/material.dart';
import '../../common/widget/base_route.dart';
import './index_route.dart';

class TabRoute extends StatelessWidget {
  const TabRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseRoute(child: const IndexRoute());
  }
}