import 'package:equatable/equatable.dart';

class History extends Equatable {
  final String arg;
  final int? historyId;
  final int createAt;
  final int updateAt;

  const History({
    required this.arg,
    this.historyId,
    required this.createAt,
    required this.updateAt,
  });

  @override
  List<Object?> get props => [arg, historyId, createAt, updateAt];

  factory History.fromMap(dynamic map) => History(
    historyId: map['history_id'],
    arg: map['arg'],
    createAt: map['create_at'],
    updateAt: map['update_at'],
  );

  Map<String, dynamic> toJson() => {
    "history_id": historyId,
    "arg": arg,
    "create_at": createAt,
    "update_at": updateAt,
  };
}
