import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/page_result.dart';
import '../model/secret.dart';
import 'secret_list_repository.dart';

class MemorySecretListRepository implements SecretListRepository{
  List<Secret> _serverDataList = [];

  @override
  Future<PagedResult<Secret>> search(
    String arg, {
    int page = 1,
    int pageSize = 15,
  }) async {
    /// 模拟网络异步请求
    /// 下面的代码可以不较真，仅通过内存的方式模拟搜索结果
    await Future.delayed(const Duration(seconds: 1));
    RegExp regExp = RegExp(arg, caseSensitive: false);
    List<Secret> result = _serverDataList.where((e) => e.title.contains(regExp)).toList();
    int start = (page - 1) * pageSize;
    int end = start + pageSize;
    int length = result.length;
    List<Secret> data = [];
    if (end > result.length + pageSize) {
      data = [];
    } else if (end > length) {
      data = result.sublist(start);
    } else {
      data = result.sublist(start, end);
    }
    return PagedResult(
      data: data,
      pagination: Pagination(page: page, pageSize: pageSize, total: length),
    );
  }

  /// 分页获取秘钥列表
  /// [page] 页码
  /// [pageSize] 每页数据数量
  /// return [PagedResult] 分页结果列表数据
  @override
  Future<PagedResult<Secret>> fetch({
    int page = 1,
    int pageSize = 15,
  }) async {
    /// 模拟网络异步请求
    /// 下面的代码可以不较真，仅通过内存的方式模拟分页结果
    await Future.delayed(const Duration(seconds: 1));
    if (_serverDataList.isEmpty) {
      String data = await rootBundle.loadString("assets/data/secret.json");
      _serverDataList = (json.decode(data) as List).map(Secret.fromMap).toList();
    }
    int start = (page - 1) * pageSize;
    int end = start + pageSize;
    int length = _serverDataList.length;
    List<Secret> data = [];
    if (end > _serverDataList.length + pageSize) {
      data = [];
    } else if (end > _serverDataList.length) {
      data = _serverDataList.sublist(start);
    } else {
      data = _serverDataList.sublist(start, end);
    }
    return PagedResult(
      data: data,
      pagination: Pagination(page: page, pageSize: pageSize, total: length),
    );
  }

  /// 通过领域名称添加一个领域记录
  /// [title]: 添加的领域名称
  @override
  Future<Secret> insert(String title) async {
    /// 模拟网络异步请求
    /// 下面的代码可以不较真，仅通过内存的方式添加
    await Future.delayed(const Duration(seconds: 1));
    List<Secret> secrets = _serverDataList;
    if (secrets.where((e) => e.title == title).isNotEmpty) {
      throw "领域名已存在:$title";
    }
    int now = DateTime.now().millisecondsSinceEpoch;
    Secret newSecret =
        Secret(title: title, secret: null, createAt: now, updateAt: now);
    _serverDataList.insert(0, newSecret);
    return newSecret;
  }

  /// 更新领域秘钥信息
  /// [secret] 旧领域秘钥
  /// [payload] 领域秘钥更新承载数据
  @override
  Future<Secret> update(
    Secret secret,
    UpdateSecretPayload payload,
  ) async {
    /// 模拟网络异步请求
    /// 下面的代码可以不较真，仅通过内存的方式更新
    await Future.delayed(const Duration(seconds: 1));

    /// 模拟更新后的数据，可通过接口返回
    Secret newSecret = Secret(
      title: payload.title ?? secret.title,
      secret: payload.secret ?? secret.secret,
      createAt: secret.createAt,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    _serverDataList.removeWhere((e) => e.title == secret.title);
    _serverDataList.insert(0, newSecret);
    return newSecret;
  }

  @override
  Future<Secret> delete(Secret secret) async {
    /// 模拟网络异步请求
    /// 下面的代码可以不较真，仅通过内存的方式删除
    await Future.delayed(const Duration(seconds: 1));
    _serverDataList.removeWhere((e) => e.title == secret.title);
    return secret;
  }
}
