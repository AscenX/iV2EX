import 'package:iv2ex/common/app_manager.dart';
import 'package:iv2ex/common/data_center/app_action.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';


class AppState {
  int test;
  String test2;

  String test3;

  AppState({
    this.test,
    this.test2,
    this.test3,
  });


  static AppState init() {

    return AppState(
      test2: "",
      test3: "",
    );
  }

  asyncInit() async {

    this.test2 = await App.shared.rxPres.getString("test2");
    this.test3 = await App.shared.rxPres.getString("test3");

    print("AppState async init finished: " + this.toString());
  }

  AppState copy({
    int test,
    String test2,
    String test3,
  }) {
    return AppState(
      test: test ?? this.test,
      test2: test2 ?? this.test2,
      test3: test3 ?? this.test3,
    );
  }

  /// 判断两个state是否两桶
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              test == other.test &&
              test2 == other.test2 &&
              test3 == other.test3;

  @override
  int get hashCode =>
      test.hashCode ^
      test2.hashCode ^
      test3.hashCode;

  @override
  String toString() {
    return 'AppState{test: $test, test2: $test2, test3: $test3}';
  }

}