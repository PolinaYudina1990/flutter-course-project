import 'package:places/redux/actions/search_actions.dart';
import 'package:places/redux/reducer/search_reducer.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:redux/redux.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, QueryChangedSearchAction>(queryChangedReducer),
  TypedReducer<AppState, ResultSearchAction>(resultReducer),
  TypedReducer<AppState, LoadSearchAction>(loadingReducer),
  TypedReducer<AppState, HistorySearchAction>(showHistoryReducer),
]);
