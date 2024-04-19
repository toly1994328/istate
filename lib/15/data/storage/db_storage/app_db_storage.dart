import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'dao/search_history_dao.dart';
import 'dao/secret_dao.dart';

class AppDbStorage {
  static const kDbName = "istate.db";

  Database? _database;

  AppDbStorage._();

  static AppDbStorage instance = AppDbStorage._();

  final Map<Type, dynamic> _daoMap = {};

  Future<void> initDb({String? name}) async {
    if (_database != null) return;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dirName = 'databases';
    String databasesPath = path.join(appDocDir.path, dirName);
    String dbPath = path.join(databasesPath, name ?? kDbName);
    debugPrint("Database Path: $dbPath");
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    print('数据库创建:$kDbName....');
    await Future.wait([
      SecretDao.createTable(db),
      SearchHistoryDao.createTable(db),
    ]);
  }

  FutureOr<void> _onOpen(Database db) {
    print('数据库打开:$kDbName....');
    _database = db;
    _daoMap[SecretDao] = SecretDao(db);
    _daoMap[SearchHistoryDao] = SearchHistoryDao(db);
  }




  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('数据库更新:$kDbName....$oldVersion -> $newVersion');
  }

  T $<T>() => find<T>();

  T find<T>(){
    return _daoMap[T];
  }
}
