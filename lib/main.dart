import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/dio_test.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/addSightScree.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/onboarding.dart';
import 'package:places/ui/screen/selectCategoryScreen.dart';
import 'package:places/ui/screen/sightSearchScreen.dart';
import 'package:places/ui/screen/splashScreen.dart';
import 'package:places/ui/sight_list_screen.dart';
import 'package:provider/provider.dart';
import 'data/interactor/settings_interactor.dart';
import 'data/repository/place_repository.dart';

final settingsInteractor = SettingsInteractor();
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
    settingsInteractor.addListener(() => setState(() {}));
    super.initState();
  }

  final placeRepository = PlaceRepository();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PlaceInteractor>(
          create: (_) => PlaceInteractor(placeRepository: placeRepository),
          dispose: (_, interactor) {
            interactor.dispose();
          },
        ),
        Provider<SearchInteractor>(
          create: (_) => SearchInteractor(placeRepository: placeRepository),
        ),
        Provider<SettingsInteractor>(
          create: (_) => SettingsInteractor(),
        )
      ],
      child: MaterialApp(
        theme: context.watch<SettingsInteractor>().getIsDark
            ? darkTheme
            : lightTheme,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          SightListScreen.routeName: (context) => SightListScreen(),
          OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          AddNewSight.routeName: (context) => AddNewSight(),
          SelectCategoryScreen.routeName: (context) => SelectCategoryScreen(),
        },
      ),
    );
  }
}
