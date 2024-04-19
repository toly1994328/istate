import 'package:flutter/material.dart';
import '../counter/counter_step_dialog.dart';
import '../../manager/app_counter_model.dart';
import 'package:provider/provider.dart';
import 'theme_model_setting_page.dart';

import '../../manager/app_theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('应用设置'),
        // backgroundColor: Colors.white,
      ),
      body: ListView(
        children: const <Widget>[
          SizedBox(height: 15),
          ThemSettingItem(),
          SizedBox(height: 10),
          CounterResetItem(),
          Divider(),
          CounterStepSetItem(),
        ],
      ),
    );
  }
}

class ThemSettingItem extends StatelessWidget {
  const ThemSettingItem({super.key});

  @override
  Widget build(BuildContext context) {
    AppThemeManager appThemeManager = context.watch<AppThemeManager>();

    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.style, color: primaryColor),
      title: const Text('深色模式', style: titleStyle),
      subtitle: Text(appThemeManager.title, style: subStyle),
      trailing: Icon(Icons.chevron_right, color: primaryColor),
      onTap: () => _toThemeModeSettingPage(context),
    );
  }

  void _toThemeModeSettingPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ThemeModeSettingPage()),
    );
  }
}

class CounterResetItem extends StatelessWidget {
  const CounterResetItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.refresh, color: primaryColor),
      title: const Text('重置计数器', style: titleStyle),
      subtitle: Selector<AppCountModel, int>(
          selector: (_, model) => model.counter,
          builder: (_, int counter, __) {
            return Text('当前数值:$counter', style: subStyle);
          }),
      onTap: context.read<AppCountModel>().reset,
    );
  }
}

class CounterStepSetItem extends StatelessWidget {
  const CounterStepSetItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.settings_suggest_rounded, color: primaryColor),
      title: const Text('计数器步长', style: titleStyle),
      subtitle: const CounterStepShow(),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => const CounterStepDialog(),
        );
      },
    );
  }
}


class CounterStepShow extends StatelessWidget {
  const CounterStepShow({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    int step = context.select<AppCountModel,int>((model) => model.step);
    return Text('步长 +$step', style: subStyle);
  }
}
