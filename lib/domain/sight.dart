class Sight {
  final String name;
  final String workHours;
  final CoordinatePoint coordinatePoint;
  final String url;
  final String details;
  final String type;
  Sight(
      {this.name,
      this.workHours,
      this.coordinatePoint,
      this.url,
      this.details,
      this.type});
}

class CoordinatePoint {
  double lat;
  double lng;

  CoordinatePoint(this.lat, this.lng);
}
