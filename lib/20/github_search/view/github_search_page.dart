import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/github_repository.dart';

import '../bloc/github_search_bloc.dart';
import 'github_search_bar.dart';
import 'github_search_body.dart';

class GithubSearchPage extends StatelessWidget {
  final GithubRepository repository;

  const GithubSearchPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GithubSearchBloc(githubRepository: repository),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const GithubSearchBar()),
        body: const GithubSearchBody(),
      ),
    );
  }
}
