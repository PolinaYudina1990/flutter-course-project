import 'package:places/domain/sight.dart';

final List<Sight> mocks = [
  Sight(
    id: 1,
    name: 'Воронежский областной краеведческий музей',
    workHours: 'закрыто до 09:00',
    coordinatePoint: CoordinatePoint(52.512044, 107.027643),
    // url: 'https://susanintop.com/wp-content/uploads/2018/11/422217.jpg',
    details: 'Один из ведущих музеев Воронежа',
    titleType: 'Музей',
    urlImages: [
      'https://susanintop.com/wp-content/uploads/2018/11/422217.jpg',
      'https://tripplanet.ru/wp-content/uploads/europe/russia/voronezh/voronezh-regional-museum.jpg',
      'https://liveinmsk.ru/up/photos/album/meschansky/0280.jpg',
      'https://bravo-voronezh.ru/wp-content/uploads/2018/04/foto-4.jpg',
    ],
    wantToVisit: true,
    visited: false,
  ),
  Sight(
    id: 2,
    name: 'Remy Coffee',
    workHours: 'закрыто до 09:00',
    coordinatePoint: CoordinatePoint(52.532044, 107.087643),
    // url:
    //     'https://i1.photo.2gis.com/images/branch/31/4362862183976801_9315.jpg',
    details:
        'Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного',
    titleType: 'Кафе',
    urlImages: [
      'https://i1.photo.2gis.com/images/branch/31/4362862183976801_9315.jpg',
    ],
    wantToVisit: true,
    visited: false,
  ),
  Sight(
    id: 3,
    name: 'Кривоборье',
    workHours: 'закрыто до 09:00',
    coordinatePoint: CoordinatePoint(52.026349, 39.185882),
    // url:
    //     'https://s3.nat-geo.ru/images/2019/9/14/a2b870a6af174201bad38a109ca4bb85.max-2500x1500.jpg',
    details: 'Деревня в Рамонском районе Воронежской области',
    titleType: 'Особое место',
    urlImages: [
      'https://s3.nat-geo.ru/images/2019/9/14/a2b870a6af174201bad38a109ca4bb85.max-2500x1500.jpg',
    ],
    wantToVisit: false,
    visited: true,
  ),
];

List<String> history = [];
List<Sight> visSight =
    mocks.where((sight) => sight.wantToVisit == true).toList();
List<Sight> visitedSight =
    mocks.where((sight) => sight.visited == true).toList();
List<String> newSightsMocksPhotosList = [
  'https://kuda-mo.ru/uploads/9565f99c9a90ddbbbe2a671c548c28a2.jpeg',
  'https://ic.pics.livejournal.com/alik_morozov/68038780/1002703/1002703_original.jpg',
  'https://4.404content.com/1/97/66/2089225708088067566/fullsize.jpg',
  'https://fotovmire.ru/wp-content/uploads/2019/02/8745/vechernij-traffik-u-podnozhja-kolizeja-v-rime.jpg',
];
List<String> newSightPhotos = [];
