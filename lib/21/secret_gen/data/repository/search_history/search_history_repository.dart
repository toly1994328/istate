
import '../../storage/db_storage/app_db_storage.dart';
import '../../storage/db_storage/dao/search_history_dao.dart';

SearchHistoryRepository searchHistoryRepository = DatabaseSearchHistoryRepository();

abstract class SearchHistoryRepository {
  Future<Set<String>> fetch();

  Future<void> clear();

  Future<void> delete(int id);

  Future<void> insert(String arg);
}

class DatabaseSearchHistoryRepository implements SearchHistoryRepository{
  SearchHistoryDao get dao => AppDbStorage.instance.find<SearchHistoryDao>();

  @override
  Future<void> clear() =>  dao.clear();

  @override
  Future<void> delete(int id) => dao.delete(id);

  @override
  Future<Set<String>> fetch() => throw UnimplementedError();

  @override
  Future<void> insert(String arg) {
    // TODO: implement insert
    throw UnimplementedError();
  }

}