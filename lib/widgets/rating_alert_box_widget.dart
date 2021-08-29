import 'package:flutter/material.dart';
import '../models/item.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingAlertBox extends StatelessWidget {
  final BuildContext ctx;
  final double initialRateVal;
  final List<dynamic> ratingValues;
  final Function callOnRating;
  final Item wholeItem;

  RatingAlertBox(this.ctx, this.initialRateVal, this.ratingValues, this.callOnRating, this.wholeItem);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Center(
          child: RatingBar.builder(
            itemSize: 25,
            initialRating: initialRateVal,
            // initialRating: selectedItem.ratings,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 6.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              ratingValues.add(rating);
              callOnRating(rating, wholeItem);
            },
          ),
        ),
      ),
      actions: [
        Center(
          child: Divider(
            thickness: 0.3,
            color: Colors.grey[600],
          ),
        ),
        Center(
          child: TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                "Close",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              )),
        )
      ],
    );
  }
}
