import 'package:flutter/material.dart';

import 'app_top_bar.dart';
import 'show_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = '';

  String get upperValue => _text.toUpperCase();
  String get lowerValue => _text.toLowerCase();

  String get firstUpCase{
    if(_text.isEmpty) return '';
    String p0 = _text.substring(0,1).toUpperCase();
    String p1 = _text.substring(1).toLowerCase();
    return '$p0$p1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(onChanged: _updateText,),
      body: Row(
        children: [
          Expanded(child: ShowPanel(value: lowerValue, desc: '将输入变为小写字母',)),
          Expanded(child: ShowPanel(value: upperValue, desc: '将输入变为大写字母',)),
          Expanded(child: ShowPanel(value: firstUpCase, desc: '将输入首字母大写',)),
        ],
      ),
    );
  }

  void _updateText(String text) {
    setState(() {
      _text = text;
    });
  }
}
