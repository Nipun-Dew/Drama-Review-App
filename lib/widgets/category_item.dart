import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;

  CategoryItem(
    this.id,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.only(top: 10),
      width: 300,
      height: 80,
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(id),
                Text(title),
              ],
            )
          ],
        ),
      ),
    );
  }
}
