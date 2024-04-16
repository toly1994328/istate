import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String>? onChanged;
  const AppTopBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    const InputDecoration decoration = InputDecoration(border: InputBorder.none, hintText: '输入字母');
    return AppBar(
      title: TextField(
        autocorrect: false,
        onChanged: onChanged,
        decoration: decoration,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
