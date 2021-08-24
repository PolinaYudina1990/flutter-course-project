import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
part 'place_list_store.g.dart';

class PlaceListStore = PlaceListStoreBase with _$PlaceListStore;

abstract class PlaceListStoreBase with Store {
  final PlaceInteractor placeInteractor;

  PlaceListStoreBase(this.placeInteractor);

  @observable
  ObservableFuture<List<Place>> listPlacesFuture;

  @action
  Future<void> getFilteredPlace({PlacesFilterRequestDto filter}) async {
    final places = placeInteractor.getPlaces(filter);

    listPlacesFuture = ObservableFuture(places);
  }
}
