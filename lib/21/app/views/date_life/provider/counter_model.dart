import 'package:flutter/material.dart';
import '../model/counter_state.dart';

class CounterModel with ChangeNotifier {

  CounterModel(){
    print("======CounterModel#create===========");
  }

  CounterState _state =  CounterState(0);

  CounterState get state => _state;

  void increment() {
    _state = CounterState(_state.counter+1);
    notifyListeners();
  }

  @override
  void dispose() {
    print("======CounterModel#dispose===========");
    super.dispose();
  }
}
