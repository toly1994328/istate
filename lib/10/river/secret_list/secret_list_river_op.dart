import '../../data/data.dart';
import '../river.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secret_list_river_op.g.dart';

@riverpod
class SecretListOp extends _$SecretListOp {
  static ListOpType _lastErrorOp = const NoneOp();

  static ListOpType get lastErrorOp => _lastErrorOp;

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
      Secret secret = await secretListRepository.insert(op.title);
      state = AsyncValue.data(SecretListOpState(
        op: op,
        data: secret,
      ));
      _setNoneOp();
    } catch (err, stack) {
      _lastErrorOp = op;
      state = AsyncValue.error(err, stack);
    }
  }

  void pushSecret(PushOp op) async {
    Secret? active = ref.read(secretListProvider).value?.activeSecret;
    if (active == null) return;
    state = const AsyncValue.loading();
    try {
      UpdateSecretPayload payload = UpdateSecretPayload(secret: op.secret);
      Secret secret = await secretListRepository.update(active, payload);
      state = AsyncValue.data(SecretListOpState(
        op: op,
        data: secret,
      ));
      _setNoneOp();
    } catch (err, stack) {
      _lastErrorOp = op;
      state = AsyncValue.error(err, stack);
    }
  }

  void refresh() async {
    state = const AsyncValue.loading();
    try {
      PagedResult<Secret> secretsRet = await secretListRepository.fetch();
      // throw "网络请求异常，请稍后重试!";
      state = AsyncValue.data(SecretListOpState(
        op: const RefreshOp(),
        data: secretsRet,
      ));
      _setNoneOp();
    } catch (err, stack) {
      _lastErrorOp = const RefreshOp();
      state = AsyncValue.error(err, stack);
    }
  }


  void loadMore() async {
    Pagination? pagination = ref.read(secretListProvider).value?.pagination;
    if (pagination == null) throw "数据异常,请重新加载";

    LoadMoreOp op = LoadMoreOp(pagination);
    state = const AsyncValue.loading();
    try {
      PagedResult<Secret> secretsRet = await secretListRepository.fetch(
        page: op.pagination.page + 1,
        pageSize: op.pagination.pageSize,
      );
      // throw "网络请求异常，请稍后重试!";
      state = AsyncValue.data(SecretListOpState(op: op, data: secretsRet));
      _setNoneOp();
    } catch (err, stack) {
      _lastErrorOp = op;
      state = AsyncValue.error(err, stack);
    }
  }
}
