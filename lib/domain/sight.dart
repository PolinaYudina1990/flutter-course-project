class Sight {
  final String name;
  final String workHours;
  final CoordinatePoint coordinatePoint;
  // final String url;
  final String details;
  final SightType type;
  final String titleType;
  final List<String> urlImages;
  bool wantToVisit;
  bool visited;
  Sight(
      {this.name,
      this.workHours,
      this.coordinatePoint,
      // this.url,
      this.details,
      this.type,
      this.titleType,
      this.urlImages,
      this.wantToVisit,
      this.visited});
}

class CoordinatePoint {
  double lat;
  double lng;

  CoordinatePoint(this.lat, this.lng);
}

enum SightType { hotel, restourant, particular, park, museum, cafe }
