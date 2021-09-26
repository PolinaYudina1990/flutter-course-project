import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/bloc/visiting_screen/visiting_screen_block.dart';
import 'package:places/bloc/visiting_screen/visiting_screen_event.dart';
import 'package:places/bloc/visiting_screen/visiting_screen_state.dart';
import 'package:places/components/sight_visited.dart';
import 'package:places/components/sight_want_visit.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key key}) : super(key: key);

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
            preferredSize: const Size.fromHeight(80.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TabBar(
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
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider<VisitingScreenBlock>(
                create: (_) =>
                    VisitingScreenBlock(context.read<PlaceInteractor>())
                      ..add(PlanedSightsLoad()),
                child: sightWantToVisitList()),
            BlocProvider<VisitingScreenBlock>(
                create: (_) =>
                    VisitingScreenBlock(context.read<PlaceInteractor>())
                      ..add(VisitedSightsLoad()),
                child: sightVisited()),
          ],
        ),
      ),
    );
  }

  Widget sightWantToVisitList() {
    if (visSight.isNotEmpty) {
      return SingleChildScrollView(
        child: BlocBuilder<VisitingScreenBlock, VisitingScreenState>(
          builder: (_, state) {
            if (state is PlanedSightsLoadSuccess) {
              return ListView.builder(
                shrinkWrap: true,
                physics: Platform.isAndroid
                    ? const ClampingScrollPhysics()
                    : const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return AspectRatio(
                    aspectRatio: 3 / 2,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: FavoriteWishVisit(
                        key: ValueKey(state.visSight[index].name),
                        place: state.visSight[index],
                        onDelete: () => context
                            .read<VisitingScreenBlock>()
                            .add(PlanedSightRemovePlace(state.visSight[index])),
                        onFilterChange: () => setState(() {}),
                        candidateDataList: state.visSight,
                      ),
                    ),
                  );
                },
                itemCount: state.visSight.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              );
            } else if (state is VisitingScreenLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _emptyWantToVisitScreen();
            }
          },
        ),
      );
    }
  }

  Widget sightVisited() {
    if (visitedSight.isNotEmpty) {
      return SingleChildScrollView(
        child: BlocBuilder<VisitingScreenBlock, VisitingScreenState>(
          builder: (_, state) {
            if (state is VisitedSightLoadedSuccess) {
              return ListView.builder(
                shrinkWrap: true,
                physics: Platform.isAndroid
                    ? const ClampingScrollPhysics()
                    : const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return AspectRatio(
                    aspectRatio: 3 / 2,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: FavoriteVisited(
                        key: ValueKey(state.visitedSights[index].name),
                        place: state.visitedSights[index],
                        onDelete: () => context.read<VisitingScreenBlock>().add(
                            PlanedSightRemovePlace(state.visitedSights[index])),
                        onFilterChange: () => setState(() {}),
                        isDissmissed: () => context
                            .read<VisitingScreenBlock>()
                            .add(PlanedSightRemovePlace(
                                state.visitedSights[index])),
                      ),
                    ),
                  );
                },
                itemCount: state.visitedSights.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              );
            } else if (state is VisitingScreenLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    } else {
      return _emptyVisitedScreen();
    }
  }

  Widget _emptyWantToVisitScreen() {
    return Container(
      padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
      child: Column(
        children: [
          SvgPicture.asset(favoriteempty1, width: 70, color: secondary2),
          const SizedBox(
            height: 20,
          ),
          Text(
            emptyScreenWantToVisit,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontSize: 20,
                  color: secondary2,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            emptyScreenWantToVisit2,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontSize: 17, color: secondary2),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _emptyVisitedScreen() {
    return Container(
      padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
      child: Column(
        children: [
          SvgPicture.asset(navigation, width: 70, color: secondary2),
          const SizedBox(
            height: 20,
          ),
          Text(
            emptyScreenWantToVisit,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontSize: 20,
                  color: secondary2,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            emptyScreenWantToVisit2,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontSize: 17, color: secondary2),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
