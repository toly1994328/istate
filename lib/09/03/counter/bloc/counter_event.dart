import 'package:equatable/equatable.dart';

import '../data/counter_repository.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

/// 初始化事件，基于 [repository] 初始化状态数据
class InitEvent extends CounterEvent {
  final CounterRepository repository;

  const InitEvent(this.repository);

  @override
  List<Object> get props => [repository];
}

/// 增加事件
class IncreaseEvent extends CounterEvent {
  const IncreaseEvent();
}

/// 重置事件
class ResetEvent extends CounterEvent {
  const ResetEvent();
}

/// 改变步长事件
class StepChangeEvent extends CounterEvent {
  final int step;

  const StepChangeEvent(this.step);

  @override
  List<Object> get props => [step];
}
