import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/counter_repository.dart';
import 'counter_state.dart';

class AppCounterBloc extends Cubit<CounterState> {
  late CounterRepository _repository;

  AppCounterBloc() : super(const CounterState());

  void init(CounterRepository repository) {
    _repository = repository;
    CounterState newState = _repository.read();
    emit(newState);
  }

  void increment() {
    int newCounter = state.counter + state.step;
    CounterState newState = state.copyWith(counter: newCounter);
    _repository.save(newState);
    emit(newState);
  }

  void reset() {
    CounterState newState = state.copyWith(counter: 0,);
    _repository.save(newState);
    emit(newState);
  }

  void changeStep(int step) {
    CounterState newState = state.copyWith(step: step);
    _repository.save(newState);
    emit(newState);
  }

  void clear() {
    _repository.clear();
  }
}
