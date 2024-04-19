import 'package:equatable/equatable.dart';
import '../../data/data.dart';

class SecretsSearchState extends Equatable {
  final List<Secret> secrets;
  final String arg;
  final Pagination pagination;

  const SecretsSearchState({
    required this.secrets,
    this.arg = '',
    required this.pagination,
  });

  factory SecretsSearchState.none() => const SecretsSearchState(
        secrets: [],
        pagination: Pagination(total: 0, page: 0, pageSize: 0),
      );

  @override
  List<Object?> get props => [secrets, pagination];

  SecretsSearchState copyWith({
    List<Secret>? secrets,
    String? arg,
    Pagination? pagination,
  }) =>
      SecretsSearchState(
        secrets: secrets ?? this.secrets,
        pagination: pagination ?? this.pagination,
        arg: arg ?? this.arg,
      );
}
