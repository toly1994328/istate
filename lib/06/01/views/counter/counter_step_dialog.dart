import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/app_counter_bloc.dart';

class CounterStepDialog extends StatefulWidget {
  const CounterStepDialog({super.key});

  @override
  State<CounterStepDialog> createState() => _CounterStepDialogState();
}

class _CounterStepDialogState extends State<CounterStepDialog> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('设置累加步长'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(onPressed: _onConform, child: const Text('确定')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AppCounterBloc, CounterState>(
              buildWhen: (p, n) => p.step != n.step,
              builder: (ctx, state) => Text('当前步长 +${state.step}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: CupertinoTextField(
                controller: _ctrl,
                placeholder: '请输入整数数字',
                placeholderStyle:
                    const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const Text(
              '步长表示计数器每次点击时的累加数值。',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _onConform() {
    int? stepInput = int.tryParse(_ctrl.text);
    if (stepInput != null) {
      context.read<AppCounterBloc>().changeStep(stepInput);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orange,
          content: Text('校验失败，请输入整数！'),
        ),
      );
    }
  }
}
