import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

import '../data/input_record.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<InputRecord> _record = [];
  final StreamController<String> _inputCtrl = StreamController();
  StreamSubscription<String>? _subscription;

  @override
  void initState() {
    _subscription = _inputCtrl.stream
        .debounce(const Duration(milliseconds: 500))
        .listen(_updateText);
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _inputCtrl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autocorrect: false,
          onChanged: _inputCtrl.add,
          // onChanged: _updateText,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '请输入字符',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _record.length,
        itemBuilder: (_, index) => ListTile(
          dense: true,
          title: Text('输入:${_record[index].value}'),
          trailing: Text('时间:${_record[index].time}'),
        ),
      ),
    );
  }

  void _updateText(String text) {
    setState(() {
      _record.add(
        InputRecord(time: DateTime.now().toIso8601String(), value: text),
      );
    });
  }
}
