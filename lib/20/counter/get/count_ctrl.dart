import 'package:get/get.dart';
import '../data/counter_repository.dart';
import 'counter_state.dart';

class AppCounterCtrl extends GetxController {
  late CounterRepository _repository;

  Rx<CounterState> state = const CounterState().obs;

  void init(CounterRepository repository) {
    _repository = repository;
    state.value = _repository.read();
  }

  void increase() {
    int newCounter = state.value.counter + state.value.step;
    CounterState newState = state.value.copyWith(counter: newCounter);
    _repository.save(newState);
    state.value = newState;
  }

  void reset() {
    CounterState newState = state.value.copyWith(counter: 0);
    _repository.save(newState);
    state.value = newState;
  }

  void stepChange(int step) {
    CounterState newState = state.value.copyWith(step: step);
    _repository.save(newState);
    state.value = newState;
  }
}
