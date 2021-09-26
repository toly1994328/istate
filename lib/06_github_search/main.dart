import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/api/github_cache.dart';
import 'repository/api/github_client.dart';
import 'repository/api/github_repository.dart';
import 'bloc/github_search_bloc.dart';
import 'view/search_page.dart';

void main() {
  final GithubRepository githubRepository = GithubRepository(
    GithubCache(),
    GithubClient(),
  );
  runApp(App(githubRepository: githubRepository));
}

class App extends StatelessWidget {
  const App({Key? key, required this.githubRepository}) : super(key: key);

  final GithubRepository githubRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Search',
      home: Scaffold(
        appBar: AppBar(title: const Text('Github Search')),
        body: BlocProvider(
          create: (_) => GithubSearchBloc(githubRepository: githubRepository),
          child: const SearchPage(),
        ),
      ),
    );
  }
}
