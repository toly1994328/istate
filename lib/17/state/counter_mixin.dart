import 'package:flutter/cupertino.dart';
import '../model/counter_state.dart';

mixin CounterMixin<T extends StatefulWidget> on State<T> {
  CounterState _state = CounterState(0);

  CounterState get state => _state;

  void increment() {
    _state = CounterState(_state.counter + 1);
    setState(() {});
  }

  @override
  void dispose() {
    print("======CounterState#dispose===========");
    super.dispose();
  }
}
