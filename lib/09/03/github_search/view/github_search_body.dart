
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/github_search_bloc.dart';
import '../bloc/github_search_state.dart';
import '../data/models/models.dart';


class GithubSearchBody extends StatelessWidget {
  const GithubSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<GithubSearchBloc, GithubSearchState>(
        builder: (context, state) {
          return switch (state) {
            SearchStateEmpty() => const Text('未输入内容'),
            SearchStateLoading() => const CircularProgressIndicator.adaptive(),
            SearchStateError() => Text(state.error),
            SearchStateSuccess() => SearchResultsView(items: state.items),
          };
        },
      ),
    );
  }
}

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key, required this.items});

  final List<RepositoryInfo> items;

  @override
  Widget build(BuildContext context) {
    if(items.isEmpty) return const Text('未搜索到结果');
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
    Color themeColor =Theme.of(context).primaryColor;
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(item.owner.avatarUrl),
      ),
      title: Text(item.fullName),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: [
          const Text('star',style: TextStyle(color: Colors.grey),),
          Text(item.stargazersCount.toString(),style: TextStyle(color: themeColor),),
        ],
      ),
      onTap: () => launchUrl(Uri.parse(item.htmlUrl)),
    );
  }
}
