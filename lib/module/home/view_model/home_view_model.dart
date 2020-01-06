import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iv2ex/common/network/api.dart';
import 'package:iv2ex/common/network/networking.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rx_command/rx_command.dart';

import 'package:iv2ex/common/network/network_client.dart';
import './topic_item_view_model.dart';
import 'package:iv2ex/module/home/model/index_data.dart';

class HomeViewModel {

  List<String> tabs;
  List tabData;
  List tabNodes;
  List<List> topicsList = List.generate(13, (i)=> List());
  
  List<String> nodeName;

  PublishSubject refreshTopicsSubject;
  RxCommand refreshCmd;
  List<TopicItemViewModel> lastestTopicses;
  List<TopicItemViewModel> hotTopicses;

  HomeViewModel() {

//    refreshCmd = RxCommand.createFromStream<int, int>((input) {
//      return Networking.request(type: APIType.)
//    });

    tabs = ['V2EX', '最新', '最热', '技术', '创意', '好玩', 'Apple', '酷工作', '交易', '城市', '问与答', '全部', 'R2'];
  }


  fetchTopcis(int tab) {
    if (tab == 0) {
      Observable(NetWorkClient.shared.fetchIndexHTML()).listen((data){
        IndexData indexData = data;
        tabs = ['V2EX', '最新', '最热'];
        tabData = indexData.tabs;
        tabs.addAll(indexData.tabs.map((d) => d.values.first));

        topicsList[tab] = indexData.topics.map((d)=> TopicItemViewModel(d)).toList();
        refreshTopicsSubject.add(tab);
        refreshTopicsSubject.publish();
      });
    } else if (tab == 1) {
      Observable(NetWorkClient.shared.fetchLatestTopics()).listen((data){
        topicsList[tab] = data as List;
        refreshTopicsSubject.add(tab);
        refreshTopicsSubject.publish();
      });
    } else if (tab == 2) {
      Observable(NetWorkClient.shared.fetchHotTopics()).listen((data){
        topicsList[tab] = data as List;
        refreshTopicsSubject.add(tab);
        refreshTopicsSubject.publish();
      });
    } else if (tab >= 3) {
      Map tabMap = tabData[tab - 3];
      Observable(NetWorkClient.shared.fetchIndexHTML(tab: tabMap.keys.first)).listen((data){
        IndexData indexData = data;
        topicsList[tab] = indexData.topics.map((d)=> TopicItemViewModel(d)).toList();
        refreshTopicsSubject.add(tab);
        refreshTopicsSubject.publish();
      });
    }
  }

}