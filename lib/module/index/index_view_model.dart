import 'package:flutter/material.dart';
import './index_route.dart';
import '../../common/network/network_client.dart';
import './index_data.dart';
import 'topics_item_view_model.dart';
import 'package:rxdart/rxdart.dart';


class IndexViewModel extends State<IndexRoute> {

  List<String> tabs = <String>[];
  List<Map<String, String>> tabData = <Map<String, String>>[];
  List<List> topicsList = <List>[];

  List<String> nodeName = <String>[];

  late PublishSubject refreshTopcisSubject;
  List<TopicsItemViewModel> lastestTopicses = <TopicsItemViewModel>[];
  List<TopicsItemViewModel> hotTopicses = <TopicsItemViewModel>[];

  @override
  void initState() {
    super.initState();

    refreshTopcisSubject = PublishSubject();

    tabs = ['V2EX', '最新', '最热', '技术', '创意', '好玩', 'Apple', '酷工作', '交易', '城市', '问与答', '全部', 'R2'];
  }

  @override
  Widget build(BuildContext context) {
    return widget;
  }

  fetchTopcis(int tab) {
    if (tab == 0) {


      NetWorkClient.shared.fetchIndexHTML().listen((data) {
        IndexData indexData = data;
        tabs = ['V2EX', '最新', '最热'];
        tabData = indexData.tabs;
        tabs.addAll(indexData.tabs.map((d) => d.values.first));

        // topicsList[tab] = indexData.topicses.map((d)=> TopicsItemViewModel(d)).toList();
        topicsList[tab] = indexData.topicses.map((d) {
          TopicsItemViewModel vm = TopicsItemViewModel(d);
          return vm;
        }).toList();
        refreshTopcisSubject.add(tab);
        refreshTopcisSubject.publish();
      });

      // Observable(NetWorkClient.shared.fetchIndexHTML()).listen((data){
        // IndexData indexData = data;
        // tabs = ['V2EX', '最新', '最热'];
        // tabData = indexData.tabs;
        // tabs.addAll(indexData.tabs.map((d) => d.values.first));

        // topicsList[tab] = indexData.topicses.map((d)=> TopicsItemViewModel(d)).toList();
        // refreshTopcisSubject.add(tab);
        // refreshTopcisSubject.publish();
      // });
      
    } 
    // else if (tab == 1) {
    //   Observable(NetWorkClient.shared.fetchLatestTopics()).listen((data){
    //     topicsList[tab] = data as List;
    //     refreshTopcisSubject.add(tab);
    //     refreshTopcisSubject.publish();
    //   });
    // } else if (tab == 2) {
    //   Observable(NetWorkClient.shared.fetchHotTopics()).listen((data){
    //     topicsList[tab] = data as List;
    //     refreshTopcisSubject.add(tab);
    //     refreshTopcisSubject.publish();
    //   });
    // } else if (tab >= 3) {
    //   Map tabMap = tabData[tab - 3];
    //   Observable(NetWorkClient.shared.fetchIndexHTML(tab: tabMap.keys.first)).listen((data){
    //     IndexData indexData = data;
    //     topicsList[tab] = indexData.topicses.map((d)=> TopicsItemViewModel(d)).toList();
    //     refreshTopcisSubject.add(tab);
    //     refreshTopcisSubject.publish();
    //   });
    // }
  }
}