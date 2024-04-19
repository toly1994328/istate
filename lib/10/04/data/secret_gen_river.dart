import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'secret_gen_river.g.dart';

@riverpod
Future<int> secretGen(SecretGenRef ref) async{
  await Future.delayed(const Duration(seconds: 1));
  // throw "系统异常 0x28，无法生成秘钥!";
  return Random().nextInt(1000000);
}
