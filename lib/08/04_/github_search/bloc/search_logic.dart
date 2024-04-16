import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/search_result.dart';
import '../data/repository/github_repository.dart';
part 'search_logic.g.dart';

@riverpod
GithubRepository githubRepository(GithubRepositoryRef ref) => GithubRepository();

@riverpod
Future<List<RepositoryInfo>> githubSearch(
    GithubSearchRef ref, {
      String search = '',
    }) async {

  if (search.isEmpty) {
    return [];
  }

  // Debouncing searches by delaying the request.
  // If the search was cancelled during this delay, the network request will
  // not be performed.
  await Future<void>.delayed(const Duration(milliseconds: 250));

  final result = await ref.watch(githubRepositoryProvider).search(search);
  return result.items;
}