import 'package:places/data/model/place.dart';

abstract class SearchAction {}

class LoadSearchAction extends SearchAction {}

class QueryChangedSearchAction extends SearchAction {
  final String query;

  QueryChangedSearchAction(this.query);
}

class ResultSearchAction extends SearchAction {
  final List<Place> resultSights;

  ResultSearchAction(this.resultSights);
}

class HistorySearchAction extends SearchAction {}
