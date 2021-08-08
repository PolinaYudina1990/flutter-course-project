import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';

final dio = Dio();

class PlaceRepository {
  Future<List<Place>> getPlaces() async {
    final response = await dio.get('/places');
    if (response.statusCode == 200) {
      return jsonDecode(response.data)
          .data
          .map((response) => Place.fromJson(response))
          .toList();
    }
    throw Exception('HTTP request error. Error code ${response.statusCode}');
  }

  Future<List<Place>> getFilteredPlaces(PlacesFilterRequestDto filter) async {
    final response = await dio.post('/filtered_places', data: filter.toJson());
    if (response.statusCode == 200) {
      return jsonDecode(response.data)
          .data
          .map((response) => Place.fromJson(response))
          .toList();
    }
    throw Exception('HTTP request error. Error code ${response.statusCode}');
  }

  Future<Place> createPlace(Place place) async {
    final response = await dio.post('/places', data: place.toJson());
    return jsonDecode(response.data)
        .data
        .map((response) => Place.fromJson(response))
        .toList();
  }

  Future<Place> getPlaceById(int id) async {
    final response = await dio.get('/places' + '/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.data)
          .data
          .map((response) => Place.fromJson(response))
          .toList();
    }
    throw Exception('HTTP request error. Error code ${response.statusCode}');
  }

  Future<void> deletePlaceById(int id) async {
    await dio.delete('/places' + '/$id');
  }

  Future<void> updatePlace(Place place) async {
    await dio.put('/places' + '${place.id}', data: place.toJson());
  }

  Future<List<Place>> testFavoritesPlaces() async {
    List<Place> favorites = await getPlaces();
    return favorites;
  }
}
