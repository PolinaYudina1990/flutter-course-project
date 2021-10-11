import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/components/sightVisited.dart';
import 'package:places/components/sightWantVisit.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import '../../mocks.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            titleVisitedScreen,
            style: Theme.of(context).textTheme.headline3,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(30)),
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(
                        child: Text(
                          tabBar1,
                        ),
                      ),
                      Tab(
                        child: Text(
                          tabBar2,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            sightWantToVisitList(),
            sightVisited(),
          ],
        ),
      ),
    );
  }

  void onDismissedCard(place) {
    setState(() {
      onDelete(place);
    });
  }

  void onDelete(place) {
    setState(() {
      placeInteractor.removeFromFavorites(place);
    });
  }

  Widget sightWantToVisitList() {
    if (visSight.length > 0) {
      return SingleChildScrollView(
        child: FutureBuilder<List<Place>>(
            future: context.read<PlaceInteractor>().getVisitPlaces(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: Platform.isAndroid
                      ? ClampingScrollPhysics()
                      : BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return AspectRatio(
                      aspectRatio: 3 / 2,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        child: FavoriteWishVisit(
                          key: ValueKey(snapshot.data[index].name),
                          place: snapshot.data[index],
                          onDelete: () => onDelete(snapshot.data[index]),
                          onFilterChange: () => setState(() {}),
                          candidateDataList: snapshot.data,
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                );
              } else
                return SizedBox.shrink();
            }),
      );
    } else
      return _emptyWantToVisitScreen();
  }

  Widget sightVisited() {
    if (visitedSight.length > 0) {
      return SingleChildScrollView(
        child: FutureBuilder<List<Place>>(
            future: context.read<PlaceInteractor>().getVisitPlaces(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: Platform.isAndroid
                      ? ClampingScrollPhysics()
                      : BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return AspectRatio(
                      aspectRatio: 3 / 2,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        child: FavoriteVisited(
                          key: ValueKey(snapshot.data[index].name),
                          place: snapshot.data[index],
                          onDelete: () => onDelete(snapshot.data[index]),
                          onFilterChange: () => setState(() {}),
                          isDissmissed: () => onDelete(snapshot.data[index]),
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                );
              } else
                return SizedBox.shrink();
            }),
      );
    } else
      return _emptyVisitedScreen();
  }

  Widget _emptyWantToVisitScreen() {
    return Container(
      padding: EdgeInsets.only(top: 100, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(favoriteempty1, width: 70, color: secondary2),
          SizedBox(
            height: 20,
          ),
          Text(emptyScreenWantToVisit,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 20, color: secondary2)),
          SizedBox(
            height: 10,
          ),
          Text(emptyScreenWantToVisit2,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 17, color: secondary2),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _emptyVisitedScreen() {
    return Container(
      padding: EdgeInsets.only(top: 100, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(navigation, width: 70, color: secondary2),
          SizedBox(
            height: 20,
          ),
          Text(emptyScreenWantToVisit,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 20, color: secondary2)),
          SizedBox(
            height: 10,
          ),
          Text(emptyScreenWantToVisit2,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 17, color: secondary2),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
