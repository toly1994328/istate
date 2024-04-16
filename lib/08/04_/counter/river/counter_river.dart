import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/counter_repository.dart';
import 'counter_state.dart';
part 'counter_river.g.dart';

@riverpod
class CounterRiver extends _$CounterRiver{

  late CounterRepository _repository;

  CounterRiver(){
    print("=======CounterRiver#create===============");
  }

  @override
  CounterState build() => const CounterState();

  FutureOr<void> init(CounterRepository repository) {
    print("=======CounterRiver#init===============");

    _repository = repository;
    // ref.read();
    CounterState newState = _repository.read();
    state = newState;
    ref.keepAlive();
    ref.onDispose(() {
      print("=======CounterRiver#onDispose===============");
    });
  }

  FutureOr<void> increase() {
    int newCounter = state.counter + state.step;
    CounterState newState = state.copyWith(counter: newCounter);
    _repository.save(newState);
    state = newState;
  }

  FutureOr<void> reset() {
    CounterState newState = state.copyWith(counter: 0);
    _repository.save(newState);
    state = newState;
  }

  FutureOr<void> changeStep(int step) {
    CounterState newState = state.copyWith(step: step);
    _repository.save(newState);
    state = newState;
  }
}