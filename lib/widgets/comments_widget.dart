import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final String comment;

  CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      child: ListTile(
        leading: Icon(
          Icons.face,
          size: 20,
        ),
        title: Text(
          comment,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
