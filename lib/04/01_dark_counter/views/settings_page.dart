import 'package:flutter/material.dart';

import '../manager/app_theme_manager.dart';
import 'settings/theme_model_setting_page.dart';
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
        children: <Widget>[Container(height: 15), const ThemSettingItem()],
      ),
    );
  }
}

class ThemSettingItem extends StatefulWidget {
  const ThemSettingItem({super.key});

  @override
  State<ThemSettingItem> createState() => _ThemSettingItemState();
}

class _ThemSettingItemState extends State<ThemSettingItem> {
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

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.style, color: primaryColor),
      title: const Text('深色模式', style: titleStyle),
      subtitle: Text(kAppThemeManager.title, style: subStyle),
      trailing: Icon(Icons.chevron_right, color: primaryColor),
      onTap: _toThemeModeSettingPage,
    );
  }

  void _toThemeModeSettingPage(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ThemeModeSettingPage()),
    );
  }
}
