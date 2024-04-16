import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Row(
        children: [
          Expanded(child: _buildLowerCase(_text)),
          Expanded(child: _buildUpperCase(_text)),
          Expanded(child: _buildUpperCaseFirst(_text)),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    const InputDecoration decoration = InputDecoration(
      border: InputBorder.none,
      hintText: '输入字母',
    );

    return AppBar(
      title: TextField(onChanged: _updateText, decoration: decoration),
    );
  }

  Widget _buildLowerCase(String input) {
    const TextStyle style = TextStyle(fontSize: 28);
    input = input.toLowerCase();
    return Column(
      children: [
        const Text("将输入变为小写字母"),
        Text(input, style: style),
      ],
    );
  }

  Widget _buildUpperCase(String input) {
    const TextStyle style = TextStyle(fontSize: 28);
    input = input.toUpperCase();
    return Column(
      children: [
        const Text("将输入变为大写字母"),
        Text(input, style: style),
      ],
    );
  }

  Widget _buildUpperCaseFirst(String input) {
    String firstUpCase = '';
    if (input.isNotEmpty) {
      firstUpCase =
          '${_text.substring(0, 1).toUpperCase()}${_text.substring(1).toLowerCase()}';
    }

    return Column(
      children: [
        const Text("将输入首字母大写"),
        Text(
          firstUpCase,
          style: const TextStyle(fontSize: 28),
        )
      ],
    );
  }

  void _updateText(String text) {
    setState(() {
      _text = text;
    });
  }
}
