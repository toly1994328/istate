import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

enum CountEvent {
  add,
  reset,
}

class CountState {
  final int value;

  const CountState({this.value = 0});
}

class CountBloc extends Bloc<CountEvent, CountState> {
  CountBloc() : super(const CountState()){
    on<CountEvent>(_onCountEvent);
  }

  void _onCountEvent(CountEvent event, Emitter<CountState> emit) {
    if (event == CountEvent.add) {
      emit(CountState(value: state.value + 1));
    }

    if (event == CountEvent.reset) {
      emit (const CountState(value: 0));
    }
  }
}
