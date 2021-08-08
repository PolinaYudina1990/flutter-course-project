class PlacesFilterRequestDto {
  final double lat;
  final double lng;
  final double radius;
  final List<String> typeFilter;
  final String nameFilter;

  PlacesFilterRequestDto({
    this.lat,
    this.lng,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['radius'] = this.radius;
    data['typeFilter'] = this.typeFilter;
    data['nameFilter'] = this.nameFilter;
    return data;
  }
}
