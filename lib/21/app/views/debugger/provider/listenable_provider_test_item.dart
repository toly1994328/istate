import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimationWrapper extends StatefulWidget {
  final Widget child;

  const AnimationWrapper({super.key, required this.child});

  @override
  State<AnimationWrapper> createState() => _AnimationWrapperState();
}

class _AnimationWrapperState extends State<AnimationWrapper>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ListenableProvider<AnimationController>(
      create: (BuildContext context) {
        return AnimationController(
          vsync: this,
          duration: const Duration(seconds: 2),
        );
      },
      dispose: (_, ctrl) => ctrl.dispose(),
      child: widget.child,
    );
  }
}

class ListenableProviderTestItem extends StatelessWidget {
  const ListenableProviderTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
      title: const Text('ListenableProvider测试', style: titleStyle),
      subtitle: const Text('共享动画数据，点击运行', style: subStyle),
      trailing: const Wrap(
        spacing: 8,
        children: [
          RotateBox(color: Colors.blue, color2: Colors.red, text: 'Toly'),
          RotateBox(color: Colors.red, color2: Colors.blue, text: 'Star'),
        ],
      ),
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    context.read<AnimationController>().forward(from: 0);
  }
}

class RotateBox extends StatelessWidget {
  final Color color;
  final Color color2;
  final String text;

  const RotateBox({
    super.key,
    required this.color,
    required this.text,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    double value = context.watch<AnimationController>().value;
    Color? boxColor = Color.lerp(color2, color, value);
    const TextStyle style = TextStyle(color: Colors.white);
    BorderRadius radius = BorderRadius.circular(4);
    return Transform.rotate(
      angle: value * 2.0 * pi,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: boxColor, borderRadius:radius ),
        child: Text(text, style: style),
      ),
    );
  }
}
