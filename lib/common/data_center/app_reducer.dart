
import 'package:flutter_redux/flutter_redux.dart';
import 'package:iv2ex/common/data_center/app_action.dart';
import 'package:iv2ex/common/data_center/app_state.dart';
import 'package:redux/redux.dart';

import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final testReducer = combineReducers<int> ([
  TypedReducer<int, AddTestAction>(_addTest)
]);

final test2Reducer = combineReducers<String> ([
  TypedReducer<String, EditTest2Action> (_editTest2)
]);

final test3Reducer = combineReducers<String> ([
  TypedReducer<String, StoreTest3Action> (_storeTest3)
]);

int _addTest(int state, AddTestAction action) {
  return state + action.test;
}

String _storeTest3(String state, StoreTest3Action action) {

  // 存储test3
  final rxPrefs = RxSharedPreferences(SharedPreferences.getInstance(), const DefaultLogger());
  rxPrefs.setString("test3", action.test3);
  return action.test3;
}

String _editTest2(String state, EditTest2Action action) {
  /// 持久化test2
  final rxPrefs = RxSharedPreferences(SharedPreferences.getInstance(), const DefaultLogger());
  rxPrefs.setString("test2", action.test2);
  return action.test2;
}

AppState appReducer(AppState state, action) {
  return AppState(
    test: testReducer(state.test, action),
    test2: test2Reducer(state.test2, action),
    test3: test3Reducer(state.test3, action),
  );
}