import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/model/history.dart';
import '../../data/storage/db_storage/app_db_storage.dart';
import '../../data/storage/db_storage/dao/search_history_dao.dart';

part 'search_history.g.dart';

@riverpod
class SearchHistory extends _$SearchHistory {
  SearchHistoryDao get dao => AppDbStorage.instance.find<SearchHistoryDao>();

  @override
  Future<List<History>> build() async {
    return await dao.query();
  }

  void addHistory(String arg) async {
    await dao.insert(arg);
    List<History> data = await dao.query();
    state = AsyncValue.data(data);
  }

  void removeHistory(History history) async {
    await dao.delete(history.historyId);
    List<History> data = await dao.query();
    state = AsyncValue.data(data);
  }

  void clearAllHistory() async {
    if (state.value == null) return;
    await dao.clear();
    List<History> data = await dao.query();
    state = AsyncValue.data(data);
  }
}
