import 'dart:async';
import '../models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class GithubRepository {

  static const String kSearchUrl = 'https://api.github.com/search/repositories?q=';

  final Map<String, SearchResult> _cache = {};
  final http.Client _client = http.Client();

  Future<SearchResult> search(String term) async {
    final cachedResult = _cache[term];
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await searchApi(term);
    _cache[term] = result;
    return result;
  }

  Future<SearchResult> searchApi(String term) async {
    final response = await _client.get(Uri.parse('$kSearchUrl$term'));
    final dynamic results = json.decode(response.body);

    if (response.statusCode == 200) {
      return SearchResult.fromJson(results);
    } else {
      throw '访问异常:$results';
    }
  }
}
