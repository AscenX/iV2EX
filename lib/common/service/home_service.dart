import 'dart:convert';

import 'package:iv2ex/common/network/networking.dart';
import 'package:iv2ex/common/network/api.dart';
import 'package:rxdart/rxdart.dart';

class HomeService {

  static Observable<int> fetchBanner() {
    return Observable.fromFuture(Networking.request(type: APIType.banner)).map( (data) {
      print("map1");
      return 1;
    });
  }

  static Observable<int> fetchData(int test) {

    var params = {"test" : test };

    return Observable.fromFuture(Networking.request(type: APIType.home, params: params)).map( (data) {
      Map<String, dynamic> json = data;
      if (json.containsKey("args")) {
        Map<String, dynamic> test = json["args"];
        return int.parse(test["test"]);
      }
      return 1;
    });
  }
}
