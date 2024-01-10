import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _total = 1024;
  final double notifyThreshold = 0.8;
  int _usage = 0;

  String useMsg = '磁盘使用记录:\n';
  String smsMsg = '消息通知记录:\n';

  final TextEditingController _useSize = TextEditingController();

  void use(int size) {
    if (_total - _usage < size) {
      String message = '[磁盘警告]: 磁盘已满,无法使用。 [用量: $_usage/$_total]';
      smsMsg += "$message\n";
      return;
    }
    _usage += size;
    String message = '[磁盘使用]:$size , [用量: $_usage/$_total]';
    useMsg += "$message\n";

    if (_usage > _total * notifyThreshold) {
      String message = '[磁盘警告]: 磁盘容量已超过:${(notifyThreshold * 100).toStringAsFixed(1)}% [用量: $_usage/$_total]';
      smsMsg += "$message\n";
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
              style: const TextStyle(fontSize: 14),
              controller: _useSize,
              placeholder: '输入磁盘使用量',
              placeholderStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            ))
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                int? useSize = int.tryParse(_useSize.text);
                if (useSize != null) {
                  use(useSize);
                  setState(() {});
                }
              },
              icon: const Icon(Icons.not_started_outlined))
        ],
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(
                        Icons.data_thresholding_outlined,
                        size: 42,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '磁盘 001',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '用量: $_usage/$_total',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        _usage = 0;
                        useMsg = '磁盘使用记录:\n';
                        smsMsg = '消息通知记录:\n';
                        setState(() {});
                      },
                      child: const Text('格式化'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Stack(alignment: Alignment.center, children: [
                      CircularProgressIndicator(
                        value: _usage / _total,
                        backgroundColor: Colors.green,
                      ),
                      Text(
                        '${((_usage / _total) * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ])
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  useMsg,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  smsMsg,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _useSize.dispose();
    super.dispose();
  }
}
