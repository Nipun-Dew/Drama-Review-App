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
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: dramas.length,
          itemBuilder: (context, index) {
            return Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme
                      .of(context)
                      .primaryColor,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor.withOpacity(0.9), BlendMode.dstATop,),
                      image: NetworkImage(
                          dramas[index].imageUrl
                      )
                  ),
                ),
                padding: EdgeInsets.only(),
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.012),
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
                ));
          }),
    );
  }
}
