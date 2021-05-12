import 'package:places/domain/details.dart';

import 'domain/sight.dart';

final List<Sight> mocks = [
  Sight(
    name: 'Воронежский областной краеведческий музей',
    lat: 51.666647,
    lon: 39.193374,
    url: 'https://susanintop.com/wp-content/uploads/2018/11/422217.jpg',
    details: 'Один из ведущих музеев Воронежа',
    type: 'музеи',
  ),
  Sight(
    name: 'Remy Coffee',
    lat: 45.666647,
    lon: 32.193374,
    url: 'https://i1.photo.2gis.com/images/branch/31/4362862183976801_9315.jpg',
    details: 'Кафе, Европейская кухня',
    type: 'кафе',
  ),
  Sight(
    name: 'Кривоборье',
    lat: 52.026349,
    lon: 39.185882,
    url:
        'https://s3.nat-geo.ru/images/2019/9/14/a2b870a6af174201bad38a109ca4bb85.max-2500x1500.jpg',
    details: 'Деревня в Рамонском районе Воронежской области',
    type: 'природа',
  )
];

final mocksDetails = SightDetails(
  name: 'Пряности и радости',
  url: 'https://i1.photo.2gis.com/images/branch/31/4362862183976801_9315.jpg',
  details:
      'Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного',
  type: 'ресторан',
  workHours: 'закрыто до 09:00',
);
