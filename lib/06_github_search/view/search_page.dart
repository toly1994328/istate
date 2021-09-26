import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/github_search_bloc.dart';
import '../bloc/github_search_state.dart';
import 'search_bar.dart';
import 'search_success_panel.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SearchBar(),
        BlocBuilder<GithubSearchBloc, GithubSearchState>(builder: _buildBodyByState)
      ],
    );
  }

  Widget _buildBodyByState(BuildContext context, GithubSearchState state) {
    if (state is SearchStateLoading) {
      return const CircularProgressIndicator();
    }
    if (state is SearchStateError) {
      return Text(state.error);
    }
    if (state is SearchStateSuccess) {
      return state.items.isEmpty
          ? const Text('No Results')
          : Expanded(child: SearchSuccessPanel(items: state.items));
    }
    return const Text('Please enter a term to begin');
  }
}


