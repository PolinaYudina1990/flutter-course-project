import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/mocks.dart';

class SightListScreen extends StatefulWidget {
  final List<Sight> sights;

  const SightListScreen({Key key, this.sights}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 210,
        elevation: 0,
        title: Text(
          'Список \nинтересных мест',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SightCard(sight: mocks[0]),
              SizedBox(height: 16),
              SightCard(sight: mocks[1]),
              SizedBox(height: 16),
              SightCard(sight: mocks[2]),
            ],
          ),
        ),
      ),
    );
  }
}
