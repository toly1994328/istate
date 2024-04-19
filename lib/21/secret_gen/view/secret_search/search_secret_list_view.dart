
import 'package:flutter/material.dart';
import '../../data/model/secret.dart';
import '../../river/secret_search/secrets_search_state.dart';


class SearchSecretListView extends StatelessWidget {
  final ValueChanged<Secret> onSelect;
  final SecretsSearchState state;
  const SearchSecretListView({super.key, required this.state, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    if(state.secrets.isEmpty&&state.arg.isNotEmpty){
      return const Center(child: Text("未搜索到数据"));
    }
    return ListView.builder(
      itemCount:state.secrets.length,
      itemBuilder: (_, i) => _buildItem(context, state.secrets[i]),
    );
  }

  Widget  _buildItem(BuildContext context, Secret secret) {
    return ListTile(
      dense: true,
      onTap: () => onSelect(secret),
      title: Text.rich(formSpan(secret.title, state.arg)),
      subtitle: Text(secret.secretStr),
    );
  }

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.red,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  InlineSpan formSpan(String src, String pattern) {
    List<TextSpan> span = [];
    RegExp regExp = RegExp(pattern, caseSensitive: false);
    src.splitMapJoin(regExp, onMatch: (Match match) {
      span.add(TextSpan(text: match.group(0), style: lightTextStyle));
      return '';
    }, onNonMatch: (str) {
      span.add(TextSpan(
          text: str,
          style: lightTextStyle.copyWith(color: const Color(0xff2F3032),fontWeight: FontWeight.normal)));
      return '';
    });
    return TextSpan(children: span);
  }
}
