part of 'secrets_state.dart';

sealed class ListOpType {
  const ListOpType();
}

class JumpOp  extends ListOpType {
  final Secret secret;
  const JumpOp(this.secret);
}


class NoneOp extends ListOpType {
  const NoneOp();
}

/// 更新操作
class RefreshOp extends ListOpType {
  const RefreshOp();
}

/// 加载更多
/// [pagination] 分页信息
class LoadMoreOp extends ListOpType {
  final Pagination pagination;
  const LoadMoreOp( this.pagination);
}

class AddOp extends ListOpType {
  final String title;
  AddOp(this.title);
}

/// 推送秘钥
class EditOp extends ListOpType {
  final String name;
  EditOp(this.name);
}

/// 推送秘钥
class PushOp extends ListOpType {
  final String secret;
  PushOp(this.secret);
}

class SecretListOpState{
  final ListOpType op;
  final Object? data;

  SecretListOpState({required this.op, this.data});
}