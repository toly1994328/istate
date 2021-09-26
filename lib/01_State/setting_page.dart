import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  final int initialCounter;
  final VoidCallback onReset;

  const SettingPage(
      {Key? key, required this.initialCounter, required this.onReset})
      : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCounter;
  }

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
            Text('当前计数为: ${_counter}'),
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
    widget.onReset();
    setState(() {
      _counter = 0;
    });
  }
}
