import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCounterBloc extends Bloc<CounterEvent,CounterState> {
  AppCounterBloc():super(const CounterState()){
    on<IncreaseEvent>(_onIncreaseEvent);
    on<ResetEvent>(_onResetEvent);
    on<StepChangeEvent>(_onStepChangeEvent);
  }

  FutureOr<void> _onIncreaseEvent(IncreaseEvent event, Emitter<CounterState> emit) {
    int newCounter = state.counter +  state.step;
    emit(CounterState(counter: newCounter, step: state.step));
  }

  FutureOr<void> _onResetEvent(ResetEvent event, Emitter<CounterState> emit) {
    emit(CounterState(counter: 0, step: state.step));
  }

  FutureOr<void> _onStepChangeEvent(StepChangeEvent event, Emitter<CounterState> emit) {
    emit(CounterState(counter: state.counter, step: event.step));
  }
}


class CounterState {
  final int counter;
  final int step;

  const CounterState({ this.counter=0,  this.step=1,});



}

abstract class CounterEvent extends Equatable{
  const CounterEvent();
}

class IncreaseEvent extends CounterEvent{
  const IncreaseEvent();
  @override
  List<Object> get props => [];
}

class ResetEvent extends CounterEvent{
  const ResetEvent();

  @override
  List<Object> get props => [];
}

class StepChangeEvent extends CounterEvent{
  final int step;
  const StepChangeEvent(this.step);

  @override
  List<Object> get props => [step];
}