import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'dart:math' as Math;

import '../../mocks.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();

  static _FilterScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_FilterScreenState>();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues distance = RangeValues(100, 10000);

  // final Sight sight;
  // _FilterScreenState({this.sight});

  List<FilterType> category = [
    FilterType(hotel, 'Отель', false),
    FilterType(restaurant, 'Ресторан', false),
    FilterType(particular, 'Особое место', false),
    FilterType(park, 'Парк', false),
    FilterType(museum, 'Музей', false),
    FilterType(caffe, 'Кафе', false),
  ];
  //List<FilterType> _categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_arrow_left),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    category.forEach((element) {
                      element.isSelected = false;
                    });
                  });
                },
                child: Text(actionAppBar,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: buttonColor)))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Категории',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: planIcon, fontWeight: FontWeight.normal),
              ),
            ),
            Expanded(
              child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  //crossAxisSpacing: 20,
                  //mainAxisSpacing: 20,
                  crossAxisCount: 3,
                  //childAspectRatio: 1,
                  children: category
                      .map((element) => WidgetCategory(element))
                      .toList()),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(distanceTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(fontWeight: FontWeight.normal)),
                          Text(
                            'от ${distance.start.round()} до ${distance.end.round()} м',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: planIcon,
                                    fontWeight: FontWeight.normal),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RangeSlider(
                      min: 100,
                      max: 10000,
                      values: distance,
                      onChanged: (RangeValues values) {
                        setState(() {
                          distance = values;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton(
                onPressed: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    'ПОКАЗАТЬ (${countPlaceInRange()})',
                    style: TextStyle(
                      color: iconColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void selectCategory(FilterType category) => setState(() {
        category.select();
        countPlaceInRange();
      });

  int countPlaceInRange() {
    final selectedTypes = [
      for (var category in category)
        if (category.isSelected) category.title,
    ];
    int result = 0;
    mocks.forEach((sight) {
      if (selectedTypes.contains(sight.type) &&
          arePointsNear(sight.coordinatePoint,
              CoordinatePoint(52.512044, 107.037643), distance)) {
        result++;
      }
    });
    return result;
  }

  bool arePointsNear(
      CoordinatePoint checkPoint, CoordinatePoint centerPoint, RangeValues km) {
    var kmEnd = km.end / 1000;
    var kmStart = km.start / 1000;
    var ky = 40000 / 360;
    var kx = Math.cos(Math.pi * centerPoint.lat / 180.0) * ky;
    var dx = (centerPoint.lng - checkPoint.lng).abs() * kx;
    var dy = (centerPoint.lat - checkPoint.lat).abs() * ky;
    return Math.sqrt(dx * dx + dy * dy) <= kmEnd &&
        Math.sqrt(dx * dx + dy * dy) >= kmStart;
  }
}

class WidgetCategory extends StatefulWidget {
  final FilterType filterType;
  const WidgetCategory(this.filterType);

  @override
  _WidgetCategoryState createState() => _WidgetCategoryState();
}

class _WidgetCategoryState extends State<WidgetCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          child: Stack(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(100.0),
                onTap: () {
                  setState(() {
                    //toggle();
                    FilterScreen.of(context).selectCategory(widget.filterType);
                  });
                },
                child: Container(
                  height: 80,
                  width: 80,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: SvgPicture.asset(
                      widget.filterType.icon,
                      color: buttonColor,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: greenLight.withOpacity(0.30),
                      shape: BoxShape.circle),
                ),
              ),
              Positioned(
                right: 5,
                bottom: 5,
                child: AnimatedContainer(
                  height: widget.filterType.isSelected ? 15 : 0,
                  width: widget.filterType.isSelected ? 15 : 0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor),
                  duration: Duration(milliseconds: 100),
                  child: SvgPicture.asset(
                    tickIcon,
                    color: Colors.black,
                  ),
                  curve: Curves.fastOutSlowIn,
                ),
              )
            ],
          ),
        ),
        Text(
          widget.filterType.title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}

class FilterType {
  String icon;
  String title;
  bool isSelected;

  FilterType(this.icon, this.title, this.isSelected);

  void select() {
    isSelected = !isSelected;
  }
}
