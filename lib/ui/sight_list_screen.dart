import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:places/ui/screen/AddSightScree.dart';
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SearchField(),
                      SizedBox(height: 30),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: sightList(),
                  ),
                ],
              ),
            ),
          ),
          ButtonAdd(),
        ],
      ),
    );
  }
}

Widget sightList() {
  return Column(children: [
    ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 30),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: mocks.length,
      itemBuilder: (context, index) => SightCard(sight: mocks[index]),
    ),
  ]);
}

class SearchField extends StatefulWidget {
  SearchField({Key key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FilterScreen()));
              //! FilterButton
            },
          ),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}

class ButtonAdd extends StatefulWidget {
  ButtonAdd({Key key}) : super(key: key);

  @override
  _ButtonAddState createState() => _ButtonAddState();
}

class _ButtonAddState extends State<ButtonAdd> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: UnconstrainedBox(
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNewSight()));
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [greenYellow, buttonColor]),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 7),
                    Text(addButtonName)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
