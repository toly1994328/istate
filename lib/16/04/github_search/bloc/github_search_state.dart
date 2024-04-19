
import 'package:equatable/equatable.dart';

import '../data/models/models.dart';

sealed class GithubSearchState extends Equatable {
  const GithubSearchState();
  @override
  List<Object> get props => [];
}

final class SearchStateEmpty extends GithubSearchState {}

final class SearchStateLoading extends GithubSearchState {}

final class SearchStateSuccess extends GithubSearchState {
  const SearchStateSuccess(this.items);

  final List<RepositoryInfo> items;

  @override
  List<Object> get props => [items];
}

final class SearchStateError extends GithubSearchState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
