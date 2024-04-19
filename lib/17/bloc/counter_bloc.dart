import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/counter_state.dart';

class CounterBloc extends Cubit<CounterState> {
  CounterBloc() : super( CounterState(0)){
    print("=====CounterBloc#create===========");
  }

  void increment() {
    emit(CounterState(state.counter + 1));
  }

  @override
  Future<void> close() {
    print("======CounterBloc#close===========");
    return super.close();
  }
}
