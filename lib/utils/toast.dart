import 'package:flutter/material.dart';

extension ToastContext on BuildContext {

  void toast(Color color, String msg) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(backgroundColor: color, content: Text(msg)),
    );
  }

  void warning(String msg) => toast(Colors.orange, msg);

  void error(String msg) => toast(Colors.red, msg);

  void success(String msg) => toast(Colors.green, msg);
}

extension HideKeyContext on BuildContext {

  void hideKey() {
    final FocusScopeNode focusScope = FocusScope.of(this);
    if (focusScope.hasFocus) {
      focusScope.unfocus();
    }
  }
}