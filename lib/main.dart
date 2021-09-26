import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/dio_test.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/onboarding.dart';
import 'package:places/ui/screen/select_category_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/sight_list_screen.dart';
import 'package:provider/provider.dart';

final settingsInteractor = SettingsInteractor();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
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

  @override
  void dispose() {
    super.dispose();
    settingsInteractor.dispose();
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
        ),
      ],
      child: MaterialApp(
        theme: context.watch<SettingsInteractor>().getIsDark
            ? darkTheme
            : lightTheme,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          SightListScreen.routeName: (context) => const SightListScreen(),
          OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          AddNewSight.routeName: (context) => const AddNewSight(),
          SelectCategoryScreen.routeName: (context) =>
              const SelectCategoryScreen(),
        },
      ),
    );
  }
}
