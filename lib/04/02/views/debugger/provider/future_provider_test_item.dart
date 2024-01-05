import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 异步任务状态
sealed class NetState{}

class NetLoading extends NetState{}

class NetFailure extends NetState{
  final String error;
  NetFailure(this.error);
}

class NetSuccess extends NetState{
  final String data;
  NetSuccess(this.data);
}


class Api {
  static Future<NetState> query(BuildContext context) async {
    /// 模拟请求
    await Future.delayed(const Duration(seconds: 2));
    return NetSuccess('4篇');
  }
}

class FutureProviderTestItem extends StatelessWidget {
  const FutureProviderTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
      title: const Text('FutureProvider 测试', style: titleStyle),
      subtitle: const Text('共享异步任务结果(一次性)', style: subStyle),
      trailing: const FutureResultBox(),
      // onTap: context.read<CountModel>().increment,
    );
  }
}

class FutureResultBox extends StatelessWidget {
  const FutureResultBox({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(color: Colors.white);

    NetState result = context.watch<NetState>();
    Widget child = switch(result){
      NetLoading() => const CupertinoActivityIndicator(color: Colors.white),
      NetFailure() => const Icon(Icons.error_outlined,color: Colors.red,),
      NetSuccess() => Text(result.data, style: style),
    };
    BorderRadius radius = BorderRadius.circular(4);
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blue, borderRadius: radius),
      child: child ,
    );
  }
}
