
import '../model/page_result.dart';
import '../model/secret.dart';
import 'database_secret_list_repository.dart';
import 'memory_secret_list_repository.dart';

// final SecretListRepository secretListRepository = MemorySecretListRepository();
final SecretListRepository secretListRepository = DataBaseSecretListRepository();

abstract class SecretListRepository {

  Future<PagedResult<Secret>> search(
    String arg, {
    int page = 1,
    int pageSize = 15,
  });

  /// 分页获取秘钥列表
  /// [page] 页码
  /// [pageSize] 每页数据数量
  /// return [PagedResult] 分页结果列表数据
  Future<PagedResult<Secret>> fetch({
    int page = 1,
    int pageSize = 15,
  }) ;

  /// 通过领域名称添加一个领域记录
  /// [title]: 添加的领域名称
  Future<Secret> insert(String title);

  /// 更新领域秘钥信息
  /// [secret] 旧领域秘钥
  /// [payload] 领域秘钥更新承载数据
  Future<Secret> update(
    Secret secret,
    UpdateSecretPayload payload,
  ) ;

  Future<Secret> delete(Secret secret);
}
