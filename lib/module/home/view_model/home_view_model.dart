import 'package:flutter/cupertino.dart';
import 'package:iv2ex/common/network/api.dart';
import 'package:iv2ex/common/network/networking.dart';
import 'package:iv2ex/common/service/home_service.dart';
import 'package:iv2ex/module/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rx_command/rx_command.dart';

import './topic_item_view_model.dart';
import 'package:iv2ex/module/home/model/index_data.dart';

class HomeViewModel extends BaseViewModel {

  List<String> tabs;
  List tabData;
  List tabNodes;
  List<List> topicsList = List.generate(13, (i)=> List());
  
  List<String> nodeName;

  RxCommand<int, int> refreshCmd;
  List<TopicItemViewModel> latestTopics;
  List<TopicItemViewModel> hotTopics;

  HomeViewModel() {

    tabs = ['V2EX', '最新', '最热', '技术', '创意', '好玩', 'Apple', '酷工作', '交易', '城市', '问与答', '全部', 'R2'];

    refreshCmd = RxCommand.createFromStream((tab) {
      if (tab == 0) {
        return HomeService.fetchIndexHTML().doOnData( (data) {
          IndexData indexData = data;
          tabs = ['V2EX', '最新', '最热'];
          tabData = indexData.tabs;
          tabs.addAll(indexData.tabs.map((d) => d.values.first));

          topicsList[tab] = indexData.topics.map((d)=> TopicItemViewModel(d)).toList();
        }).map((data) => (data as IndexData).topics.length );
      } else if (tab == 1) {
        return HomeService.fetchLatestTopics().doOnData((data) {
          topicsList[tab] = data as List;
        }).map((data) => (data as List).length );
      } else if (tab == 2) {
        return HomeService.fetchHottestTopics().doOnData((data) {
          topicsList[tab] = data as List;
        }).map((data) => (data as List).length );
      } else if (tab >= 3) {
//        Map tabMap = tabData[tab - 3];
        return HomeService.fetchIndexHTML(tab: tab).doOnData((data){
          IndexData indexData = data;
          topicsList[tab] = indexData.topics.map((d)=> TopicItemViewModel(d)).toList();
        }).map((data) => (data as IndexData).topics.length );
      }
      return Observable.empty();
    });

  }



}