import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';
import 'package:places/domain/sight.dart';

abstract class SearchState extends Equatable {}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

class HistorySearchState extends SearchState {
  final List<String> historyList;
  @override
  List<Object> get props => [historyList];
  HistorySearchState(this.historyList);
}

class LoadSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

class ResultSearchState extends SearchState {
  final List<Place> filteredSights;
  @override
  List<Object> get props => [filteredSights];
  ResultSearchState(this.filteredSights);
}
