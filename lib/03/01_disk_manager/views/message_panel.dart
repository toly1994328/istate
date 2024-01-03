import 'package:flutter/material.dart';

class MessagePanel extends StatefulWidget {
  final String message;
  const MessagePanel({super.key,required this.message});

  @override
  State<MessagePanel> createState() => _MessagePanelState();
}

class _MessagePanelState extends State<MessagePanel> {



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
      child:  SingleChildScrollView(
        child: Text(
          widget.message,style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}