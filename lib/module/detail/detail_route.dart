import 'package:flutter/material.dart';
import './detail_view.dart';
import '../index/topic_item_view_model.dart';

class DetailRoute extends StatefulWidget {

  final TopicsItemViewModel topicsVm;

  DetailRoute({this.topicsVm});
  
  @override
  DetailView createState() => new DetailView();
}
  
