import 'package:drama_app/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tab_screens/drawer_screen.dart';
import 'tab_screens/fav_screen.dart';
import 'tab_screens/home_screen.dart';
import 'tab_screens/notifications_screen.dart';
import 'tab_screens/trending_screen.dart';
import 'search_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectIndex = 0;
  final List<String> titles = [
    "DreamOn...",
    "Trending",
    "Favourites",
    "Notifications",
    "More.."
  ];
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
      Provider.of<Categories>(context, listen: false).categoryClick = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    bool isCatClicked = Provider.of<Categories>(context, listen: true).categoryClicked;

    return Scaffold(
      //SingleChildScrollView(child: _currentTab[_selectIndex])
      body: Container(
        margin: EdgeInsets.only(top: statusBar),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              primary: false,
              floating: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              expandedHeight: phoneHeight * 0.12,
              title: !isCatClicked ? Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titles[_selectIndex],
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                      ),
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SearchScreen()));
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ) : Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      Provider.of<Categories>(context, listen: false).categoryClick = false;
                    },
                  ),
                  SizedBox(width: phoneWidth * 0.01,),
                  Text(
                    Provider.of<Categories>(context).catTitle,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(child: _currentTab[_selectIndex]),
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Trending"),
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
