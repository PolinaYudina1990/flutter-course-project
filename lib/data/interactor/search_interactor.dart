import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_repository.dart';

final searchInteractor = SearchInteractor(placeRepository: PlaceRepository());

class SearchInteractor {
  final PlaceRepository placeRepository;

  SearchInteractor({this.placeRepository});

  static List<Place> sortedByRadius = [];
  static List<Place> placesList = [];
  static List searchHistory = [];
  static RangeValues rangeValues = RangeValues(100, 10000);
  static List<String> typeFilters = [];

  Future<List<Place>> searchPlaces(String name) async {
    PlacesFilterRequestDto filter = PlacesFilterRequestDto(
      nameFilter: name,
      radius: rangeValues.end,
      typeFilter: typeFilters,
      lat: 52.026349,
      lng: 39.185882,
    );
    List<Place> listPlaces = await placeRepository.getFilteredPlaces(filter);
    placesList = listPlaces;
    return listPlaces;
  }
}
