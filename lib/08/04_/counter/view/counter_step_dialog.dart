import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../river/counter_river.dart';

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
            child: Consumer(builder: (ctx, ref, child) {
              return TextButton(onPressed: ()=>_onConform(ref), child: const Text('确定'));
            }),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (ctx, ref, child) {
                int step = ref
                    .watch(counterRiverProvider.select((model) => model.step));
                return Text('当前步长 +$step');
              },
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

  void _onConform(WidgetRef ref) {
    int? stepInput = int.tryParse(_ctrl.text);
    if (stepInput != null) {
      ref.read(counterRiverProvider.notifier).changeStep(stepInput);
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
