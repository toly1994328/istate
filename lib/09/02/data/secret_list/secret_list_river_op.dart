import 'secret_list_river.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'model/secret.dart';
import 'model/secret_op_state.dart';

part 'secret_list_river_op.g.dart';

@riverpod
class SecretListOp extends _$SecretListOp {
  @override
  Future<SecretListOpState> build() async {
    return SecretListOpState(op: const NoneOp());
  }

  void _setNoneOp() {
    state = AsyncValue.data(SecretListOpState(op: const NoneOp()));
  }

  void addSecret(AddOp op) async {
    state = const AsyncValue.loading();
    try {
      Secret secret = await _insertSecret(op.title);
      state = AsyncValue.data(SecretListOpState(
        op: op,
        data: secret,
      ));
      _setNoneOp();
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  void pushSecret(PushOp op) async {
    state = const AsyncValue.loading();
    try {
      Secret secret = await _pushSecret(op.secret);
      state = AsyncValue.data(SecretListOpState(
        op: op,
        data: secret,
      ));
      _setNoneOp();
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<Secret> _insertSecret(String title) async {
    /// 模拟网络异步请求
    await Future.delayed(const Duration(seconds: 1));

    /// 校验是否已经存在
    List<Secret> secrets = ref.read(secretListProvider).value?.secrets ?? [];
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

  Future<Secret> _pushSecret( String value) async {
    /// 模拟网络异步请求
    await Future.delayed(const Duration(seconds: 1));
    Secret? active = ref.read(secretListProvider).value?.activeSecret;
    /// 模拟更新后的数据，可通过接口返回
    return Secret(
      title: active?.title??'',
      secret: value,
      createAt: active?.createAt ?? DateTime.now().millisecondsSinceEpoch,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
