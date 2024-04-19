import 'package:sqflite/sqflite.dart';
import '../../../model/history.dart';

class SearchHistoryDao {
  final Database database;

  SearchHistoryDao(this.database);

  static const String kTableName = 't_search_history';

  static const String _createSql = """
CREATE TABLE IF NOT EXISTS t_search_history (
history_id INTEGER PRIMARY KEY AUTOINCREMENT,
arg VARCHAR(256) NOT NULL ,
update_at INTEGER NOT NULL,
create_at INTEGER NOT NULL
)""";

  static Future<void> createTable(Database db) {
    return db.execute(_createSql);
  }

  /// 分页获取数据
  Future<List<History>> query({
    int page = 1,
    int pageSize = 20,
  }) async {
    int offset = (page - 1) * pageSize;
    List<Map<String, dynamic>> data = await database.query(
      't_search_history',
      offset: offset,
      limit: pageSize,
      orderBy: 'update_at DESC'
    );
    return data.map(History.fromMap).toList();
  }

  Future<int> insert(String arg) async {
    await database.execute("DELETE FROM t_search_history WHERE arg=?",[arg]);
    int now = DateTime.now().millisecondsSinceEpoch;
    History history = History(arg: arg, createAt: now, updateAt: now);
    return database.insert(
      kTableName,
      history.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> delete(int? id) => database.delete(
        't_search_history',
        where: 'history_id=?',
        whereArgs: [id],
      );

  Future<void> clear() => database.execute(
        "DELETE FROM t_search_history WHERE history_id > 0",
      );
}
