import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/counter_state.dart';

class CounterRepository{

  static const kCounterStateKey = 'CounterState';

  final SharedPreferences preferences;

  CounterRepository(this.preferences);

  Future<bool> save(CounterState state) {
    String data = jsonEncode(state);
    return preferences.setString(kCounterStateKey, data);
  }

  CounterState read() {
    String data = preferences.getString(kCounterStateKey)??'{}';
    return CounterState.fromMap(jsonDecode(data));
  }

  Future<bool> clear(){
    return preferences.remove(kCounterStateKey);
  }
}