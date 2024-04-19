
import '../../data/data.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'secrets_search_state.dart';

part 'search_history.g.dart';


@riverpod
class SearchHistory extends _$SearchHistory {
  @override
  Future<Set<String>> build() async {
    print("=======SearchHistory#build================");
    Set<String> historyTest = {'掘金', 'test', 'ADB', 'BD', 'toly', '1994','counter'};
    ref.onDispose(() {
      print("=======SearchHistory#onDispose================");
    });
    ref.keepAlive();
    return historyTest;
  }

  void addHistory(String arg) async {
    if (state.value == null) return;
    Set<String> prev = state.value!;
    state = AsyncValue.data({arg, ...prev},);
  }

  void removeHistory(String arg) async {
    if (state.value == null) return;
    Set<String> prev = state.value!;
    prev.removeWhere((element) => element==arg);
    state = AsyncValue.data({...prev},);
  }

  void clearAllHistory() async {
    if (state.value == null) return;
    state = const AsyncValue.data({},);
  }
}
