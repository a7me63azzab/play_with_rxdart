import 'package:flutter/foundation.dart' show immutable;
import 'package:play_with_rxdart/bloc/api.dart';
import 'package:play_with_rxdart/bloc/search_result.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class SearchBloc {
  final Sink<String> search;
  final Stream<SearchResult?> results;

  void dispose() {
    search.close();
  }

  factory SearchBloc({
    required Api api,
  }) {
    final textChanges = BehaviorSubject<String>();
    final Stream<SearchResult?> results = textChanges
        .distinct()
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap<SearchResult?>((String searchTerm) {
      if (searchTerm.isEmpty) {
        return Stream<SearchResult?>.value(null);
      } else {
        return Rx.fromCallable(() => api.search(searchTerm))
            .delay(const Duration(seconds: 1))
            .map((results) {
              if (results.isEmpty) {
                return const SearchResultNoResult();
              } else {
                return SearchResultWithResults(results);
              }
            })
            .startWith(const SearchResultLoading())
            .onErrorReturnWith((error, _) => SearchResultHasError(error));
      }
    });

    return SearchBloc._(results: results, search: textChanges.sink);
  }

  const SearchBloc._({required this.results, required this.search});
}
