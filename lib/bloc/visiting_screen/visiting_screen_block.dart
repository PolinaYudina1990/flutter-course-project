import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/visiting_screen/visiting_screen_event.dart';
import 'package:places/bloc/visiting_screen/visiting_screen_state.dart';
import 'package:places/data/interactor/place_interactor.dart';

class VisitingScreenBlock
    extends Bloc<VisitingScreenEvent, VisitingScreenState> {
  PlaceInteractor placeInteractor;

  VisitingScreenBlock(this.placeInteractor)
      : super(VisitingScreenLoadInProgress());

  @override
  Stream<VisitingScreenState> mapEventToState(
      VisitingScreenEvent event) async* {
    if (event is PlanedSightsLoad) {
      yield* _mapPlanedLoadToState();
    } else if (event is PlanedSightRemovePlace) {
      yield* _mapPlanedRemovedToState(event);
    }

    if (event is VisitedSightsLoad) {
      yield* _mapVisitedLoadToState();
    } else if (event is VisitedSightRemovePlace) {
      yield* _mapVisitedRemovedToState(event);
    }
  }

  Stream<VisitingScreenState> _mapPlanedLoadToState() async* {
    final visSight = await placeInteractor.getFavoritesPlaces();
    yield PlanedSightsLoadSuccess(visSight);
  }

  Stream<VisitingScreenState> _mapPlanedRemovedToState(
      PlanedSightRemovePlace event) async* {
    await placeInteractor.removeFromFavorites(event.place);
    add(PlanedSightsLoad());
  }

  Stream<VisitingScreenState> _mapVisitedLoadToState() async* {
    final visitedSight = await placeInteractor.getVisitPlaces();
    yield VisitedSightLoadedSuccess(visitedSight);
  }

  Stream<VisitingScreenState> _mapVisitedRemovedToState(
      VisitedSightRemovePlace event) async* {
    await placeInteractor.removeFromFavorites(event.place);
    add(VisitedSightsLoad());
  }
}
