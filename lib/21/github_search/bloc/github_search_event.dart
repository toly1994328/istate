import 'package:equatable/equatable.dart';

sealed class GithubSearchEvent extends Equatable {
  const GithubSearchEvent();
}

final class InputChangeEvent extends GithubSearchEvent {
  const InputChangeEvent({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}
