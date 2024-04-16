import 'package:flutter_riverpod/flutter_riverpod.dart';


class Counter extends AutoDisposeNotifier<int> {

  @override
  int build() => 0;

  void increment() => state++;

}

final counterProvider =  AutoDisposeNotifierProvider<Counter, int>(
    Counter.new
);
