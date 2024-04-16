import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../river/secret_search/search_history.dart';
import '../../river/secret_search/secret_list_search_river.dart';
import 'conform_clear_history_dialog.dart';

class SearchHistoryRecord extends ConsumerWidget {
  const SearchHistoryRecord({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void onDeleteHistory(String? value) {
      if (value != null) {
        ref.read(searchHistoryProvider.notifier).removeHistory(value);
      } else {
        showCupertinoModalPopup(
          context: context,
          builder: (_) => const ClearHistoryConformDialog(),
        );
      }
    }

    void onSelectHistory(String value){
      ref.read(secretSearchListProvider.notifier).search(value);
    }

    return ref.watch(searchHistoryProvider).when(
          data: (value) {
            String arg = ref.watch(secretSearchListProvider).value?.arg ?? '';
            if (arg.isEmpty) {
              return HistoryChips(
                history: value,
                onSelectHistory: onSelectHistory,
                onDeleteHistory: onDeleteHistory,
              );
            }
            return const SizedBox();
          },
          error: (_, __) => const SizedBox(),
          loading: () => const SizedBox(),
        );
  }
}

class HistoryChips extends StatefulWidget {
  final Set<String> history;
  final ValueChanged<String> onSelectHistory;
  final ValueChanged<String?> onDeleteHistory;

  const HistoryChips({
    super.key,
    required this.history,
    required this.onDeleteHistory,
    required this.onSelectHistory,
  });

  @override
  State<HistoryChips> createState() => _HistoryChipsState();
}

class _HistoryChipsState extends State<HistoryChips> {
  bool _isDelete = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("搜索历史"),
              _buildButton(),
            ],
          ),
          if (widget.history.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "暂无搜索记录",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          if (widget.history.isNotEmpty)
            Wrap(
              spacing: 5,
              children: widget.history.map(_buildChipItem).toList(),
            )
        ],
      ),
    );
  }

  Widget _buildButton() {
    IconData icon =
        _isDelete ? CupertinoIcons.arrow_turn_up_left : CupertinoIcons.delete;
    Widget result = GestureDetector(
      onTap: () {
        setState(() => _isDelete = !_isDelete);
      },
      child: Icon(icon, size: 18),
    );
    if (_isDelete) {
      result = Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          GestureDetector(
            onTap: () => widget.onDeleteHistory(null),
            child: Text(
              "清空全部",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(
              height: 16,
              child: VerticalDivider(
                width: 20,
              )),
          result,
        ],
      );
    }
    return result;
  }

  Widget _buildChipItem(String value) {
    return InputChip(
      onDeleted: _isDelete ? () => widget.onDeleteHistory(value) : null,
      deleteIcon: const Icon(
        Icons.clear,
        size: 16,
        color: Colors.redAccent,
      ),
      label: Text(value),
      onPressed: () => widget.onSelectHistory(value),
    );
  }
}
