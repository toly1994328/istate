import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/river/app_theme_river.dart';

import '../../components/toly_switch_list_tile.dart';

class ThemeModeSettingPage extends ConsumerWidget{
  const ThemeModeSettingPage({super.key});

  void _changeWithSystem(bool value, WidgetRef ref) {
    AppThemeRiver appTheme = ref.read(appThemeRiverProvider.notifier);
    ThemeMode newModel;
    if (value) {
      newModel = ThemeMode.system;
    } else {
      newModel = ThemeMode.light;
    }
    appTheme.setTheme(newModel);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ThemeMode mode = ref.watch(appThemeRiverProvider);
    Color iconColor = Theme.of(context).primaryColor;

    const TextStyle title =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const TextStyle subtitle = TextStyle(fontSize: 12, color: Colors.grey);
    return Scaffold(
      appBar: AppBar(title: const Text('深色模式')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 15),
          TolySwitchListTile(
            title: const Text('跟随系统', style: title),
            subtitle: const Text('开启后，将跟随系统打开或关闭深色模式', style: subtitle),
            value: mode == ThemeMode.system,
            onChanged: (v) => _changeWithSystem(v, ref),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 16, bottom: 6),
            child: Text("手动设置"),
          ),
          _buildItemTile(ThemeMode.light, mode, ref,iconColor),
          const Divider(),
          _buildItemTile(ThemeMode.dark, mode, ref,iconColor),
        ],
      ),
    );
  }

  Widget _buildItemTile(
    ThemeMode model,
    ThemeMode activeModel,
    WidgetRef ref,
    Color iconColor,
  ) {
    bool active = model == activeModel;
    return ListTile(
      title: Text(kThemeModeMap[model]!),
      onTap: () => ref.read(appThemeRiverProvider.notifier).setTheme(model),
      trailing: active ? Icon(Icons.check, size: 20, color: iconColor) : null,
    );
  }
}
