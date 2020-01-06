import 'package:flutter/material.dart';
import './detail_view.dart';
import '../home/view_model/topic_item_view_model.dart';

class DetailRoute extends StatefulWidget {

  final TopicItemViewModel topicsVm;

  DetailRoute({this.topicsVm});
  
  @override
  DetailView createState() => new DetailView();
}
  
