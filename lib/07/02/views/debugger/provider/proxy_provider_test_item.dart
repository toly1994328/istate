
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change_notifier_provider_test_item.dart';

class CountStringModel {
 final String value;

  CountStringModel(this.value);

  factory CountStringModel.fromInt(int value) {
    Map<int,String> map = {
      0: '零', 1: '壹', 2: '贰', 3: '叁', 4: '肆',
      5: '伍', 6: '陆', 7: '柒', 8: '捌', 9: '玖', 10: '拾'};
    return CountStringModel(map[value%11]!);
  }
}


class ProxyProviderTestItem extends StatelessWidget {
  const ProxyProviderTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
      title: const Text('ProxyProvider 测试', style: titleStyle),
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
    String counterStr = context.watch<CountStringModel>().value;
    const TextStyle style = TextStyle(color: Colors.white);
    BorderRadius radius = BorderRadius.circular(4);
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blue, borderRadius:radius ),
      child: Text(counterStr, style: style),
    );
  }
}
