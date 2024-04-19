import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secret_gen_river.g.dart';

enum OperationType { init, gen, fetch }

// OperationType op = OperationType.init;

@riverpod
class SecretGen extends _$SecretGen {

  static OperationType get op => _op;
  static OperationType _op = OperationType.init;

  @override
  Future<int> build() => _secretGen();

  Future<void> gen() async {
    _op = OperationType.gen;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_secretGen);
  }

  Future<int> _secretGen() async {
    await Future.delayed(const Duration(seconds: 1));
    // throw "系统异常 0x28，无法生成秘钥!";
    return Random().nextInt(1000000);
  }

  Future<void> fetch() async {
    _op = OperationType.fetch;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchFromServer);
  }

  Future<int> _fetchFromServer() async {
    // 模拟网络请求耗时
    await Future.delayed(const Duration(seconds: 1));
    throw "服务器异常 0x29，无法获取秘钥!";
    // 假如云端存储秘钥为 123456
    return 123456;
  }
}
