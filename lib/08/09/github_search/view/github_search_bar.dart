import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../river/github_search_river.dart';

class GithubSearchBar extends ConsumerWidget {
  final TextEditingController controller;

  const GithubSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      autocorrect: false,
      onChanged: (v){
        // ref.invalidate(githubSearchRiverProvider(args: v));
        // ref.read(githubSearchRiverProvider(args: v).future);
        // ref.refresh(githubSearchRiverProvider(args: v));
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
    // _textController.text = '';
    // ref.read(githubSearchRiverProvider( args: ''));
  }
}
