
import 'package:iv2ex/common/data_center/app_reducer.dart';
import 'package:iv2ex/common/data_center/app_state.dart';
import 'package:redux/redux.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {

  Store<AppState> store;
  RxSharedPreferences rxPres;

  String test4 = "test4";

  // 使用单例
  factory App() =>_getInstance();
  static App get shared => _getInstance();
  static App _shared;
  App._internal() {

    // 初始化rxPres
    if (rxPres == null) {
      rxPres = RxSharedPreferences(SharedPreferences.getInstance(), const DefaultLogger());
    }
    // 初始化store
    if (store == null) {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.init(),
      );
    }
  }

  asyncInitData() {
    this.store.state.asyncInit();
  }

  static App _getInstance() {
    if (_shared == null) {
      _shared = App._internal();
    }
    return _shared;
  }
}