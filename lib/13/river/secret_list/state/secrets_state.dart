import 'package:equatable/equatable.dart';
import '../../../data/data.dart';

part 'secret_op_state.dart';

class SecretsState extends Equatable {
  final List<Secret> secrets;
  final Secret? activeSecret;
  final Pagination pagination;

  const SecretsState( {
    required this.secrets,
    this.activeSecret,
    required this.pagination,
  });

  @override
  List<Object?> get props => [secrets,activeSecret,pagination];

  SecretsState copyWith({
    List<Secret>? secrets,
    Secret? activeSecret,
    Pagination? pagination,
  }) =>
      SecretsState(
        secrets: secrets ?? this.secrets,
        pagination: pagination ?? this.pagination,
        activeSecret: activeSecret ?? this.activeSecret,
      );
}
