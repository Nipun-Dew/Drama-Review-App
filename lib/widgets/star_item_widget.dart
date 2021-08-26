import 'package:flutter/material.dart';
import '../models/cast.dart';
import '../screens/star_item_screen.dart';

class StarItemWidget extends StatelessWidget {
  final Cast cast;

  StarItemWidget(this.cast);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      elevation: 4,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return StarItemScreen(cast);
              }));
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(cast.imageUrls[0]),
              maxRadius: 30,
            ),
            title: Text(
              cast.name,
              style: TextStyle(
                fontFamily: "RobotoCondensed-Light",
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            )),
      ),
    );
  }
}
