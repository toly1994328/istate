import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/counter_repository.dart';
import 'counter_event.dart';
import 'counter_state.dart';


class AppCounterBloc extends Bloc<CounterEvent,CounterState> {

  AppCounterBloc():super(const CounterState()){
    on<InitEvent>(_onInitEvent);
    on<IncreaseEvent>(_onIncreaseEvent);
    on<ResetEvent>(_onResetEvent);
    on<StepChangeEvent>(_onStepChangeEvent);
  }

  late CounterRepository _repository;

  FutureOr<void> _onInitEvent(InitEvent event, Emitter<CounterState> emit) {
    _repository = event.repository;
    CounterState newState = _repository.read();
    emit(newState);
  }

  FutureOr<void> _onIncreaseEvent(IncreaseEvent event, Emitter<CounterState> emit) {
    int newCounter = state.counter + state.step;
    CounterState newState = state.copyWith(counter: newCounter);
    _repository.save(newState);
    emit(newState);
  }

  FutureOr<void> _onResetEvent(ResetEvent event, Emitter<CounterState> emit) {
    CounterState newState = state.copyWith(counter: 0);
    _repository.save(newState);
    emit(newState);
  }

  FutureOr<void> _onStepChangeEvent(StepChangeEvent event, Emitter<CounterState> emit) {
    CounterState newState = state.copyWith(step: event.step);
    _repository.save(newState);
    emit(newState);
  }

  @override
  void onTransition(Transition<CounterEvent, CounterState> transition) {
    super.onTransition(transition);
    debugPrint("::onTransition::(event:${transition.event}:${transition.currentState},next:${transition.nextState})");
  }
}
