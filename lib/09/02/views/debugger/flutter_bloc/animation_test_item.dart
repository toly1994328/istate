import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationBloc extends Cubit<double> {
  final AnimationController _ctrl;

  AnimationBloc(this._ctrl) : super(_ctrl.value) {
    _ctrl.addListener(_onChange);
  }

  void _onChange() {
    emit(_ctrl.value);
  }

  void start() {
    _ctrl.forward(from: 0);
  }

  @override
  Future<void> close() {
    debugPrint("::close::");
    _ctrl.dispose();
    return super.close();
  }
}

class AnimationBlocWrapper extends StatefulWidget {
  final Widget child;

  const AnimationBlocWrapper({super.key, required this.child});

  @override
  State<AnimationBlocWrapper> createState() => _AnimationBlocWrapperState();
}

class _AnimationBlocWrapperState extends State<AnimationBlocWrapper>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnimationBloc>(
      create: (BuildContext context) {
        return AnimationBloc(AnimationController(
          vsync: this,
          duration: const Duration(seconds: 2),
        ));
      },
      child: widget.child,
    );
  }
}

class AnimationTestItem extends StatelessWidget {
  const AnimationTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
      title: const Text('动画数据测试', style: titleStyle),
      subtitle: const Text('共享动画数据，点击运行', style: subStyle),
      trailing: const Wrap(
        spacing: 8,
        children: [
          RotateBox(color: Colors.blue, color2: Colors.red, text: 'Toly'),
          RotateBox(color: Colors.red, color2: Colors.blue, text: 'Star'),
        ],
      ),
      onTap: context.read<AnimationBloc>().start,
    );
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
    double value = context.watch<AnimationBloc>().state;
    Color? boxColor = Color.lerp(color2, color, value);
    const TextStyle style = TextStyle(color: Colors.white);
    BorderRadius radius = BorderRadius.circular(4);
    return Transform.rotate(
      angle: value * 2.0 * pi,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: boxColor, borderRadius: radius),
        child: Text(text, style: style),
      ),
    );
  }
}
