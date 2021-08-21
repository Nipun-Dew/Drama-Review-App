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

  Future<void> _displayTextInputDialog(BuildContext context, String comment) async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        )),
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
