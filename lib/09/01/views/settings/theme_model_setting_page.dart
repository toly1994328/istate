import 'package:flutter/material.dart';
import '../../app/bloc/app_theme_bloc.dart';
import 'package:provider/provider.dart';

import '../../components/toly_switch_list_tile.dart';

class ThemeModeSettingPage extends StatelessWidget {
  const ThemeModeSettingPage({super.key});

  void _changeWithSystem(bool value, AppThemeBloc manager) {
    ThemeMode newModel;
    if (value) {
      newModel = ThemeMode.system;
    } else {
      newModel = ThemeMode.light;
    }
    manager.setTheme(newModel);
  }

  @override
  Widget build(BuildContext context) {
    AppThemeBloc appThemeBloc = context.watch<AppThemeBloc>();

    Color iconColor = Theme.of(context).primaryColor;
    ThemeMode mode = appThemeBloc.state;
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
            onChanged: (v) => _changeWithSystem(v, appThemeBloc),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 16, bottom: 6),
            child: Text("手动设置"),
          ),
          _buildItemTile(ThemeMode.light, mode, appThemeBloc,iconColor),
          const Divider(),
          _buildItemTile(ThemeMode.dark, mode, appThemeBloc,iconColor),
        ],
      ),
    );
  }

  Widget _buildItemTile(
    ThemeMode model,
    ThemeMode activeModel,
    AppThemeBloc manager,
    Color iconColor,
  ) {
    bool active = model == activeModel;
    return ListTile(
      title: Text(kThemeModeMap[model]!),
      onTap: () => manager.setTheme(model),
      trailing: active ? Icon(Icons.check, size: 20, color: iconColor) : null,
    );
  }
}
