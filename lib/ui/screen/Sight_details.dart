import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';

class SightDetail extends StatelessWidget {
  final Sight sight;
  final PageController _pageController = PageController();

  SightDetail({this.sight}) {
    _initPageController();
  }

  void _initPageController() {
    int currentPage = 0;

    Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        currentPage++;
        if (currentPage > sight.urlImages.length - 1) {
          currentPage = 0;
        }
        _pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 320,
        backgroundColor: appBarColor,
        flexibleSpace: PageView.builder(
          controller: _pageController,
          itemCount: sight.urlImages.length,
          itemBuilder: (BuildContext context, int index) {
            return PhotoGalery(
              sight: sight,
              pageNumber: index,
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text('${sight.name}',
                    style: Theme.of(context).textTheme.headline2),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('${sight.titleType}',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 30,
                    ),
                    Text('${sight.workHours}',
                        style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('${sight.details}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.normal)),
                SizedBox(
                  height: 30,
                ),
                NavigationButton(),
                SizedBox(
                  height: 20,
                ),
                Divider(color: primaryColor2),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlanButton(),
                    SizedBox(
                      width: 30,
                    ),
                    FavoriteButton(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Center(
          child: IconButton(
        onPressed: () {
          print('button "back" pressed ');
        },
        icon: Icon(Icons.keyboard_arrow_left),
      )),
    );
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      icon: SvgPicture.asset(
        navigation,
        width: 30,
        color: iconColor,
      ),
      label: Text(
        buildNavigation,
        style: TextStyle(
          color: iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      onPressed: () {
        print('button "ПОСТРОИТЬ МАРШРУТ" pressed ');
      },
    );
  }
}

class PlanButton extends StatelessWidget {
  const PlanButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('button "plan" pressed ');
      },
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: planIcon),
          SizedBox(
            width: 5,
          ),
          Text(toPlan,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.normal, color: planIcon))
        ],
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('button "put in favorite" pressed');
      },
      child: Row(
        children: [
          SvgPicture.asset(
            favorite,
            width: 25,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            toFavorite,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}

class PhotoGalery extends StatelessWidget {
  final Sight sight;
  final int pageNumber;
  const PhotoGalery({this.sight, this.pageNumber});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.network(
            sight.urlImages[pageNumber],
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
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
        Positioned(
          top: 40,
          left: 15,
          child: AppBarBackButton(),
        ),
        Positioned(
          bottom: 1,
          left: MediaQuery.of(context).size.width /
              sight.urlImages.length *
              pageNumber,
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor2,
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            width: MediaQuery.of(context).size.width / sight.urlImages.length,
            height: 8,
          ),
        ),
      ],
    );
  }
}
