import 'package:flutter/material.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/sight_list_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({
    Key key,
  }) : super(key: key);
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
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          const SightListScreen(),
          const Center(child: Text('Here will be map')),
          const FavoriteScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: tabController.index,
        onTap: (index) => tabController.animateTo(index),
        items: const [
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
