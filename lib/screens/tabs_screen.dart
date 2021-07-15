import 'package:flutter/material.dart';

import './drawer_screen.dart';
import './fav_screen.dart';
import './home_screen.dart';
import './notifications_screen.dart';
import './tabs_screen.dart';
import './trending_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectIndex = 0;
  final List<Widget> _currentTab = [
    HomeScreen(),
    TrendingScreen(),
    FavouriteScreen(),
    NotificationScreen(),
    DrawerScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drama App"),
      ),
      body: _currentTab[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: "Trending"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.dehaze_rounded), label: "Drawer")
        ],
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.pink,
        elevation: 15,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.blueAccent[700],
      ),
    );
  }
}
