import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/redux/actions/search_actions.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class SightSearchMiddleware implements MiddlewareClass<AppState> {
  SightSearchMiddleware(this._searchInteractor);

  final SearchInteractor _searchInteractor;

  @override
  call(
    Store<AppState> store,
    dynamic action,
    NextDispatcher next,
  ) async {
    if (action is QueryChangedSearchAction) {
      if (action.query.isEmpty) {
        next(HistorySearchAction());
        return;
      }

      next(LoadSearchAction());

      bool hasError = false;
      List<Place> _foundSights = [];

      try {
        String filtered =
            PlacesFilterRequestDto(nameFilter: action.query).toString();
        _foundSights = await _searchInteractor.searchPlaces(filtered);
      } on DioError catch (e) {
        debugPrint('Error searching places: ${e.error}');
        hasError = true;
      } finally {
        next(ResultSearchAction(_foundSights));
      }
    } else {
      next(action);
    }
  }
}
