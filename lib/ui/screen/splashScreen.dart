import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:places/ui/screen/onboarding.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future _isInitialized = Future.delayed(Duration(seconds: 2));

  @override
  void initState() {
    _navigateToNext();
    super.initState();
  }

  Future<void> _navigateToNext() async {
    return _isInitialized.then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return OnBoardingScreen();
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: [-0.28, 1.61], colors: [green, greenYellow])),
      child: Center(
        child: SvgPicture.asset(
          splashMap,
          height: 160,
          color: Colors.white,
        ),
      ),
    );
  }
}
