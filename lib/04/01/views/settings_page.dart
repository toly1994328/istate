import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings/theme_model_setting_page.dart';

import '../manager/app_theme_provider.dart';

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

class ThemSettingItem extends StatelessWidget{
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
      onTap: ()=>_toThemeModeSettingPage(context),
    );
  }

  void _toThemeModeSettingPage(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ThemeModeSettingPage()),
    );
  }
}
