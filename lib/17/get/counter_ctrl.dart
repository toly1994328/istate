import 'package:get/get.dart';
import '../model/counter_state.dart';

class CounterCtrl extends GetxController {

  final Rx<CounterState> _state = CounterState(0).obs;

  CounterState get state => _state.value;

  CounterCtrl() {
    print("=====CounterCtrl#create===========");
  }

  void increment() {
    _state.value = CounterState(_state.value.counter + 1);
  }

  @override
  void onClose() {
    print("======CounterCtrl#onClose===========");
    super.onClose();
  }
}
