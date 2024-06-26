import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/app_theme_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
  });

  @override
  State<CounterPage> createState() => _CounterPageState();
}


class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget _buildSwitch() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    AppThemeManager appThemeManager = context.read<AppThemeManager>();

    return Switch(
      value: isDark,
      inactiveTrackColor: Colors.white,
      trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
      thumbIcon: MaterialStateProperty.all(isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode)),
      onChanged: appThemeManager.switchTheme,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [_buildSwitch()],
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('计数器'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              // 'You have pushed the button this many times:',
              '下面是你点击按钮的次数:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '增加',
        // tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}