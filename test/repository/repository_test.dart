import 'package:istate/06_github_search/repository/api/github_cache.dart';
import 'package:istate/06_github_search/repository/api/github_client.dart';
import 'package:istate/06_github_search/repository/api/github_repository.dart';
import 'package:istate/06_github_search/repository/models/search_result.dart';

void main() async{
  final GithubRepository githubRepository = GithubRepository(
    GithubCache(),
    GithubClient(),
  );

  SearchResult result = await githubRepository.search('FlutterUnit');
  print(result);
}