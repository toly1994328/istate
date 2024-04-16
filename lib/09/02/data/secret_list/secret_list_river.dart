import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'model/secret_op_state.dart';
import 'secret_list_river_op.dart';
import 'model/secret.dart';
import 'model/secrets_state.dart';

part 'secret_list_river.g.dart';

@riverpod
class SecretList extends _$SecretList {
  @override
  Future<SecretsState> build() async {
    ref.listen(secretListOpProvider, _listenOpChange);
    var data = await _fetchSecretList();
    return SecretsState(secrets: data);
  }

  void active(Secret secret) {
    if (state.value != null) {
      state = AsyncValue.data(state.value!.copyWith(activeSecret: secret));
      print(state.value?.activeSecret);
    }
  }

  Future<List<Secret>> _fetchSecretList() async {
    /// 模拟网络异步请求
    await Future.delayed(const Duration(seconds: 1));
    String data = await rootBundle.loadString("assets/data/secret.json");
    return (json.decode(data) as List).map(Secret.fromMap).toList();
  }

  void whenAddSecret(Secret secret) {
    if (state.value == null) return;
    List<Secret> secrets = state.value!.secrets;
    state = AsyncValue.data(SecretsState(
      secrets: [secret, ...secrets],
      activeSecret: secret,
    ));
  }

  void _listenOpChange(
    AsyncValue<SecretListOpState>? previous,
    AsyncValue<SecretListOpState> next,
  ) {
    if (previous?.value?.op is NoneOp && next.value?.op is AddOp) {
      Object? secret = next.value?.data;
      if (secret is Secret) {
        whenAddSecret(secret);
      }
    }

    if (previous?.value?.op is NoneOp && next.value?.op is PushOp) {
      Object? secret = next.value?.data;
      if (secret is Secret) {
        whenUpdateSecret(secret);
      }
    }
  }

  void whenUpdateSecret(Secret secret) {
    if (state.value == null) return;
    List<Secret> secrets = state.value!.secrets;
    secrets.removeWhere((e) => e.title == secret.title);
    state = AsyncValue.data(SecretsState(
      secrets: [secret, ...secrets],
      activeSecret: secret,
    ));
  }
}
