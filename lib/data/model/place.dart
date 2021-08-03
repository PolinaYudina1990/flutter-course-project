class Place {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<dynamic> urls;
  final String placeType;
  final String description;

  Place({
    this.id,
    this.lat,
    this.lng,
    this.name,
    this.urls,
    this.description,
    this.placeType,
  });

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lat = json['lat'],
        lng = json['lng'],
        name = json['name'],
        urls = json['urls'],
        placeType = json['placeType'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['urls'] = this.urls;
    data['placeType'] = this.placeType;
    data['description'] = this.description;
    return data;
  }
}
