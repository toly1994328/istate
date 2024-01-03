import 'package:flutter/material.dart';

import '../manager/app_theme_manager.dart';
import 'settings_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget _buildSwitch() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Switch(
      value: isDark,
      inactiveTrackColor: Colors.white,
      trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
      thumbIcon: MaterialStateProperty.all(isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode)),
      onChanged: kAppThemeManager.switchTheme,
    );
  }

  Widget _buildSettingButton() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => SettingsPage()),
        );
      },
      icon: Icon(Icons.settings),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [_buildSwitch(),_buildSettingButton()],
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
