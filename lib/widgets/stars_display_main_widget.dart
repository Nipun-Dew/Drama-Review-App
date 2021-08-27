import 'package:flutter/material.dart';

class StarsRatingMain extends StatelessWidget {
  final double starCount;

  StarsRatingMain(this.starCount);

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];
    var count = starCount.round();

    for (var i = 0; i < count; i++) {
      starList.add(
        Icon(
          Icons.star_rate_rounded,
          color: Colors.amber,
          size: 33,
        ),
      );
    }
    if (count.toDouble() > starCount) {
      starList.removeLast();
      starList.add(
        Icon(
          Icons.star_half_rounded,
          color: Colors.amber,
          size: 33,
        ),
      );
    }
    int length = starList.length;
    if (length < 5) {
      for (var i = 0; i < 5 - length; i++) {
        starList.add(
          Icon(
            Icons.star_outline_rounded,
            color: Colors.amber,
            size: 33,
          ),
        );
      }
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...starList,
        ],
      ),
    );
  }
}
