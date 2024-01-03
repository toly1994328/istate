import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'manager/disk_manager.dart';
import 'views/disk_view.dart';
import 'views/message_panel.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'istate',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '磁盘管理模拟'),
    );
  }
}

final DiskManager kDiskManager = DiskManager(1024,notify: DiskEventMessage());

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String useMsg ='磁盘使用记录:\n';
  String smsMsg ='消息通知记录:\n';

  late DiskManager _diskManager;

  @override
  void initState() {
    super.initState();
    kDiskManager.notify.addListener(_handleDiskMessage);
  }

  @override
  void dispose() {
    super.dispose();
    kDiskManager.notify.removeListener(_handleDiskMessage);
  }

  final TextEditingController _useSize = TextEditingController(text: '100');

  void _handleDiskMessage(){
    NotifyStatus status = kDiskManager.notify.status;
    String message = kDiskManager.notify.msg;
    switch(status){
      case NotifyStatus.log:
        useMsg+="$message\n";
        break;
      case NotifyStatus.threshold:
      case NotifyStatus.full:
        smsMsg+="$message\n";
        break;
    }
  }

  void _useDisk(){
    int? useSize = int.tryParse(_useSize.text);
    if(useSize!=null){
      _diskManager.use(useSize);
      setState(() {

      });
    }
  }

  void _reset(){
    _diskManager.reset();
    useMsg = '磁盘使用记录:\n';
    smsMsg = '消息通知记录:\n';
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(widget.title),
            ),
            Expanded(
                child: CupertinoTextField(
              style: TextStyle(fontSize: 14),
              controller: _useSize,
              placeholder: '输入磁盘使用量',
              placeholderStyle: TextStyle(fontSize: 14, color: Colors.grey),
            ))
          ],
        ),
        actions: [
          IconButton(onPressed: _useDisk, icon: Icon(Icons.not_started_outlined))
        ],
      ),
      body: Column(
        children: <Widget>[
          DiskView(
            id: '磁盘 001',
            usage: _diskManager.usage,
            total: _diskManager.total,
            onReset: _reset,
          ),
          Expanded(
            child: MessagePanel(message: useMsg,),
          ),
          Expanded(
            child: MessagePanel(message: smsMsg,),
          ),
        ],
      ),
    );
  }
}




