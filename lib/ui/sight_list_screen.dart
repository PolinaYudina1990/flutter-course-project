import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:places/ui/screen/FiltersScreen.dart';
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
        toolbarHeight: 180,
        elevation: 0,
        title: Text(
          titleSightListScreen,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline5,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: planIcon,
                    ),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        filterIcon,
                        width: 20,
                        color: buttonColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterScreen()));
                        //! FilterButton
                      },
                    ),
                    border: InputBorder.none,
                    hintText: hintText,
                  ),
                ),
              ),
              SizedBox(height: 30),
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
