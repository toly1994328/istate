import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'counter_river.dart';

class RiverpodCounterPage extends ConsumerWidget {
  const RiverpodCounterPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod 计数器'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('下面是你点击按钮的次数:'), _CounterText()],
          ),
        ),
        floatingActionButton: const _AddActionButton(), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class _CounterText extends ConsumerWidget {
  const _CounterText({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    TextStyle? style = Theme.of(context).textTheme.headlineMedium;
    int counter = ref.watch(counterRiverProvider).counter;
    return Text(
      '$counter',
      style: style,
    );
  }
}

class _AddActionButton extends ConsumerWidget {
  const _AddActionButton({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      onPressed: ()=> ref.read(counterRiverProvider.notifier).increment(),
      child: const Icon(Icons.add),
    );
  }
}
