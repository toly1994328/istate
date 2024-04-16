import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'counter_ctrl.dart';

class GetCounterPage extends StatelessWidget {
  const GetCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Get 计数器'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('下面是你点击按钮的次数:'), _CounterText()],
          ),
        ),
        floatingActionButton:
            const _AddActionButton(), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class _CounterText extends StatelessWidget {
  const _CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.headlineMedium;
    return GetX(
      init: CounterCtrl(),
      builder: (CounterCtrl ctrl) {
        return Text(
          '${ctrl.state.counter}',
          style: style,
        );
      },
    );
  }
}

class _AddActionButton extends StatelessWidget {
  const _AddActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      onPressed: () => Get.find<CounterCtrl>().increment(),
      child: const Icon(Icons.add),
    );
  }
}
