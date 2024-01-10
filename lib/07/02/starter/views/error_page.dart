import 'package:flutter/material.dart';

class AppStartErrorPage extends StatelessWidget {
  final String message;

  const AppStartErrorPage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.manage_history,color: Colors.white,))
        ],
        title: const Text(
          'App 启动失败',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
