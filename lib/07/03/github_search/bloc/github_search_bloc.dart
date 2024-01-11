
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../data/models/models.dart';
import '../data/repository/github_repository.dart';
import 'github_search_event.dart';
import 'github_search_state.dart';


const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {

  final GithubRepository githubRepository;

  GithubSearchBloc({required this.githubRepository})
      : super(SearchStateEmpty()) {
    on<InputChangeEvent>(_onTextChanged, transformer: debounce(_duration));
  }

  Future<void> _onTextChanged(
    InputChangeEvent event,
    Emitter<GithubSearchState> emit,
  ) async {
    final String term = event.text;
    if (term.isEmpty) return emit(SearchStateEmpty());
    emit(SearchStateLoading());
    try {
      final results = await githubRepository.search(term);
      emit(SearchStateSuccess(results.items));
    } catch (error) {
      emit(SearchStateError(error.toString()));
    }
  }
}
