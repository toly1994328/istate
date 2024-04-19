import 'package:flutter/material.dart';
import '../../manager/app_counter_model.dart';
import 'package:provider/provider.dart';

import '../../manager/app_theme_provider.dart';
import 'counter_tool_bar.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  Widget _buildSwitch(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    AppThemeManager appThemeManager = context.read<AppThemeManager>();

    return Switch(
      value: isDark,
      inactiveTrackColor: Colors.white,
      trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
      thumbIcon: MaterialStateProperty.all(
          isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode)),
      onChanged: appThemeManager.switchTheme,
    );
  }

  Widget _buildCounter() {
    return Consumer<AppCountModel>(
      builder: (ctx, AppCountModel model, __) {
        return Text(
          '${model.counter}',
          style: Theme
              .of(ctx)
              .textTheme
              .headlineMedium,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [_buildSwitch(context)],
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
        onPressed: context
            .read<AppCountModel>()
            .increment,
        tooltip: '增加',
        child: const Icon(Icons.add),
      ),
    );
  }
}


