import 'package:sqflite/sqflite.dart';
import '../../../model/secret.dart';

class SecretDao {
  final Database database;

  SecretDao(this.database);

  static const String _kCreateSql = """
CREATE TABLE IF NOT EXISTS t_secret (
secret_id INTEGER PRIMARY KEY AUTOINCREMENT,
title VARCHAR(256) NOT NULL,
secret VARCHAR(256),
update_at INTEGER NOT NULL,
create_at INTEGER NOT NULL
)""";

  static const String _kIndexTitleSql = """
CREATE UNIQUE INDEX 
index_t_secret_title 
ON t_secret (title)
""";

  static Future<void> createTable(Database db) async {
    await db.execute(_kCreateSql);
    await db.execute(_kIndexTitleSql);
    return;
  }

  Future<int> insert(Secret data) => database.insert(
        't_secret',
        data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );

  Future<int> delete(Secret data) => database.delete(
        't_secret',
        where: 'secret_id=?',
        whereArgs: [data.secretId],
      );

  Future<int> update(int? id, UpdateSecretPayload payload) => database.update(
        't_secret',
        where: 'secret_id=?',
        whereArgs: [id],
        payload.toJson(),
      );

  /// 分页获搜索数据
  Future<List<Secret>> search({
    int page = 1,
    int pageSize = 15,
    required String arg,
  }) async {
    int offset = (page - 1) * pageSize;
    List<Map<String, dynamic>> data = await database.query('t_secret',
        where: "title like ?",
        whereArgs: ['%$arg%'],
        orderBy: 'update_at DESC',
        offset: offset,
        limit: pageSize);
    return data.map(Secret.fromMap).toList();
  }

  /// 分页获取数据
  Future<List<Secret>> query({
    int page = 1,
    int pageSize = 15,
  }) async {
    int offset = (page - 1) * pageSize;
    List<Map<String, dynamic>> data = await database.query(
      't_secret',
      orderBy: 'update_at DESC',
      offset: offset,
      limit: pageSize,
    );
    return data.map(Secret.fromMap).toList();
  }

  /// 根据 [title] 查找一条记录
  Future<Secret?> findByTitle(String title) async {
    String sql = "SELECT * FROM t_secret WHERE title=?";
    List<Map<String, dynamic>> data = await database.rawQuery(sql, [title]);
    if (data.isEmpty) return null;
    return Secret.fromMap(data.first);
  }

  Future<int> total() async {
    String totalSql = "SELECT COUNT(secret_id) AS total FROM t_secret";
    List<Map<String, dynamic>> data = await database.rawQuery(totalSql);
    if (data.isEmpty) return 0;
    return data.first['total'] ?? 0;
  }
}
