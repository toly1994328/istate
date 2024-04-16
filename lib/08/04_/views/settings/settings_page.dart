import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/river/app_theme_river.dart';
import '../../counter/river/counter_river.dart';
import '../../counter/view/counter_step_dialog.dart';
import 'theme_model_setting_page.dart';

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

class ThemSettingItem extends ConsumerWidget {
  const ThemSettingItem({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ThemeMode appThemeBloc = ref.watch(appThemeRiverProvider);
    String title = kThemeModeMap[appThemeBloc]!;
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.style, color: primaryColor),
      title: const Text('深色模式', style: titleStyle),
      subtitle: Text(title, style: subStyle),
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

class CounterResetItem extends ConsumerWidget {
  const CounterResetItem({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    int count = ref.watch(counterRiverProvider).counter;

    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.refresh, color: primaryColor),
      title: const Text('重置计数器', style: titleStyle),
      subtitle: Text('当前数值:$count', style: subStyle),
      onTap: ()=>ref.read(counterRiverProvider.notifier).reset(),
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

class CounterStepShow extends ConsumerWidget {
  const CounterStepShow({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    int step = ref.watch(counterRiverProvider.select((model) => model.step));
    return Text('步长 +$step', style: subStyle);
  }
}
