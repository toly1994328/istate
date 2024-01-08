import 'package:flutter/material.dart';
import '../debugger/debugger_page.dart';

import '../settings/settings_page.dart';
import 'user_info_panel.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color? color =Theme.of(context).listTileTheme.tileColor;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.only(top: 56, right: 18, left: 18),
            color: color,
            child: UserInfoPanel(),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.settings,color: primaryColor,),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SettingsPage()),
              );
            },
            title: Text('系统设置'),
            trailing: Icon(Icons.chevron_right, color: primaryColor),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.bug_report_sharp,color: primaryColor,),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DebuggerPage()),
              );
            },
            title: Text('功能测试: provider'),
            trailing: Icon(Icons.chevron_right, color: primaryColor),
          ),
        ],
      ),
    );
  }
}
