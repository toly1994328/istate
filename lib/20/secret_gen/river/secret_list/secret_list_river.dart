import '../../data/data.dart';

import 'secret_list_river_op.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'state/secrets_state.dart';

part 'secret_list_river.g.dart';

@riverpod
class SecretList extends _$SecretList {
  @override
  Future<SecretsState> build() async {
    ref.listen(secretListOpProvider, _listenOpChange);
    var ret = await secretListRepository.fetch();
    return SecretsState(
      secrets: ret.data,
      pagination: ret.pagination,
    );
  }

  void active(Secret secret) {
    if (state.value != null) {
      state = AsyncValue.data(state.value!.copyWith(activeSecret: secret));
    }
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

    if (previous?.value?.op is NoneOp && next.value?.op is EditOp) {
      Object? ret = next.value?.data;
      if (ret is (Secret,Secret)) {
        whenEditSecret(ret);
      }
    }

    if (previous?.value?.op is NoneOp && next.value?.op is RefreshOp) {
      Object? data = next.value?.data;
      if (data is PagedResult<Secret>) {
        whenRefreshDone(data);
      }
    }

    if (previous?.value?.op is NoneOp && next.value?.op is LoadMoreOp) {
      Object? data = next.value?.data;
      if (data is PagedResult<Secret>) {
        whenLoadMoreDone(data);
      }
    }

    if (previous?.value?.op is NoneOp && next.value?.op is DeleteOp) {
      Object? data = next.value?.data;
      if (data is Secret) {
        whenDeleteDone(data);
      }
    }
  }

  void whenAddSecret(Secret secret) {
    if (state.value == null) return;
    SecretsState prev = state.value!;
    SecretsState next =
        prev.copyWith(secrets: [secret, ...prev.secrets], activeSecret: secret);

    state = AsyncValue.data(next);
  }

  void whenUpdateSecret(Secret secret) {
    if (state.value == null) return;
    SecretsState prev = state.value!;
    prev.secrets.removeWhere((e) => e.title == secret.title);
    SecretsState next =
        prev.copyWith(secrets: [secret, ...prev.secrets], activeSecret: secret);
    state = AsyncValue.data(next);
  }

  void whenEditSecret((Secret,Secret) secret) {
    if (state.value == null) return;
    SecretsState prev = state.value!;
    prev.secrets.removeWhere((e) => e.title == secret.$1.title);
    SecretsState next =
    prev.copyWith(secrets: [secret.$2, ...prev.secrets]);
    state = AsyncValue.data(next);
  }

  void whenRefreshDone(PagedResult<Secret> result) {
    if (state.value == null) return;
    SecretsState prev = state.value!;
    state = AsyncValue.data(
        prev.copyWith(secrets: result.data, pagination: result.pagination));
  }

  void whenLoadMoreDone(PagedResult<Secret> result) {
    if (state.value == null) return;
    SecretsState prev = state.value!;
    state = AsyncValue.data(
      prev.copyWith(
          secrets: [...prev.secrets, ...result.data],
          pagination: result.pagination),
    );
  }

  void whenDeleteDone(Secret secret) {
    if (state.value == null) return;
    SecretsState prev = state.value!;
    prev.secrets.removeWhere((e) => e.title == secret.title);
    state = AsyncValue.data(
      prev.copyWith(secrets: [...prev.secrets]),
    );
  }
}
