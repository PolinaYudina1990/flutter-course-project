import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class VisitingScreenState extends Equatable {
  const VisitingScreenState();

  @override
  List<Object> get props => [];
}

// Состояние загрузки данных
class VisitingScreenLoadInProgress extends VisitingScreenState {}

// Состояние загруженных данных запланированных мест
class PlanedSightsLoadSuccess extends VisitingScreenState {
  final List<Place> visSight;
  const PlanedSightsLoadSuccess(this.visSight);

  @override
  List<Object> get props => [this.visSight];

  @override
  String toString() {
    return 'FavouriteSightsLoadedSucess: ${this.visSight}';
  }
}

// Состояние загруженных данных посещенных мест
class VisitedSightLoadedSuccess extends VisitingScreenState {
  final List<Place> visitedSights;

  const VisitedSightLoadedSuccess(this.visitedSights);

  @override
  List<Object> get props => [this.visitedSights];

  @override
  String toString() {
    return 'VisitedSightLoadedSucess: ${this.visitedSights}';
  }
}
