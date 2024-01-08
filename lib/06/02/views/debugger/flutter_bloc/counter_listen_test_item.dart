import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'counter_test_item.dart';

class CounterListenerTestItem extends StatelessWidget {
  const CounterListenerTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return BlocListener<CountBloc, int>(
      listener: _listenStateChange,
      child: ListTile(
        leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
        title: const Text('BlocListener 监听变化', style: titleStyle),
        subtitle: const Text('数值是 10 的倍数时弹出消息', style: subStyle),
        trailing: const CounterBox(),
        onTap: context.read<CountBloc>().increment,
      ),
    );
  }

  void _listenStateChange(BuildContext context, int state) {
    if (state % 10 == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('累加到10的倍数'),
        ),
      );
    }
  }
}

class CounterBox extends StatelessWidget {
  const CounterBox({super.key});

  @override
  Widget build(BuildContext context) {
    int counter = context.watch<CountBloc>().state;
    const TextStyle style = TextStyle(color: Colors.white);

    BorderRadius radius = BorderRadius.circular(4);
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blue, borderRadius: radius),
      child: Text('$counter', style: style),
    );
  }
}
