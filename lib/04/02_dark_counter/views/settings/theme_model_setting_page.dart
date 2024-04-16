import 'package:flutter/material.dart';

import '../../components/toly_switch_list_tile.dart';
import '../../manager/app_theme_manager.dart';

class ThemeModeSettingPage extends StatelessWidget {
  const ThemeModeSettingPage({super.key});

  void _changeWithSystem(bool value, AppThemeManager manager) {
    ThemeMode newModel;
    if (value) {
      newModel = ThemeMode.system;
    } else {
      newModel = ThemeMode.light;
    }
    manager.mode = newModel;
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager appThemeManager = AppThemeScope.of(context);
    Color iconColor = Theme.of(context).primaryColor;
    ThemeMode mode = appThemeManager.mode;
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
            onChanged: (v) => _changeWithSystem(v, appThemeManager),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 16, bottom: 6),
            child: Text("手动设置"),
          ),
          _buildItemTile(ThemeMode.light, mode, appThemeManager,iconColor),
          const Divider(),
          _buildItemTile(ThemeMode.dark, mode, appThemeManager,iconColor),
        ],
      ),
    );
  }

  Widget _buildItemTile(
    ThemeMode model,
    ThemeMode activeModel,
    AppThemeManager manager,
    Color iconColor,
  ) {
    bool active = model == activeModel;
    return ListTile(
      title: Text(kThemeModeMap[model]!),
      onTap: () => manager.mode = model,
      trailing: active ? Icon(Icons.check, size: 20, color: iconColor) : null,
    );
  }
}
