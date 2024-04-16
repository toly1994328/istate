import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../app/river/app_theme_river.dart';
import '../river/counter_river.dart';
import 'counter_tool_bar.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  Widget _buildSwitch(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Switch(
      value: isDark,
      inactiveTrackColor: Colors.white,
      trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
      thumbIcon: MaterialStateProperty.all(
          isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode)),
      onChanged: (v) => ref.read(appThemeRiverProvider.notifier).switchTheme(v),
    );
  }

  Widget _buildCounter() {
    return Consumer(
      builder: (ctx,  ref,child) {
        TextStyle? style = Theme.of(ctx).textTheme.headlineMedium;
        int count = ref.watch(counterRiverProvider.select((model) => model.counter));
        return Text('$count', style: style);
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [_buildSwitch(context, ref)],
        title: const Text('计数器'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(24),
          child: CounterToolBar(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('下面是你点击按钮的次数:'),
            _buildCounter(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(counterRiverProvider.notifier).increase(),
        tooltip: '增加',
        child: const Icon(Icons.add),
      ),
    );
  }
}
