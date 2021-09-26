import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  final ValueNotifier<int> counter;

  const SettingPage({
    Key? key,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置界面'),
      ),
      body: Container(
        height: 54,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            ValueListenableBuilder(
              valueListenable: counter,
              builder: (ctx,int value, __)=>Text(
                '当前计数为: $value',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              child: const Text('重置'),
              onPressed: _onReset,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  void _onReset() {
    counter.value =0 ;
  }
}
