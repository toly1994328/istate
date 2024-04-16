import 'package:equatable/equatable.dart';

class PagedResult<T> {
  final Pagination pagination;
  final List<T> data;

  PagedResult({
    required this.data,
    required this.pagination,
  });
}

class Pagination extends Equatable {
  final int total;
  final int page;
  final int pageSize;

  const Pagination({
    required this.total,
    required this.page,
    required this.pageSize,
  });

  @override
  List<Object?> get props => [total, pageSize, page];
}
