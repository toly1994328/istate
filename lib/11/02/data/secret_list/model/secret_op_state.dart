import 'secret.dart';

sealed class ListOpType {
  const ListOpType();
}

class NoneOp extends ListOpType {
  const NoneOp();
}

class AddOp extends ListOpType {
  final String title;
  AddOp(this.title);
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