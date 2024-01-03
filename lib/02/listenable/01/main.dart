import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'disk_manager.dart';

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
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '磁盘管理模拟'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {


  String useMsg ='磁盘使用记录:\n';
  String smsMsg ='消息通知记录:\n';

  late DiskManager _diskManager = DiskManager(1024);

  @override
  void initState() {
    super.initState();
    _diskManager = DiskManager(1024,callback: _handleDiskMessage);
  }

  final TextEditingController _useSize = TextEditingController();

  void _handleDiskMessage(NotifyStatus status,String message){
    if(status==NotifyStatus.log){
      useMsg+="$message\n";
    }
    if(status==NotifyStatus.log){
      useMsg+="$message\n";
    }

    else{
      smsMsg+="$message\n";
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
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DiskView(
              id: '磁盘 001',
              usage: _diskManager.usage,
              total: _diskManager.total,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:  Text(useMsg,style: TextStyle(fontSize: 12),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:  Text(
                  smsMsg,style: TextStyle(fontSize: 12),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiskView extends StatelessWidget {
  final int total;
  final int usage;
  final String id;

  const DiskView({
    super.key,
    required this.id,
    required this.total,
    required this.usage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.data_thresholding_outlined,
                size: 42,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '用量: $usage/$total',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            Stack(alignment: Alignment.center, children: [
              CircularProgressIndicator(
                value: usage / total,
                backgroundColor: Colors.green,
              ),
              Text(
                '${((usage / total) * 100).toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 10,color: Colors.grey),
              )
            ])
          ],
        ),
      ),
    );
  }
}