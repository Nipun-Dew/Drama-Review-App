import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final String comment;
  final String userID;
  final String date;
  final String time;
  final bool isUser;

  CommentItem({
    required this.comment,
    required this.userID,
    required this.date,
    required this.time,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            // width: 30,
            child: Icon(
              Icons.face,
              size: 50,
            ),
          ),
          Container(
            width: phoneWidth * 0.83,
            child: Card(
              color: isUser ? Colors.white60 : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15), topLeft: Radius.circular(15)),
              ),
              elevation: 4,
              margin: EdgeInsets.only(top: 5, bottom: 15, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      userID,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 7, top: 7, bottom: 10),
                    child: Text(
                      comment,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 7, bottom: 10),
                        child: Text(
                          date,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 7, bottom: 10),
                        child: Text(
                          time,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  isUser
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 7, bottom: 10),
                              child: Text(
                                "Edit",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 7, bottom: 10),
                              child: Text(
                                "Delete",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
