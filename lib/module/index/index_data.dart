import './topics.dart';

/// 解析V2EX首页的html获取数据
class IndexData {
  final List<Map<String, String>> tabs;
  final List<Map> tabNodes;
  final String onlineCount;
  final String highestOnline;
  final List<Map<String, List>> nodes;
  final List<Topics> topicses;
  final String unreadNotification;
  final String nodeCollectionCount;
  final String topicsCollection;
  final String specialFollow;
  final List<Map> collectedNodes;

  IndexData(this.nodes, this.tabs, this.tabNodes, this.onlineCount, this.highestOnline, this.topicses, this.unreadNotification,
  this.nodeCollectionCount, this.topicsCollection, this.specialFollow, this.collectedNodes);

  factory IndexData.fromHTML(String html) {
    // 解析tab
      RegExp reg = RegExp(r'<a href="\/\?tab.*</a>');
      String tabStr = reg.stringMatch(html) ?? '';
      RegExp tabReg = RegExp(r'href=".+?(?:<)');
      var hot;
      List<Map<String, String>> tabs = tabReg.allMatches(tabStr).map((m){
        String tabStr = m.group(0) ?? '';
        String unuseStr = 'class';
        int unuseStrIndex = tabStr.indexOf(unuseStr);
        String tabName = tabStr.substring(12,unuseStrIndex - 2);

        int lastIndex = tabStr.indexOf('>');
        String tab = tabStr.substring(lastIndex+1, tabStr.length - 1);
        Map<String, String> tabMap = {tabName : tab};
        if (tabName == 'hot') hot = tabMap;
        return tabMap;
      }).toList();

      // 删除最热
      tabs.remove(hot);
      
      RegExp tabNodeStrReg = RegExp(r'SecondaryTabs">[\s\S.]+?</div>', multiLine: true);
      RegExp tabNodeReg = RegExp(r'go/.+?(?=</a>)');

      String tabNodesStr = tabNodeStrReg.stringMatch(html) ?? '';
      List<Map> tabNodes = tabNodeReg.allMatches(tabNodesStr).map((m){
        String nodeStr = m.group(0) ?? '';
        String unuseStr = '">';
        int unuseStrIndex = nodeStr.indexOf(unuseStr);
        String nodeName = nodeStr.substring(3, unuseStrIndex);
        String node = nodeStr.substring(unuseStrIndex+unuseStr.length);
        return {nodeName : node};
      }).toList();

      // 解析全部节点
      RegExp nodeTitleReg = RegExp(r'<table.*?</table>');
      RegExp titleReg = RegExp(r'(?=fade">).*?(?=</span>)');
      RegExp nodeReg = RegExp(r'go/.+?(?=</a>)');
      List<Map<String, List>> nodes = nodeTitleReg.allMatches(html).map((m){
        String tableString = m.group(0) ?? '';
        String title = titleReg.stringMatch(tableString)?.substring(6) ?? '';
        List nodes = nodeReg.allMatches(tableString).map((m){
          String nodeStr = m.group(0) ?? '';
          String unuseStr = '" style="font-size: 14px;">';
          int unuseStrIndex = nodeStr.indexOf(unuseStr);
          String nodeName = nodeStr.substring(3, unuseStrIndex);
          String node = nodeStr.substring(unuseStrIndex+unuseStr.length);
          return {nodeName : node};
        }).toList();
        return {title : nodes};
      }).toList();

      RegExp onlineReg = RegExp(r'(?=\d+ ).+?人在线');
      String onlineCountStr = onlineReg.stringMatch(html) ?? '';
      String onlineCount = onlineCountStr.substring(0, onlineCountStr.length - 3);

      RegExp highestOnlineReg = RegExp(r'(最高记录 )\d+</span>');
      String highestOnlineStr = highestOnlineReg.stringMatch(html) ?? '';
      String highestOnline = highestOnlineStr.substring(5, highestOnlineStr.length - 7);

      // 匹配帖子
      RegExp topicsReg = RegExp(r'^<div class="cell item"[\s\S.]+?strong><\/span>$', multiLine: true);
      List<Topics> topicses = topicsReg.allMatches(html).map((m){
        String topicsStr = m.group(0) ?? '';
        String avatarURL = RegExp(r'(src=").*?"').stringMatch(topicsStr) ?? '';
        avatarURL = 'https://${avatarURL.substring(5,avatarURL.length - 1)}';

        String titleStr = RegExp(r'href=".*</a></span>').stringMatch(topicsStr) ?? '';
        titleStr = titleStr.substring(0,titleStr.length - 11);
        String unuseStr = '">';
        int unuseStrIndex = titleStr.indexOf(unuseStr);
        String title = titleStr.substring(unuseStrIndex+unuseStr.length);
        int replyIndex = titleStr.indexOf('#reply');
        String replyCount = titleStr.substring(replyIndex+6, unuseStrIndex-19);
        int tStrIndex = titleStr.indexOf('/t/');
        String topicsId = titleStr.substring(tStrIndex+3,replyIndex);
        String url = 'https://www.v2ex.com/t/$topicsId';

        // 节点
        String nodeStr = RegExp(r'class="node".+?</a>').stringMatch(topicsStr) ?? '';
        nodeStr = nodeStr.substring(0,nodeStr.length - 4);
        int lastIndex = nodeStr.indexOf('>');
        String node = nodeStr.substring(lastIndex+1);

        // 作者
        String authorStr = RegExp(r'<strong><a href="/member.+?</a>').stringMatch(topicsStr) ?? '';
        authorStr = authorStr.substring(0,authorStr.length - 4);
        int lastAuthorIndex = authorStr.indexOf('">');
        String author = authorStr.substring(lastAuthorIndex+2);

        // 最后回复
        String lastReplyStr = RegExp(r'最后回复来自 <strong><a href="/member.+?</a>').stringMatch(topicsStr) ?? '';
        lastReplyStr = lastReplyStr.substring(0,lastReplyStr.length - 4);
        String lastReply = '';
        if (lastReplyStr.length > 2) {
          int lastReplyIndex = lastReplyStr.indexOf('">');
          lastReply = lastReplyStr.substring(lastReplyIndex+2);
        }

        // 时间
        String timeStr = RegExp(r'</strong>.+最后').stringMatch(topicsStr) ?? '';
        timeStr = timeStr.substring(24, timeStr.length - 16);


        return Topics(int.parse(topicsId), title, author, url, avatarURL, node, lastReply, 999, timeStr: timeStr);
      }).toList();
      return IndexData(nodes, tabs, tabNodes, onlineCount, highestOnline, topicses, '0', '0', '0', '0', []);
  }

}