import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                )),
          ),
          Container(
            width: phoneWidth * 0.8,
            margin: EdgeInsets.only(
              top: phoneWidth * 0.05,
              bottom: phoneWidth * 0.05,
              left: phoneWidth * 0.01,
            ),
            child: TextField(
              cursorHeight: 27,
              style: TextStyle(decoration: TextDecoration.none),
              decoration: InputDecoration(
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
        ]),
      ),
    );
  }
}
