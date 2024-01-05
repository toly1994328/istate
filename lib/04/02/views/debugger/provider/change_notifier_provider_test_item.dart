import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountModel with ChangeNotifier{
  int _counter =0;
  int get counter => _counter;

  void increment(){
    _counter++;
    notifyListeners();
  }
}


class ChangeNotifierProviderTestItem extends StatelessWidget {
  const ChangeNotifierProviderTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
      title: const Text('ChangeNotifierProvider测试', style: titleStyle),
      subtitle: const Text('点击计数器增加', style: subStyle),
      trailing:  const CounterBox(),
      onTap: context.read<CountModel>().increment,
    );
  }
}

class CounterBox extends StatelessWidget {
  const CounterBox({super.key});

  @override
  Widget build(BuildContext context) {
    int counter = context.watch<CountModel>().counter;
    const TextStyle style = TextStyle(color: Colors.white);

    BorderRadius radius = BorderRadius.circular(4);
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blue, borderRadius:radius ),
      child: Text('$counter', style: style),
    );
  }
}
