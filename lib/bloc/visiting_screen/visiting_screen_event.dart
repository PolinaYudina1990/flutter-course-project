import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class VisitingScreenEvent extends Equatable {
  const VisitingScreenEvent();

  @override
  List<Object> get props => [];
}

// Эвент загрузки запланированных мест
class PlanedSightsLoad extends VisitingScreenEvent {}

// Эвент загрузки посещенных мест
class VisitedSightsLoad extends VisitingScreenEvent {}

// клик по кнопке удалить для запланированных мест
class PlanedSightRemovePlace extends VisitingScreenEvent {
  final Place place;

  const PlanedSightRemovePlace(this.place);

  @override
  List<Object> get props => [];
}

// клик по кнопке удалить для посещенных мест
class VisitedSightRemovePlace extends VisitingScreenEvent {
  final Place place;

  const VisitedSightRemovePlace(this.place);

  @override
  List<Object> get props => [];
}
