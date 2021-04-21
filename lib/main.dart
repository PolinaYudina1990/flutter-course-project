import 'package:flutter/material.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: isDarkMode ? darkTheme : lightTheme,
        home: Stack(children: <Widget>[
          HomeScreen(),
          Positioned(
            right: 30,
            top: 50,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                setState(
                  () {
                    isDarkMode = !isDarkMode;
                  },
                );
              },
              child: Text(
                isDarkMode ? 'Light' : 'Dark',
              ),
            ),
          )
        ]));
  }
}
