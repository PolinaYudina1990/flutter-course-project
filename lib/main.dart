import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//       3.6.4.3-3.6.4.4
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyStatefullWidget(),
    );
  }
}

//       3.6.4.5

class MyStatelessWidget extends StatelessWidget {
  buildCall() {
    //return context.runtimeType;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example'),
          backgroundColor: Colors.blueGrey[900],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: Icon(
                    Icons.add_circle_sharp,
                    size: 80.0,
                  ),
                  onPressed: () {
                    buildCall();
                    print("${context.runtimeType}");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//       3.6.4.6
class MyStatefullWidget extends StatefulWidget {
  @override
  _MyStatefullWidgetState createState() => _MyStatefullWidgetState();
}

class _MyStatefullWidgetState extends State<MyStatefullWidget> {
  buildCounter() {
    return context.runtimeType;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example'),
          backgroundColor: Colors.blueGrey[900],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: Icon(
                    Icons.add_circle_sharp,
                    size: 80.0,
                  ),
                  onPressed: () {
                    setState(() {
                      buildCounter();
                      print("${context.runtimeType}");
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
