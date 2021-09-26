import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:places/ui/screen/onboarding.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future _isInitialized = Future.delayed(const Duration(seconds: 2));

  @override
  void initState() {
    _navigateToNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [-0.28, 1.61],
          colors: [green, greenYellow],
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          splashMap,
          height: 160,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _navigateToNext() async {
    return _isInitialized.then(
      (value) => Navigator.pushNamed(context, OnBoardingScreen.routeName),
    );
  }
}
