import 'dart:math';

import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_repository.dart';

final placeInteractor = PlaceInteractor(placeRepository: PlaceRepository());

class PlaceInteractor {
  final PlaceRepository placeRepository;

  PlaceInteractor({this.placeRepository});

  Future<List<Place>> getPlaces(PlacesFilterRequestDto filter) async {
    final places = await (placeRepository.getFilteredPlaces(filter));
    places.sort((a, b) => (GeoPoint.distanceInMetersBetweenEarthCoordinates(
                GeoPoint.getMyCoordinates()['lat'],
                GeoPoint.getMyCoordinates()['lon'],
                a.lat,
                a.lng)
            .toInt())
        .compareTo(GeoPoint.distanceInMetersBetweenEarthCoordinates(
                GeoPoint.getMyCoordinates()['lat'],
                GeoPoint.getMyCoordinates()['lon'],
                b.lat,
                b.lng)
            .toInt()));

    return places;
  }

  Future<Place> getPlaceDetails(int id) async {
    final place = await (placeRepository.getPlaceById(id));
    return place;
  }

  Future<List<Place>> getFavoritesPlaces() async {
    final favoritesPlaces = await (placeRepository.testFavoritesPlaces());

    favoritesPlaces.sort((a, b) =>
        (GeoPoint.distanceInMetersBetweenEarthCoordinates(
                    GeoPoint.getMyCoordinates()['lat'],
                    GeoPoint.getMyCoordinates()['lon'],
                    a.lat,
                    a.lng)
                .toInt())
            .compareTo(GeoPoint.distanceInMetersBetweenEarthCoordinates(
                    GeoPoint.getMyCoordinates()['lat'],
                    GeoPoint.getMyCoordinates()['lon'],
                    b.lat,
                    b.lng)
                .toInt()));

    return favoritesPlaces;
  }

  Future<bool> addToFavorites(Place place) async {
    bool result = false;

    final favoritesPlaces = await placeRepository.testFavoritesPlaces();

    favoritesPlaces.forEach(
      (element) {
        element.id == place.id ? result = false : result = true;
      },
    );
    if (result) favoritesPlaces.add(place);

    return result;
  }

  Future<bool> removeFromFavorites(Place place) async {
    bool result = false;

    final favoritesPlaces = await (placeRepository.testFavoritesPlaces());

    favoritesPlaces.forEach(
      (element) {
        element.id == place.id ? result = false : result = true;
      },
    );

    if (result) favoritesPlaces.remove(place);

    return result;
  }

  Future<List<Place>> getVisitPlaces() async {
    final visitPlaces = await (placeRepository.testFavoritesPlaces());

    return visitPlaces;
  }

  Future<bool> addToVisitingPlaces(Place place) async {
    bool result = false;

    final visitPlaces = await (placeRepository.testFavoritesPlaces());

    visitPlaces.forEach(
      (element) {
        element.id == place.id ? result = false : result = true;
      },
    );
    if (result) visitPlaces.add(place);

    return result;
  }

  Future<bool> addNewPlace(Place place) async {
    try {
      await (placeRepository.createPlace(place));
      return true;
    } catch (_) {
      return false;
    }
  }
}

class GeoPoint {
  static double _degreesToRadians(degrees) {
    return degrees * pi / 180;
  }

  static double distanceInMetersBetweenEarthCoordinates(
      lat1, lon1, lat2, lon2) {
    var earthRadiusKm = 6371;

    var dLat = _degreesToRadians(lat2 - lat1);
    var dLon = _degreesToRadians(lon2 - lon1);

    lat1 = _degreesToRadians(lat1);
    lat2 = _degreesToRadians(lat2);

    var a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c * 1000;
  }

  static Map<String, double> getMyCoordinates() {
    Map<String, double> coords = {
      'lat': 55.989198, //моковые
      'lon': 37.601605, //моковые
    };
    return coords;
  }
}
