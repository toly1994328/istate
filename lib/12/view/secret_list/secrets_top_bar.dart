import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../secret_search/secret_search_page.dart';
import 'dialog/add_secret_dialog.dart';

class SecretsTopBar extends StatelessWidget implements PreferredSizeWidget {
  const SecretsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    return AppBar(
      leading: Icon(Icons.security, size: 22, color: themeColor),
      leadingWidth: 42,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      titleSpacing: 0,
      title: Center(
        child: GestureDetector(
          onTap: () => _toSearchPage(context),
          child: Container(
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.search,color: Colors.grey,size: 20,),
                ),
                Text('搜索领域',style: TextStyle(fontSize: 14,color: Colors.grey),),
              ],
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => _showAddDialog(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _toSearchPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SecretSearchPage()),
    );
  }

  void _showAddDialog(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      context: context,
      builder: (_) => const AddSecretDialog(),
    );
  }
}
