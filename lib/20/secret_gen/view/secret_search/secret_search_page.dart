import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:istate/utils/toast.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../data/model/secret.dart';
import '../../river/secret_search/search_history.dart';
import '../../river/secret_search/secrets_search_state.dart';

import '../../river/secret_search/secret_list_search_river.dart';
import '../../river/secret_list/secret_list_river.dart';
import 'search_history_record.dart';
import 'search_secret_list_view.dart';
import '../secret_gen/secret_gen_page.dart';

class SecretSearchPage extends StatelessWidget {
  const SecretSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchTopBar(),
      body: Column(
        children: [
          SearchHistoryRecord(),
          Expanded(child: SearchSecretContent())
        ],
      ),
    );
  }
}

class SearchSecretContent extends ConsumerWidget {
  const SearchSecretContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void onSelect(Secret secret, String arg) {
      ref.read(secretListProvider.notifier).active(secret);
      ref.read(searchHistoryProvider.notifier).addHistory(arg);
      context.hideKey();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SecretGenPage(secret: secret)),
      );
    }

    return ref.watch(secretSearchListProvider).when(
          data: (state) => SearchSecretListView(
              state: state, onSelect: (s) => onSelect(s, state.arg)),
          error: (error, __) => Center(
              child: Text(
            "搜索异常\n$error",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.redAccent),
          )),
          loading: () => const Center(child: CupertinoActivityIndicator()),
        );
  }
}

class SearchTopBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      titleSpacing: 0,
      title: Row(
        children: [const SizedBox(width: 16), Expanded(child: SearchInput())],
      ),
      actions: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 46,
                child: Center(
                    child: Text(
                  '取消',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                )))),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchInput extends ConsumerStatefulWidget {
  const SearchInput({super.key});

  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  final TextEditingController _ctrl = TextEditingController();

  final StreamController<String> _event = StreamController();
  @override
  void initState() {
    super.initState();
    _event.stream.debounce(const Duration(milliseconds: 200)).listen(search);
  }

  @override
  void dispose() {
    _event.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(secretSearchListProvider, _listenChange);
    return CupertinoTextField(
      controller: _ctrl,
      placeholder: '搜索领域名称',
      autofocus: true,
      onChanged: _event.add,
      prefix: const Padding(
        padding: EdgeInsets.only(left: 6.0),
        child: Icon(Icons.search, size: 20, color: Colors.grey),
      ),
      suffix: _buildSuffix(),
      style: const TextStyle(fontSize: 14),
      // enabled: false,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
    );
  }

  Widget _buildSuffix() {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: _ctrl,
        builder: (_, value, __) {
          if (value.text.isNotEmpty) {
            return GestureDetector(
              onTap: () => search(''),
              child: const Padding(
                  padding: EdgeInsets.only(right: 6.0),
                  child: Icon(
                    CupertinoIcons.clear_circled,
                    color: Colors.grey,
                    size: 18,
                  )),
            );
          }
          return const SizedBox();
        });
  }

  void search(String value) {
    ref.read(secretSearchListProvider.notifier).search(value);
  }

  void _listenChange(AsyncValue<SecretsSearchState>? previous,
      AsyncValue<SecretsSearchState> next) {
    if (next.value?.arg != previous?.value?.arg) {
      _ctrl.text = next.value?.arg ?? '';
    }
  }


}
