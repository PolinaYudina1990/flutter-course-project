import 'package:places/res/Strings.dart';

List<FilterType> categories = [
  FilterType(hotelIcon, 'Отель', false),
  FilterType(restaurantIcon, 'Ресторан', false),
  FilterType(particularIcon, 'Особое место', false),
  FilterType(parkIcon, 'Парк', false),
  FilterType(museumIcon, 'Музей', false),
  FilterType(caffeIcon, 'Кафе', false),
];

class FilterType {
  String icon;
  String title;
  bool isSelected;

  FilterType(
    this.icon,
    this.title,
    this.isSelected,
  );

  void select() {
    isSelected = !isSelected;
  }
}

List<String> typeFilters = [
  'temple',
  'monument',
  'park',
  'theatre',
  'museum',
  'hotel',
  'restaurant',
  'cafe',
  'other',
];
