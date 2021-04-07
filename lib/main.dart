import 'package:flutter/material.dart';
import 'package:places/ui/screen/Sight_details.dart';
import 'package:places/ui/sight_list_screen.dart';
import 'domain/details.dart';
import 'mocks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SightDetail(description: mocksDetails),
      //home: SightListScreen(),
    );
  }
}
