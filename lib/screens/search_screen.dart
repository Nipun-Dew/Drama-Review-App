import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
              width: MediaQuery.of(context).size.width * 0.97,
              margin: EdgeInsets.all(20),
              child: TextField(
                cursorHeight: 27,
                style: TextStyle(decoration: TextDecoration.none),
                decoration: InputDecoration(
                    icon: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.keyboard_arrow_down, size: 30,)),
                    contentPadding:
                        EdgeInsets.only(top: 1, left: 25, right: 20, bottom: 1),
                    fillColor: Colors.grey[300],
                    filled: true,
                    prefixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Search Dramas..."),
              ),
        ),
      ),
    );
  }
}
