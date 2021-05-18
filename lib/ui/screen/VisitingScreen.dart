import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import '../../mocks.dart';
import 'Sight_details.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List wantVisit = [];
  List visitedList = [];
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
    wantVisit = mocks.where((sight) => sight.wantToVisit == true).toList();
    visitedList = mocks.where((sight) => sight.visited == true).toList();
    setState(() {
      visSight = wantVisit;
      visitedSight = visitedList;
    });
  }

  Widget sightWantToVisitList() {
    setState(() {
      wantVisit = mocks.where((sight) => sight.wantToVisit == true).toList();
      visSight = wantVisit;
    });
    if (wantVisit.length > 0) {
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
              wantVisit.remove(visSight[index]);
              visitedList.add(visSight[index]);
              _onChange();
            },
          ),
        ),
      );
    } else
      return _emptyWantToVisitScreen();
  }

  Widget sightVisited() {
    setState(() {
      visitedList = mocks.where((sight) => sight.visited == true).toList();
      visitedSight = visitedList;
    });
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
              visitedList.remove(visitedSight[index]);
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

class FavoriteWishVisit extends StatelessWidget {
  final Sight sight;
  final VoidCallback onDelete;
  final VoidCallback onFilterChange;

  const FavoriteWishVisit(
      {Key key, this.sight, this.onDelete, this.onFilterChange});
  static const double Height = 120;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Sight>(
      builder: (
        BuildContext context,
        List<Sight> candidateData,
        List<dynamic> rejectedData,
      ) {
        return LongPressDraggable(
          data: sight,
          axis: Axis.vertical,
          feedback: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: sightCard(context)),
          child: sightCard(context),
          childWhenDragging: const SizedBox.shrink(),
        );
      },
      // onAccept: (newFilteredSight) {
      //   final int oldIndex = visSight.indexOf(sight);
      //   final int newIndex = visSight.indexOf(newFilteredSight);
      //   visSight.removeAt(oldIndex);
      //   visSight.insert(newIndex, sight);
      // visSight[oldIndex] = newFilteredSight;
      // visSight[newIndex] = sight;
      //   onFilterChange();
      // },
    );
  }

  Widget sightCard(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SightDetail(sight: sight)));
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 30),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                      ),
                      child: Image.network(
                        '${sight.url}',
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    height: FavoriteWishVisit.Height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        '${sight.titleType}',
                        style: Theme.of(context).textTheme.bodyText2,
                      )),
                  Positioned(
                    //!button share
                    top: 1,
                    right: 40,
                    child: IconButton(
                      icon: Icon(Icons.share, size: 28, color: iconColor),
                      onPressed: () {
                        print('button "share" pressed');
                        onDelete();
                      },
                    ),
                  ),
                  Positioned(
                    //!button close
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close, size: 30, color: iconColor),
                      onPressed: () {
                        sight.wantToVisit = !sight.wantToVisit;
                        sight.visited = !sight.visited;
                        print(' want to visit $sight.wantToVisit');
                        onDelete();
                      },
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(15),
                    bottomRight: const Radius.circular(15),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: FavoriteWishVisit.Height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${sight.name}',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Запланировано на 12 окт.2020',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${sight.workHours}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteVisited extends StatelessWidget {
  final Sight sight;
  final VoidCallback onDelete;
  final VoidCallback onFilterChange;

  const FavoriteVisited(
      {Key key, this.sight, this.onDelete, this.onFilterChange});
  static const double Height = 120;
  @override
  Widget build(BuildContext context) {
    return DragTarget<Sight>(
      builder: (
        BuildContext context,
        List<Sight> candidateData,
        List<dynamic> rejectedData,
      ) {
        return LongPressDraggable(
          data: sight,
          axis: Axis.vertical,
          feedback: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: sightCardVisited(context)),
          child: sightCardVisited(context),
          childWhenDragging: const SizedBox.shrink(),
        );
      },
    );
  }

  Widget sightCardVisited(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SightDetail(sight: sight)));
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                      ),
                      child: Image.network(
                        '${sight.url}',
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    height: Height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        '${sight.titleType}',
                        style: Theme.of(context).textTheme.bodyText2,
                      )),
                  Positioned(
                    //!button share
                    top: 1,
                    right: 40,
                    child: IconButton(
                      icon: Icon(Icons.share, size: 28, color: iconColor),
                      onPressed: () {
                        print('button "share" pressed');
                      },
                    ),
                  ),
                  Positioned(
                    //!button close
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close, size: 30, color: iconColor),
                      onPressed: () {
                        onDelete();
                        print('fyui');
                        sight.visited = !sight.visited;
                      },
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(15),
                    bottomRight: const Radius.circular(15),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: Height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${sight.name}',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Цель достигнута 12 окт. 2020',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${sight.workHours}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
