import 'package:flutter/material.dart';
import 'package:places/res/colors.dart';
import '../sight_list_screen.dart';
import 'VisitingScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.index = 0;
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          SightListScreen(),
          Center(child: Text('Here will be navigator screen')),
          FavoriteScreen(),
          Center(child: Text('Here will be settings')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: tabController.index,
        onTap: (index) => tabController.animateTo(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books, color: dividerColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: dividerColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: dividerColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: dividerColor),
            label: '',
          ),
        ],
      ),
    );
  }
}
