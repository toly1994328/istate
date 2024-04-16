import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'secret_list/model/secret.dart';
import 'secret_list/secret_list_river.dart';

part 'secret_gen_river.g.dart';

enum OperationType { init, gen, fetch,push }

// OperationType op = OperationType.init;

@riverpod
class SecretGen extends _$SecretGen {
  static OperationType get op => _op;
  static OperationType _op = OperationType.init;

  @override
  Future<String> build() async {
    _op =OperationType.init;
    Secret? active = ref.read(secretListProvider).value?.activeSecret;
    if (active != null && active.secret != null) {
      return active.secret!;
    }
    return _secretGen();
  }

  Future<void> gen() async {
    _op = OperationType.gen;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_secretGen);
  }

  Future<String> _secretGen() async {
    await Future.delayed(const Duration(seconds: 1));
    // throw "系统异常 0x28，无法生成秘钥!";
    return Random().nextInt(1000000).toString().padRight(6);
  }

  Future<void> fetch() async {
    _op = OperationType.fetch;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchFromServer);
  }

  Future<void> push(String data,String zone) async {
    _op = OperationType.push;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchFromServer);
  }

  Future<String> _fetchFromServer() async {
    // 模拟网络请求耗时
    await Future.delayed(const Duration(seconds: 1));
    // throw "服务器异常 0x29，无法获取秘钥!";
    // 假如云端存储秘钥为 123456
    return '123456';
  }

  Future<void> _pushToServer(String data,String zone) async {
    // 模拟网络请求耗时
    await Future.delayed(const Duration(seconds: 1));
    // throw "服务器异常 0x29，无法获取秘钥!";
    // ref.read(provider)
    return ;
  }
}
