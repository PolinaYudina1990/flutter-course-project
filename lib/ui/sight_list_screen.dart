import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/domain/categories.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:places/store/place_list_store.dart';
import 'package:places/ui/screen/addSightScree.dart';
import 'package:places/ui/screen/error_screen.dart';
import 'package:places/ui/screen/filtersScreen.dart';
import 'package:places/ui/screen/sightSearchScreen.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:provider/provider.dart';

class SightListScreen extends StatefulWidget {
  final List<Sight> sights;
  static const routeName = '/sightList';

  const SightListScreen({Key key, this.sights}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ButtonAdd(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return PortraitMode();
          } else {
            return LandscapeMode();
          }
        },
      ),
    );
  }
}

class PortraitMode extends StatelessWidget {
  const PortraitMode({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlaceListStore _store = PlaceListStore(context.read<PlaceInteractor>());
    _store.getFilteredPlace(
      filter: PlacesFilterRequestDto(
        lat: GeoPoint.getMyCoordinates()['lat'],
        lng: GeoPoint.getMyCoordinates()['lon'],
        radius: 10000.0,
        typeFilter: typeFilters,
        nameFilter: '',
      ),
    );
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: _SliverAppBarDelegate(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 16, right: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SearchField(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 34, horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Observer(
                builder: (BuildContext context) {
                  final future = _store.listPlacesFuture;
                  if (future == null) {
                    return const CircularProgressIndicator();
                  }
                  if (future.status == FutureStatus.pending) {
                    return const CircularProgressIndicator();
                  }

                  if (future.status == FutureStatus.rejected) {
                    return ErrorScreen();
                  }

                  if (future.status == FutureStatus.fulfilled) {
                    return ListView.builder(
                      itemCount: future.result.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SightCard(
                            place: Place(
                              name: future.result[index].name,
                              lat: future.result[index].lat,
                              lng: future.result[index].lng,
                              urls: future.result[index].urls,
                              description: future.result[index].description,
                              id: future.result[index].id,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LandscapeMode extends StatelessWidget {
  const LandscapeMode({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PlaceListStore _store = PlaceListStore(context.read<PlaceInteractor>());
    _store.getFilteredPlace(
      filter: PlacesFilterRequestDto(
        lat: GeoPoint.getMyCoordinates()['lat'],
        lng: GeoPoint.getMyCoordinates()['lon'],
        radius: 10000.0,
        typeFilter: typeFilters,
        nameFilter: '',
      ),
    );
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: _SliverAppBarDelegate(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 16, right: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SearchField(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 34, horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Observer(
                builder: (BuildContext context) {
                  final future = _store.listPlacesFuture;
                  if (future == null) {
                    return SliverToBoxAdapter(
                        child: const CircularProgressIndicator());
                  }
                  if (future.status == FutureStatus.pending) {
                    return SliverToBoxAdapter(
                        child: const CircularProgressIndicator());
                  }

                  if (future.status == FutureStatus.rejected) {
                    return ErrorScreen();
                  }
                  if (future.status == FutureStatus.fulfilled) {
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              width: double.infinity,
                              child: SightCard(
                                place: Place(
                                  name: future.result[index].name,
                                  lat: future.result[index].lat,
                                  lng: future.result[index].lng,
                                  urls: future.result[index].urls,
                                  description: future.result[index].description,
                                  id: future.result[index].id,
                                ),
                              ),
                            ));
                      }),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 36,
                        childAspectRatio: 1.5,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  SearchField({Key key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            readOnly: true,
            onTap: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline5,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: planIcon,
              ),
              border: InputBorder.none,
              hintText: hintText,
            ),
          ),
        ),
        IconButton(
          icon: SvgPicture.asset(
            filterIcon,
            width: 20,
            color: buttonColor,
          ),
          onPressed: () {
            _getFilteredList(context);
          },
        ),
      ],
    );
  }

  void _getFilteredList(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FilterScreen(
          categories: [],
        ),
      ),
    ); //!
  }
}

class ButtonAdd extends StatefulWidget {
  ButtonAdd({Key key}) : super(key: key);

  @override
  _ButtonAddState createState() => _ButtonAddState();
}

class _ButtonAddState extends State<ButtonAdd> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: UnconstrainedBox(
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddNewSight.routeName);
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [greenYellow, buttonColor]),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 7),
                    Text(addButtonName)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: Container(
        color: Colors.white,
        child: shrinkOffset > 40
            ? Center(
                child: Text(
                  titleSightListScreen2,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )
            : Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  titleSightListScreen,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 32, fontWeight: FontWeight.w700),
                ),
              ),
      ),
    );
  }

  @override
  double get maxExtent => 160;

  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
