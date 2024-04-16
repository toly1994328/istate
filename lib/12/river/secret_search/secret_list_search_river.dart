import '../../data/data.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'secrets_search_state.dart';

part 'secret_list_search_river.g.dart';

@riverpod
class SecretSearchList extends _$SecretSearchList {
  @override
  Future<SecretsSearchState> build() async {
    return SecretsSearchState.none();
  }

  void search(String arg) async {
    print("======doSearch:$arg===============");
    if (state.value == null) return;
    if (arg.isEmpty) {
      state = AsyncValue.data(SecretsSearchState.none());
      return;
    }
    SecretsSearchState prev = state.value!;
    state = AsyncValue.data(prev.copyWith(arg: arg));
    state = const AsyncValue.loading();
    try {
      PagedResult<Secret> secretsRet = await secretListRepository.search(arg);

      // throw "网络异常,搜索失败!";
      state = AsyncValue.data(
        prev.copyWith(
          secrets: secretsRet.data,
          pagination: secretsRet.pagination,
          arg: arg,
        ),
      );
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }
}
