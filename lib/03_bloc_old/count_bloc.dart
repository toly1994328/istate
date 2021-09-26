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
  CountBloc() : super(const CountState());

  @override
  Stream<CountState> mapEventToState(CountEvent event) async* {
    if (event == CountEvent.add) {
      yield* _mapAddEventToState();
    }

    if (event == CountEvent.reset) {
      yield const CountState(value: 0);
    }
  }

  Stream<CountState> _mapAddEventToState() async* {
    yield CountState(value: state.value + 1);
  }
}
