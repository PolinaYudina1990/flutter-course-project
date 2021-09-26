import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/components/geoposition.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/categories.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'dart:math' as Math;

class FilterScreen extends StatefulWidget {
  static const routeName = 'filtersScreen';
  final List<FilterType> categories;

  const FilterScreen({
    @required this.categories,
    Key key,
  }) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();

  static _FilterScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_FilterScreenState>();
}

class _FilterScreenState extends State<FilterScreen> {
  // RangeValues distance = RangeValues(100, 10000);
  List<Sight> filteredList = [];

  @override
  Widget build(BuildContext context) {
    final double phoneHeigh = MediaQuery.of(context).size.height;
    final double phoneWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                SearchInteractor.rangeValues = const RangeValues(100, 10000);
                categories.forEach((element) {
                  element.isSelected = false;
                });
              });
            },
            child: Text(
              actionAppBar,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: buttonColor),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              categoriesTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: planIcon, fontWeight: FontWeight.normal),
            ),
          ),
          phoneHeigh > 800 && phoneWidth > 480
              ? Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: 3,
                    children: categories
                        .map((element) => WidgetCategory(element))
                        .toList(),
                  ),
                )
              : Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: categories
                        .map((element) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 20,
                              ),
                              child: WidgetCategory(element),
                            ))
                        .toList(),
                  ),
                ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        distanceTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'от ${SearchInteractor.rangeValues.start.round()} до ${SearchInteractor.rangeValues.end.round()} м',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: planIcon,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RangeSlider(
                    min: 100,
                    max: 10000,
                    values: SearchInteractor.rangeValues,
                    onChanged: (RangeValues values) {
                      setState(() {
                        SearchInteractor.rangeValues = values;
                        print(sortedByRadius);
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
                decoration: const BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  'ПОКАЗАТЬ (${countPlaceInRange()})',
                  style: const TextStyle(
                    color: iconColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectCategory(FilterType category) => setState(() {
        category.select();
        countPlaceInRange();
      });

  int countPlaceInRange() {
    final selectedTypes = [
      for (var category in categories)
        if (category.isSelected) category.title,
    ];
    int result = 0;
    mocks.forEach((sight) {
      if (selectedTypes.contains(sight.titleType) &&
          arePointsNear(
            sight.coordinatePoint,
            CoordinatePoint(52.512044, 107.037643),
            SearchInteractor.rangeValues,
          )) {
        result++;
      }
    });
    return result;
  }

  bool arePointsNear(
    CoordinatePoint checkPoint,
    CoordinatePoint centerPoint,
    RangeValues km,
  ) {
    final kmEnd = km.end / 1000;
    final kmStart = km.start / 1000;
    const ky = 40000 / 360;
    final kx = Math.cos(Math.pi * centerPoint.lat / 180.0) * ky;
    final dx = (centerPoint.lng - checkPoint.lng).abs() * kx;
    final dy = (centerPoint.lat - checkPoint.lat).abs() * ky;
    return Math.sqrt(dx * dx + dy * dy) <= kmEnd &&
        Math.sqrt(dx * dx + dy * dy) >= kmStart;
  }
}

class WidgetCategory extends StatefulWidget {
  final FilterType filterType;
  const WidgetCategory(this.filterType, {Key key}) : super(key: key);

  @override
  _WidgetCategoryState createState() => _WidgetCategoryState();
}

class _WidgetCategoryState extends State<WidgetCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(100.0),
                onTap: () {
                  setState(() {
                    FilterScreen.of(context).selectCategory(widget.filterType);
                  });
                },
                child: Container(
                  height: 80,
                  width: 80,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: SvgPicture.asset(
                      widget.filterType.icon,
                      color: buttonColor,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: greenLight.withOpacity(0.30),
                    shape: BoxShape.circle,
                  ),
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
                    color: Theme.of(context).primaryColor,
                  ),
                  duration: const Duration(milliseconds: 100),
                  child: SvgPicture.asset(
                    tickIcon,
                    color: Colors.black,
                  ),
                  curve: Curves.fastOutSlowIn,
                ),
              ),
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
