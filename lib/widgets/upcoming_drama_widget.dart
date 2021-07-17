import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/upcoming_provider.dart';
import '../models/upcoming_drama.dart';

class UpcomingDramas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<UpcomingDrama> dramas =
        Provider.of<DramaDetails>(context).upcomingList;

    return Container(
      height: MediaQuery.of(context).size.height * 0.24,
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.012,
        left: MediaQuery.of(context).size.width * 0.012,
      ),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dramas.length,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.only(
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.012
                ),
                child: Ink(
                  //height: 100,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).accentColor.withOpacity(0.5),
                      Theme.of(context).accentColor,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    onTap: () {},
                    radius: 25,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        dramas[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ));
          }),
    );
  }
}
