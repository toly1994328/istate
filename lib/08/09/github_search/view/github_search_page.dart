import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository/github_repository.dart';

import 'github_search_bar.dart';
import 'github_search_body.dart';

class GithubSearchPage extends StatefulWidget {

  const GithubSearchPage({super.key});

  @override
  State<GithubSearchPage> createState() => _GithubSearchPageState();
}

class _GithubSearchPageState extends State<GithubSearchPage> {
  TextEditingController controller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title:  GithubSearchBar(controller: controller,)),
      body: GithubSearchBody(controller:controller),
    );
  }
}
