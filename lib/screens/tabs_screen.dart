import 'package:flutter/material.dart';

import './drawer_screen.dart';
import './fav_screen.dart';
import './home_screen.dart';
import './notifications_screen.dart';
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            "DramaOn...",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 26,
            ),
          ),
        ),
      ),
      body: _currentTab[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie), label: "Trending"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favourite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(Icons.dehaze_rounded), label: "Drawer")
        ],
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
        elevation: 15,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
