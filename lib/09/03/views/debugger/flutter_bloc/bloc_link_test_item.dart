
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_test_item.dart';
List<Color> kColors = [
  Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue,
  Colors.indigo, Colors.purple, Colors.pink, Colors.black, Colors.cyan,
];

class ColorBloc extends Cubit<Color> {

  ColorBloc():super(kColors[0]);

  void update(int counter) {
    Color color = kColors[counter%kColors.length];
    emit(color);
  }
}


class BlocLinkTestItem extends StatelessWidget {
  const BlocLinkTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return BlocListener<CountBloc,int>(
      listener: _listenCountChange,
      child: ListTile(
        leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
        title: const Text('两个 bloc 协作测试', style: titleStyle),
        subtitle: const Text('点击计数器增加,颜色变化', style: subStyle),
        trailing:  const CounterBox(),
        onTap: context.read<CountBloc>().increment,
      ),
    );
  }

  void _listenCountChange(BuildContext context, int counter) {
    context.read<ColorBloc>().update(counter);
  }
}

class CounterBox extends StatelessWidget {
  const CounterBox({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = context.watch<ColorBloc>().state;
    int counter = context.watch<CountBloc>().state;
    const TextStyle style = TextStyle(color: Colors.white);

    BorderRadius radius = BorderRadius.circular(4);
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, borderRadius:radius ),
      child: Text('$counter', style: style),
    );
  }
}
