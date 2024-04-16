

import '../model/page_result.dart';
import '../model/secret.dart';
import '../storage/db_storage/app_db_storage.dart';
import '../storage/db_storage/dao/secret_dao.dart';
import 'secret_list_repository.dart';

class DataBaseSecretListRepository implements SecretListRepository {
  SecretDao get dao => AppDbStorage.instance.find<SecretDao>();

  @override
  Future<PagedResult<Secret>> fetch({int page = 1, int pageSize = 15}) async {
    List<Secret> result = await dao.query(page: page, pageSize: pageSize);
    int total = await dao.total();
    return PagedResult(
      data: result,
      pagination: Pagination(total: total, page: page, pageSize: pageSize),
    );
  }

  @override
  Future<Secret> insert(String title) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    int ret = await dao.insert(
        Secret(secret: null, title: title, createAt: now, updateAt: now));
    if (ret <= 0) throw "insert error";

    Secret? secret = await dao.findByTitle(title);
    if (secret == null) throw "can't find error:${title}";
    return secret;
  }

  @override
  Future<PagedResult<Secret>> search(String arg,
      {int page = 1, int pageSize = 15}) async{
    List<Secret> result = await dao.search(page: page, pageSize: pageSize,arg: arg);
    int total = await dao.total();
    return PagedResult(
      data: result,
      pagination: Pagination(total: total, page: page, pageSize: pageSize),
    );
  }

  @override
  Future<Secret> update(Secret old, UpdateSecretPayload payload) async{
    int ret = await dao.update(old.secretId,payload);
    if (ret <= 0) throw "update error";
    Secret? secret = await dao.findByTitle(old.title);
    if (secret == null) throw "can't find error:${old.title}";
    return secret;
  }

  @override
  Future<Secret> delete(Secret secret) async{
    int ret = await dao.delete(secret);
    if (ret <= 0) throw "delete error";
    return secret;
  }
}
