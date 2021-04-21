import 'package:flutter/material.dart';
import '../sight_list_screen.dart';
import 'VisitingScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  var isDarkMode = false;
  final Function changeTheme;
  _HomeScreenState({this.changeTheme});

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
            icon: Icon(
              Icons.library_books,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
