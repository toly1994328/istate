import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/counter_state.dart';
part 'counter_river.g.dart';
@riverpod
class CounterRiver extends _$CounterRiver {
  CounterRiver(){
    print("======CounterRiver#create===========");
  }

  @override
  CounterState build() {
    ref.onDispose(() {
      print("======CounterRiver#onDispose===========");
    });
    return CounterState(0);
  }

  void increment() {
    state = CounterState(state.counter + 1);
  }
}