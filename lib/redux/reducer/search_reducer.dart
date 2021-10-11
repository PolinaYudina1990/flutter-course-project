import 'package:places/redux/actions/search_actions.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/search_state.dart';

AppState queryChangedReducer(AppState state, QueryChangedSearchAction action) {
  return state.cloneWith(searchState: LoadSearchState());
}

AppState resultReducer(AppState state, ResultSearchAction action) {
  return state.cloneWith(searchState: ResultSearchState(action.resultSights));
}

AppState loadingReducer(AppState state, LoadSearchAction action) {
  return state.cloneWith(searchState: LoadSearchState());
}

AppState showHistoryReducer(AppState state, HistorySearchAction action) {
  return state.cloneWith(searchState: InitialSearchState());
}
