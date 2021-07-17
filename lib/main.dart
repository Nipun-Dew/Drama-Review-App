import 'package:drama_app/providers/categories_provider.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/screens/category_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';
import './providers/upcoming_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DramaDetails()),
      ChangeNotifierProvider(create: (_) => Categories()),
      ChangeNotifierProvider(create: (_) => Items()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.blue,
        fontFamily: 'Raleway',
        textTheme: TextTheme(
          headline6: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: TabScreen(),
      //home: CategoryItemScreen(),
    );
  }
}
