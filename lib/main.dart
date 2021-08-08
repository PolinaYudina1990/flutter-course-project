import 'package:flutter/material.dart';
import 'package:places/dio_test.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/addSightScree.dart';
import 'package:places/ui/screen/filtersScreen.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/onboarding.dart';
import 'package:places/ui/screen/selectCategoryScreen.dart';
import 'package:places/ui/screen/settingsScreen.dart';
import 'package:places/ui/screen/sightSearchScreen.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/splashScreen.dart';
import 'package:places/ui/sight_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

void testDioCall() async {
  final responce = await getDioPosts();
  return responce;
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    testDioCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: notifier.darkTheme ? ThemeMode.dark : ThemeMode.light,
            // home: SplashScreen(),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              SightListScreen.routeName: (context) => SightListScreen(),
              OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              SearchScreen.routeName: (context) => SearchScreen(),
              AddNewSight.routeName: (context) => AddNewSight(),
              SelectCategoryScreen.routeName: (context) =>
                  SelectCategoryScreen(),
            },
          );
        },
      ),
    );
  }
}
