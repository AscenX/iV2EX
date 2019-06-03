import 'package:flutter/material.dart';
import './index_route.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/network/network_client.dart';
import './topics_item_view_model.dart';
import './index_data.dart';

class IndexViewModel extends State<IndexRoute> {

  List<String> tabs;
  List tabData;
  List tabNodes;
  List<List> topicsList = List.generate(13, (i)=> List());
  
  List<String> nodeName;

  PublishSubject refreshTopcisSubject;
  List<TopicsItemViewModel> lastestTopicses;
  List<TopicsItemViewModel> hotTopicses;

  @override
  void initState() {
    super.initState();

    refreshTopcisSubject = PublishSubject();

    tabs = ['V2EX', '最新', '最热', '技术', '创意', '好玩', 'Apple', '酷工作', '交易', '城市', '问与答', '全部', 'R2'];
  }

  fetchTopcis(int tab) {
    if (tab == 0) {
      Observable(NetWorkClient.shared.fetchIndexHTML()).listen((data){
        IndexData indexData = data;
        tabs = ['V2EX', '最新', '最热'];
        tabData = indexData.tabs;
        tabs.addAll(indexData.tabs.map((d) => d.values.first));

        topicsList[tab] = indexData.topicses.map((d)=> TopicsItemViewModel(d)).toList();
        refreshTopcisSubject.add(tab);
        refreshTopcisSubject.publish();
      });
    } else if (tab == 1) {
      Observable(NetWorkClient.shared.fetchLatestTopics()).listen((data){
        topicsList[tab] = data as List;
        refreshTopcisSubject.add(tab);
        refreshTopcisSubject.publish();
      });
    } else if (tab == 2) {
      Observable(NetWorkClient.shared.fetchHotTopics()).listen((data){
        topicsList[tab] = data as List;
        refreshTopcisSubject.add(tab);
        refreshTopcisSubject.publish();
      });
    } else if (tab >= 3) {
      Map tabMap = tabData[tab - 3];
      Observable(NetWorkClient.shared.fetchIndexHTML(tab: tabMap.keys.first)).listen((data){
        IndexData indexData = data;
        topicsList[tab] = indexData.topicses.map((d)=> TopicsItemViewModel(d)).toList();
        refreshTopcisSubject.add(tab);
        refreshTopcisSubject.publish();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}