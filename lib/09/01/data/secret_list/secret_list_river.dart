import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'model/secret.dart';
import 'model/secrets_state.dart';

part 'secret_list_river.g.dart';


@riverpod
class SecretList extends _$SecretList {
  @override
  Future<SecretsState> build() async {
    return SecretsState(
      secrets: await _fetchSecretList(),
      activeSecret: null,
    );
  }

  void active(Secret secret) {
    if (state.value != null) {
      state = AsyncValue.data(state.value!.copyWith(activeSecret: secret));
    }
  }

  void addSecret(String title) async {
    if (state.value == null) return;
    state = const AsyncValue.loading();
    List<Secret> secrets = state.value!.secrets;
    try {
      Secret secret = await _insertSecret(title);
      state = AsyncValue.data(SecretsState(
        secrets: [secret, ...secrets],
        activeSecret: secret,
      ));
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<List<Secret>> _fetchSecretList() async {
    /// 模拟网络异步请求
    await Future.delayed(const Duration(seconds: 1));
    String data = await rootBundle.loadString("assets/data/secret.json");
    return (json.decode(data) as List).map(Secret.fromMap).toList();
  }

  Future<Secret> _insertSecret(String title) async {
    /// 模拟网络异步请求
    await Future.delayed(const Duration(seconds: 1));
    /// 校验是否已经存在
    List<Secret> secrets = state.value!.secrets;
    if (secrets.where((e) => e.title == title).isNotEmpty) {
      throw "领域名已存在:$title";
    }
    int now = DateTime.now().millisecondsSinceEpoch;
    Secret newSecret = Secret(
      title: title,
      secret: null,
      createAt: now,
      updateAt: now,
    );
    return newSecret;
  }
}
