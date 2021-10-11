import 'package:equatable/equatable.dart';
import 'package:places/redux/state/search_state.dart';

class AppState {
  final SearchState searchState;

  AppState({SearchState searchState})
      : this.searchState = searchState ?? InitialSearchState();

  AppState cloneWith({SearchState searchState}) =>
      AppState(searchState: searchState ?? this.searchState);
}
