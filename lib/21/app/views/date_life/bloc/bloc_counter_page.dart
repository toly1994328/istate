import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';

class BlocCounterPage extends StatelessWidget {
  const BlocCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Bloc 计数器'),
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

class _CounterText extends StatelessWidget {
  const _CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.headlineMedium;
    int counter = context.watch<CounterBloc>().state.counter;
    return Text(
      '$counter',
      style: style,
    );
  }
}

class _AddActionButton extends StatelessWidget {
  const _AddActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      onPressed: ()=> context.read<CounterBloc>().increment(),
      child: const Icon(Icons.add),
    );
  }
}
