import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/models.dart';
import '../river/github_search_river.dart';

class GithubSearchBody extends ConsumerWidget {
  final TextEditingController controller;

  const GithubSearchBody({required this.controller, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<GithubSearchResult> result = ref.watch(
      githubSearchRiverProvider(args: controller.text),
    );
    print("=======GithubSearchBody#build==============");
    return result.when(
      skipLoadingOnRefresh: true,
      data: (GithubSearchResult value) => value.$2.isEmpty
          ? const Text('未输入内容')
          : SearchResultsView(items: value.$1),
      error: (err, stack) => Text(result.error.toString()),
      loading: () => const CircularProgressIndicator.adaptive(),
    );
    return Center(
      child: switch (result) {
        AsyncData(:final value) => value.$2.isEmpty
            ? const Text('未输入内容')
            : SearchResultsView(items: value.$1),
        AsyncError() => Text(result.error.toString()),
        AsyncLoading() => const CircularProgressIndicator.adaptive(),
        _ => throw UnimplementedError(),
      },
    );
  }
}

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key, required this.items});

  final List<RepositoryInfo> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const Text('未搜索到结果');
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: items[index]);
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({required this.item});

  final RepositoryInfo item;

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(item.owner.avatarUrl),
      ),
      title: Text(item.fullName),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: [
          const Text(
            'star',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            item.stargazersCount.toString(),
            style: TextStyle(color: themeColor),
          ),
        ],
      ),
      onTap: () => launchUrl(Uri.parse(item.htmlUrl)),
    );
  }
}
