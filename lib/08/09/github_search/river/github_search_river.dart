import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/search_result.dart';
import '../data/repository/github_repository.dart';

part 'github_search_river.g.dart';

@riverpod
GithubRepository githubRepository(GithubRepositoryRef ref) => GithubRepository();

final GithubRepository repository = GithubRepository();

/// github 搜索结果类形
/// 数据列表 + 搜索参数 的元组
typedef GithubSearchResult = (List<RepositoryInfo>, String);

@riverpod
Future<GithubSearchResult> githubSearchRiver(
    GithubSearchRiverRef ref, {
      String args = '',
    }) async {
  ref.keepAlive();
  print("========githubSearch:${args}========");
  ref.onDispose(() {
    print("========onDispose:GithubSearchRiverRef【${ref.args}】========");

  });
  if (args.isEmpty) {
    return (<RepositoryInfo>[], args);
  }
  final result = await ref
      .watch(githubRepositoryProvider)
      .search(args);
  // final result = await repository.search(args);
  print(result);
  return (result.items, args);
}


// // 或者替代方案，“通知者程序”
// @riverpod
// class GithubSearchRiver extends _$GithubSearchRiver {
//   /// 通知者程序参数在构建方法上指定。
//   /// 可以有任意数量的通知者程序参数，可以是任意的变量名称，甚至可以是可选/命名的参数。
//   @override
//   Future<GithubSearchResult> build({String args=''}) async {
//     print("========githubSearch:${args}=========");
//     if (args.isEmpty) {
//       return (<RepositoryInfo>[], args);
//     }
//
//     final result = await repository.search(args);
//     print(result);
//     return (result.items, args);
//   }
// }
