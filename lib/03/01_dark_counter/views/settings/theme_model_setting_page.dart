import 'package:flutter/material.dart';

import '../../components/toly_switch_list_tile.dart';
import '../../manager/app_theme_manager.dart';

class ThemeModeSettingPage extends StatefulWidget {
  const ThemeModeSettingPage({Key? key}) : super(key: key);

  @override
  State<ThemeModeSettingPage> createState() => _ThemeModeSettingPageState();
}

class _ThemeModeSettingPageState extends State<ThemeModeSettingPage> {
  @override
  void initState() {
    super.initState();
    kAppThemeManager.addListener(_onDarkThemeChange);
  }

  void _onDarkThemeChange() {
    setState(() {});
  }

  @override
  void dispose() {
    kAppThemeManager.removeListener(_onDarkThemeChange);
    super.dispose();
  }

  void _changeWithSystem(bool value){
      ThemeMode newModel;
      if (value) {
        newModel = ThemeMode.system;
      } else {
        newModel = ThemeMode.light;
      }
      kAppThemeManager.mode = newModel;
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode mode = kAppThemeManager.mode;
    const TextStyle title = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const TextStyle subtitle = TextStyle(fontSize: 12, color: Colors.grey);
    return Scaffold(
      appBar: AppBar(title: const Text('深色模式')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 15),
          TolySwitchListTile(
            title: const Text('跟随系统', style: title),
            subtitle: const Text('开启后，将跟随系统打开或关闭深色模式',style: subtitle),
            value: mode == ThemeMode.system,
            onChanged: _changeWithSystem,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 16, bottom: 6),
            child: Text("手动设置"),
          ),
          _buildItemTile(ThemeMode.light,mode),
          const Divider(),
          _buildItemTile(ThemeMode.dark,mode),
        ],
      ),
    );
  }

  Widget _buildItemTile(ThemeMode model,ThemeMode activeModel){
    bool active = model == activeModel;
    Color iconColor = Theme.of(context).primaryColor;
    return ListTile(
      title: Text(kThemeModeMap[model]!),
      onTap: () => kAppThemeManager.mode = model,
      trailing: active ? Icon(Icons.check, size: 20, color: iconColor) : null,
    );
  }
}
