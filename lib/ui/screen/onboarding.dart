import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:places/domain/onBoard.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/onBoarding';
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  OnBoardingItem item;
  int selectedPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          selectedPage == 2
              ? const SizedBox.shrink()
              : TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text(
                    onBoardButton,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: buttonColor),
                  ),
                ),
        ],
      ),
      body: Stack(children: [
        Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: itemOnBoardList.length,
                onPageChanged: (page) {
                  setState(() {
                    selectedPage = page;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return OnBoardPage(item: itemOnBoardList[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: itemOnBoardList.length,
                effect: const ExpandingDotsEffect(
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  expansionFactor: 3,
                  dotColor: secondary2,
                  activeDotColor: greenYellow,
                ),
              ),
            ),
          ],
        ),
        selectedPage == 2
            ? const OnBoardBottomButton()
            : const SizedBox.shrink(),
      ]),
    );
  }
}

class OnBoardPage extends StatelessWidget {
  final OnBoardingItem item;

  const OnBoardPage({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 58.0, left: 58.0),
      child: Column(
        children: [
          SvgPicture.asset(
            item.assetName,
            height: 98,
            color: primaryColor2,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontSize: 24,
                  color: primaryColor2,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}

class OnBoardBottomButton extends StatelessWidget {
  const OnBoardBottomButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 8.0,
          left: 16,
          right: 16,
        ),
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          child: const Text(
            onBoardButtonBottom,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/home',
            );
          },
        ),
      ),
    );
  }
}
