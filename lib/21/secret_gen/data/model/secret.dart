import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class UpdateSecretPayload {
  final String? title;
  final String? secret;

  UpdateSecretPayload({this.title, this.secret});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {
      "update_at": DateTime.now().millisecondsSinceEpoch,
    };
    if (title != null) ret['title'] = title;
    if (secret != null) ret['secret'] = secret;

    return ret;
  }
}

class InsertSecretPayload {
  final String title;

  InsertSecretPayload({required this.title});
}

DateFormat dateFormat = DateFormat("yyyy.MM.dd HH:mm");

class Secret extends Equatable {
  final int? secretId;
  final String title;
  final String? secret;
  final int createAt;
  final int updateAt;

  const Secret({
    required this.secret,
    required this.title,
    this.secretId,
    required this.createAt,
    required this.updateAt,
  });

  UpdateSecretPayload get update {
    return UpdateSecretPayload(secret: secret, title: title);
  }

  @override
  List<Object?> get props => [title, secret, createAt, updateAt];

  String get createStr =>
      dateFormat.format(DateTime.fromMillisecondsSinceEpoch(createAt));

  String get updateStr =>
      dateFormat.format(DateTime.fromMillisecondsSinceEpoch(updateAt));

  String get secretStr => secret?.hide() ?? '暂未上传秘钥';

  factory Secret.fromMap(dynamic map) => Secret(
        secretId: map['secret_id'],
        title: map['title'],
        secret: map['secret'],
        createAt: map['create_at'],
        updateAt: map['update_at'],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "secret_id": secretId,
        "secret": secret,
        "create_at": createAt,
        "update_at": updateAt,
      };
}

extension StringExt on String {
  String hide({
    String fix = "*",
    int start = 2,
    int end = 2,
  }) {
    if (length <= start) {
      return this;
    }
    String p0 = substring(0, start);
    int hideCount = length - start - end;
    if (hideCount <= 0) {
      return p0.padRight(length, fix);
    }
    String p1 = List.filled(length - (start + end), fix).join();
    String p2 = substring(length - end);
    return "$p0$p1$p2";
  }
}
