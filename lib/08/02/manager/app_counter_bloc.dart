
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCounterBloc extends Cubit<CounterState> {
  AppCounterBloc() : super(const CounterState());

  void increment() {
    int newCounter = state.counter + state.step;
    emit(CounterState(counter: newCounter, step: state.step));
  }

  void reset() {
    emit(CounterState(counter: 0, step: state.step));
  }

  void changeStep(int step) {
    emit(CounterState(counter: state.counter, step: step));
  }
}

class CounterState extends Equatable {
  final int counter;
  final int step;

  const CounterState({
    this.counter = 0,
    this.step = 1,
  });

  @override
  List<Object?> get props => [counter, step];
}
