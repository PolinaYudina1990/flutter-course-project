import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/components/sightVisited.dart';
import 'package:places/components/sightWantVisit.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import '../../mocks.dart';

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

  void _onChange() {
    setState(() {
      visSight = mocks.where((sight) => sight.wantToVisit == true).toList();
      visitedSight = mocks.where((sight) => sight.visited == true).toList();
    });
  }

  Widget sightWantToVisitList() {
    if (visSight.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: visSight.length,
          itemBuilder: (context, index) => FavoriteWishVisit(
            sight: visSight[index],
            key: ObjectKey(visSight[index]),
            onFilterChange: () {
              setState(() {});
            },
            onDelete: () {
              visitedSight.add(visSight[index]);
              _onChange();
            },
          ),
        ),
      );
    } else
      return _emptyWantToVisitScreen();
  }

  Widget sightVisited() {
    if (visitedSight.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: visitedSight.length,
          itemBuilder: (context, index) => FavoriteVisited(
            sight: visitedSight[index],
            key: ObjectKey(visitedSight[index]),
            onDelete: () {
              visitedSight.remove(visitedSight[index]);
              _onChange();
            },
          ),
        ),
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
