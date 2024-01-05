import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change_notifier_provider_test_item.dart';

List<Color> kColors = [
  Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue,
  Colors.indigo, Colors.purple, Colors.pink, Colors.black, Colors.cyan,
];

class ColorModel with ChangeNotifier {

  Color _color = kColors[0];

  Color get color => _color;

  void update(CountModel model) {
    _color = kColors[model.counter%kColors.length];
    notifyListeners();
  }
}

class ChangeNotifierProxyProviderTestItem extends StatelessWidget {
  const ChangeNotifierProxyProviderTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 14);
    return ListTile(
      leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
      title: const Text('ChangeNotifierProxyProvider 测试', style: titleStyle),
      subtitle: const Text('点击计数器增加,颜色变化', style: subStyle),
      trailing: const CounterBox(),
      onTap: context.read<CountModel>().increment,
    );
  }
}

class CounterBox extends StatelessWidget {
  const CounterBox({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = context.watch<ColorModel>().color;
    int counter = context.watch<CountModel>().counter;
    const TextStyle style = TextStyle(color: Colors.white);
    BorderRadius radius = BorderRadius.circular(4);
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, borderRadius: radius),
      child: Text('$counter', style: style),
    );
  }
}
