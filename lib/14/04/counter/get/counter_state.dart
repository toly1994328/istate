import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;
  final int step;

  const CounterState({
    this.counter = 0,
    this.step = 1,
  });

  factory CounterState.fromMap(dynamic map) => CounterState(
        counter: map['counter'] ?? 0,
        step: map['step'] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        'counter': counter,
        'step': step,
      };

  CounterState copyWith({
    int? counter,
    int? step,
  }) =>
      CounterState(
        counter: counter ?? this.counter,
        step: step ?? this.step,
      );

  @override
  List<Object?> get props => [counter, step];
}
