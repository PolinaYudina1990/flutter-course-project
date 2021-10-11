import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SightDetail extends StatefulWidget {
  final int sightId;

  const SightDetail({
    @required this.sightId,
    Key key,
  }) : super(key: key);

  @override
  _SightDetailState createState() => _SightDetailState();
}

class _SightDetailState extends State<SightDetail> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    int currentPage = 0;
    Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        currentPage++;
        if (currentPage > 3) {
          currentPage = 0;
        }
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final int sightId = ModalRoute.of(context).settings.arguments as int;
    final sight = mocks.firstWhere((sight) => sight.id == widget.sightId);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 320,
            backgroundColor: appBarColor,
            flexibleSpace: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: sight.urlImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PhotoGalery(
                      sight: sight,
                      pageNumber: index,
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: sight.urlImages.length,
                    effect: WormEffect(
                      dotColor: Colors.transparent,
                      activeDotColor: primaryColor2,
                      dotHeight: 10,
                      dotWidth: (MediaQuery.of(context).size.width - 25) /
                          sight.urlImages.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    sight.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        sight.titleType,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        sight.workHours,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    sight.details,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const NavigationButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(color: primaryColor2),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      PlanButton(),
                      SizedBox(
                        width: 30,
                      ),
                      FavoriteButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
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
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
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
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      icon: SvgPicture.asset(
        navigation,
        width: 30,
        color: iconColor,
      ),
      label: const Text(
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
    Future<DateTime> _openDateTimeSlection() async {
      if (Platform.isAndroid) {
        return await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          lastDate: DateTime.now().add(const Duration(days: 30)),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: buttonColor,
                  onPrimary: lmheadline2Color,
                  surface: buttonColor,
                  onSurface: lmheadline2Color,
                ),
                dialogBackgroundColor: Theme.of(context).primaryColor,
              ),
              child: child,
            );
          },
        );
      } else if (Platform.isIOS) {
        return await showCupertinoModalPopup(
          context: context,
          builder: (context) => SizedBox(
            height: 300,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {
                print(value);
              },
              initialDateTime: DateTime.now(),
              minimumDate: DateTime.now().subtract(const Duration(days: 30)),
              maximumDate: DateTime.now().add(const Duration(days: 30)),
              backgroundColor: Theme.of(context).backgroundColor,
            ),
          ),
        );
      }
    }

    return TextButton(
      onPressed: () {
        _openDateTimeSlection();
        print('button "plan" pressed ');
      },
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: planIcon),
          const SizedBox(
            width: 5,
          ),
          Text(
            toPlan,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.normal,
                  color: planIcon,
                ),
          ),
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
          const SizedBox(
            width: 5,
          ),
          Text(
            toFavorite,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class PhotoGalery extends StatelessWidget {
  final Sight sight;
  final int pageNumber;
  const PhotoGalery({
    this.sight,
    this.pageNumber,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
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
        const Positioned(
          top: 40,
          left: 15,
          child: AppBarBackButton(),
        ),
      ],
    );
  }
}
