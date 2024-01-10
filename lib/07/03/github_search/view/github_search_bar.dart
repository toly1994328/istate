import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/github_search_bloc.dart';
import '../bloc/github_search_event.dart';

class GithubSearchBar extends StatefulWidget {
  const GithubSearchBar({super.key});

  @override
  State<GithubSearchBar> createState() => _GithubSearchBarState();
}

class _GithubSearchBarState extends State<GithubSearchBar> {
  final _textController = TextEditingController();
  late GithubSearchBloc _githubSearchBloc;

  @override
  void initState() {
    super.initState();
    _githubSearchBloc = context.read<GithubSearchBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        _githubSearchBloc.add(TextChanged(text: text));
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: GestureDetector(
          onTap: _onClearTapped,
          child: const Icon(Icons.clear),
        ),
        border: InputBorder.none,
        hintText: '输入 Github 项目关键字',
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    _githubSearchBloc.add(const TextChanged(text: ''));
  }
}
