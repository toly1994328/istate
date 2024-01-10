import 'models.dart';

class SearchResult {
  const SearchResult({required this.items});

  factory SearchResult.fromJson(dynamic json) {
    return SearchResult(
      items: json['items'].map<SearchResultItem>(SearchResultItem.fromJson).toList(),
    );
  }

  final List<SearchResultItem> items;
}

class SearchResultItem {
  const SearchResultItem({
    required this.fullName,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.owner,
  });

  factory SearchResultItem.fromJson(dynamic json) {
    return SearchResultItem(
      fullName: json['full_name'],
      htmlUrl: json['html_url'],
      stargazersCount: json['stargazers_count'],
      owner: GithubUser.fromJson(json['owner']),
    );
  }

  final String fullName;
  final String htmlUrl;
  final int stargazersCount;
  final GithubUser owner;
}

