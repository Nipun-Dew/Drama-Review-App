import 'dart:convert';
import 'dart:io';

import 'package:drama_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentItem extends StatelessWidget {
  final String comment;
  final String userID;
  final String date;
  final String time;
  final bool isUser;
  final String token;
  final Item wholeItem;

  CommentItem({
    required this.comment,
    required this.userID,
    required this.date,
    required this.time,
    required this.isUser,
    required this.token,
    required this.wholeItem,
  });

  TextEditingController _textFieldController = TextEditingController();

  Map timeDisplay(String time, String date) {
    String timeSlice = time.substring(0, 8);
    DateTime commentTime = DateTime.parse("${date}T$timeSlice");
    DateTime now = DateTime.now();
    final diff = now.difference(commentTime);
    late int display;
    late String types;
    if(diff.inMinutes < 60) {
      display = diff.inMinutes;
      types = "m";
    }
    else if (diff.inHours < 24) {
      display = diff.inHours;
      types = "h";
    }
    else if (diff.inDays < 7) {
      display = diff.inDays;
      types = "d";
    }
    else {
      double weeks = diff.inDays / 7;
      display = weeks.toInt();
      types = "w";
    }
    return {"amount": display, "types": types};
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, String comment) async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        "Edit Review",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _textFieldController,
                    // decoration: InputDecoration(),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                  ),
                ],
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        reviewItem = {
                          "id": wholeItem.id,
                          "review": _textFieldController.text.toString(),
                        };
                        callThisMethodOnTap(reviewItem);
                        Navigator.of(ctx).pop();
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  Map<String, String> reviewItem = {};

  Future<void> callThisMethodOnTap(Map<String, String> itemGetting) async {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/user/cinema/review");

    try {
      var response = await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + token,
          "content-type": "application/json",
        },
        body: json.encode(itemGetting),
      );

      if (response.statusCode == 200) {
        // showDialog<Null>(
        //   context: context,
        //   builder: (ctx) => AlertBox("Item Added Succesfully", "Sucsessfull", ctx),
        // );
      } else {}

      print(response.statusCode);
      print(response.body);
    } catch (err) {
      print("error");
    }
    // print(itemGetting);
  }

  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery.of(context).size.width;

    _textFieldController.text = comment;

    var timeObject = timeDisplay(time, date);

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            // width: 30,
            child: Icon(
              Icons.face,
              size: 48,
            ),
          ),
          Container(
            //width: phoneWidth * 0.83,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shadowColor: Colors.transparent,
                  color: isUser ? Colors.pink[50] : Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  margin:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 12, right: 25),
                        child: Text(userID,
                            style: TextStyle(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.fade),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 18, top: 11, bottom: 15),
                        child: Text(
                          comment,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: phoneWidth * 0.07, right: 7, bottom: 3),
                      child: Text(
                        "${timeObject['amount']} ${timeObject['types']}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    isUser
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: phoneWidth * 0.07, right: 7, bottom: 10, top: 10),
                                child: InkWell(
                                  onTap: () {
                                    _displayTextInputDialog(context, comment);
                                  },
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
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 15, right: 7, bottom: 10, top: 10),
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
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
