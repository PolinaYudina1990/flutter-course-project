import 'package:flutter/material.dart';

void main() {
  runApp(MyStatelessWidget());
}

//       3.6.3/1-3.6.3/3
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyFirstWidget(),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  const MyFirstWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hello!'),
      ),
    );
  }
}
//       3.6.3/4-3.6.3/7

class MyStatelessWidget extends StatelessWidget {
  int counter = 1;

  void buildCall() {
    counter++;
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
                    print(counter);
                  },
                ),
                Text('Build was called $counter times'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//       3.6.3/8
class MyStatefullWidget extends StatefulWidget {
  @override
  _MyStatefullWidgetState createState() => _MyStatefullWidgetState();
}

class _MyStatefullWidgetState extends State<MyStatefullWidget> {
  int counter = 1;

  void buildCounter() {
    counter++;
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
                      print(counter);
                    });
                  },
                ),
                Text('Build was called $counter times'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
