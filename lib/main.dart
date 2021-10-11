import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/redux/middleware/sight_search_middleware.dart';
import 'package:places/redux/reducer/reducer.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/onboarding.dart';
import 'package:places/ui/screen/select_category_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/sight_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

final settingsInteractor = SettingsInteractor();
void main() {
  final store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: [
      SightSearchMiddleware(
        SearchInteractor(
          placeRepository: PlaceRepository(),
        ),
      ),
    ],
  );

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp(this.store, {Key key}) : super(key: key);

  var placeRepository = PlaceRepository();
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
      child: StoreProvider<AppState>(
        store: store,
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
      ),
    );
  }
}
