import 'dart:async';

import 'package:flutter/material.dart';

import 'counter_mixin.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> with CounterMixin {

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.headlineMedium;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('计数器'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('下面是你点击按钮的次数:'),
              Text('${state.counter}', style: style)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          onPressed: increment,
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
