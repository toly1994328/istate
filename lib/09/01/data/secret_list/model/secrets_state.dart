import 'package:equatable/equatable.dart';

import 'secret.dart';

class SecretsState extends Equatable {
  final List<Secret> secrets;
  final Secret? activeSecret;

  const SecretsState({
    required this.secrets,
    required this.activeSecret,
  });

  @override
  List<Object?> get props => [secrets,activeSecret];

  SecretsState copyWith({
    List<Secret>? secrets,
    Secret? activeSecret,
  }) =>
      SecretsState(
        secrets: secrets ?? this.secrets,
        activeSecret: activeSecret ?? this.activeSecret,
      );
}
