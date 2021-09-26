import 'package:bloc/bloc.dart';
import '../repository/models/search_result_error.dart';
import 'package:stream_transform/stream_transform.dart';

import '../repository/api/github_repository.dart';
import 'github_search_event.dart';
import 'github_search_state.dart';


const Duration _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  GithubSearchBloc({required this.githubRepository})
      : super(SearchStateEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  final GithubRepository githubRepository;

  void _onTextChanged(
    TextChanged event,
    Emitter<GithubSearchState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {
      final results = await githubRepository.search(searchTerm);
      emit(SearchStateSuccess(results.items));
    } catch (error) {
      emit(error is SearchResultError
          ? SearchStateError(error.message)
          : const SearchStateError('something went wrong'));
    }
  }
}
