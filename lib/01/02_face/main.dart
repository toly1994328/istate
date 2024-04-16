import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum Face {
  clam, // 冷静
  smail, // 微笑
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
      home: const MyHomePage(title: '表情变化器'),
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

  Face _face = Face.clam;

  String get imageSrc => switch (_face) {
        Face.clam => 'assets/images/clam.png',
        Face.smail => 'assets/images/smail.png',
      };

  Color? get buttonColor => switch (_face) {
    Face.clam => Colors.blue,
    Face.smail => Colors.redAccent,
  };


  Widget get icon => switch (_face) {
    Face.clam => const Icon(Icons.exposure_plus_1),
    Face.smail => const Icon(Icons.exposure_minus_1),
  };

  void _incrementCounter() {
    setState(() {
      int nextIndex= (_face.index+1) % Face.values.length;
      _face = Face.values[nextIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              // 'You have pushed the button this many times:',
              '你现在的表情:',
            ),
            const SizedBox(height: 12,),
            SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(imageSrc)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        onPressed: _incrementCounter,
        tooltip: '增加',
        // tooltip: 'Increment',
        child: icon,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
