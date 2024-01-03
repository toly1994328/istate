import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

  // SmsSystem smsSystem = SmsSystem();
  // NotifyState notifyState = NotifyState();
  // DiskManager manager = DiskManager(1024,notifyState: notifyState);
  // notifyState.addListener(() {
  //   smsSystem.sendSms('18715079377', notifyState.value);
  // });
  //
  // ///callback: (String msg){
  // //     smsSystem.sendSms('18715079377', msg);
  // //   }
  // manager.use(100);
  // manager.use(200);
  // manager.use(300);
  // manager.use(250);
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
  int _counter = 0;
  int total = 1024;
  int _usage = 0;
  final double notifyThreshold = 0.8;

  String useMsg ='磁盘使用记录:\n';
  String smsMsg ='消息通知记录:\n';

  final TextEditingController _useSize = TextEditingController();

  void use(int size) {
    if(total-_usage<size){
      String message = '[磁盘警告]: 磁盘已满,无法使用。 [用量: $_usage/$total]';
      smsMsg+=message+"\n";
      return;
    }
    _usage += size;
    String message = '[磁盘使用]:$size , [用量: $_usage/$total]';
    useMsg+=message+"\n";

    if(_usage>total*notifyThreshold){
      String message = '[磁盘警告]: 磁盘容量已超过:${(notifyThreshold*100).toStringAsFixed(1)}% [用量: $_usage/$total]';
      smsMsg+=message+"\n";
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
          IconButton(onPressed: () {
            int? useSize = int.tryParse(_useSize.text);
            if(useSize!=null){
              use(useSize);
              setState(() {

              });
            }
          }, icon: Icon(Icons.not_started_outlined))
        ],
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DiskView(
              id: '磁盘 001',
              total: total,
              usage: _usage,
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

class SmsSystem {
  void sendSms(String phone, String message) {
    print('向 ${phone} 发送： $message');
  }
}

typedef DiskNotifyCallback = void Function(String message);

class NotifyState with ChangeNotifier {
  String _value = '';

  String get value => _value;

  set value(String msg) {
    _value = msg;
    notifyListeners();
  }
}

class DiskManager {
  int total;
  final double notifyThreshold;
  final NotifyState? notifyState;

  DiskManager(
    this.total, {
    this.notifyThreshold = 0.8,
    this.notifyState,
  });

  /// 用量
  int _usage = 0;

  void use(int size) {
    _usage += size;
    if (_usage > total * notifyThreshold) {
      /// 通知监听
      String message =
          '[磁盘警告]: 磁盘容量已超过:${(notifyThreshold * 100).toStringAsFixed(1)}% [用量: $_usage/$total]';
      notifyState?.value = message;
      // callback?.call(message);
    }
  }
}
