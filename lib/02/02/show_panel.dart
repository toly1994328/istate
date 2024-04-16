import 'package:flutter/material.dart';

class ShowPanel extends StatelessWidget {
  final String desc;
  final String value;

  const ShowPanel({super.key, required this.desc, required this.value});

  @override
  Widget build(BuildContext context) {
    const TextStyle valueStyle = TextStyle(fontSize: 28);
    const TextStyle descStyle = TextStyle(color: Colors.grey);
    return Column(
      children: [
        Text(desc, style: descStyle),
        Text(value, style: valueStyle),
      ],
    );
  }
}
