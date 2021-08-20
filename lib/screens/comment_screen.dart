import 'dart:convert';
import 'dart:io';

import 'package:drama_app/widgets/alert_box_widget.dart';
import 'package:drama_app/widgets/comments_widget.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/item.dart';

class CommentScreen extends StatefulWidget {
  final String id;
  final String imageUrl;
  final Item wholeItem;
  final String token;

  CommentScreen(this.id, this.imageUrl, this.wholeItem, this.token);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  final TextEditingController _controller = TextEditingController();

  bool canComment = false;

  Map<String, String> reviewItem = {};

  Future<void> callThisMethodOnTap(Map<String, String> itemGetting) async {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/user/cinema/review");

    try {
      var response = await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + widget.token,
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
    // print(token);
    List<Widget> commentWidgets = [];
    widget.wholeItem.reviews.forEach((user, comment) => commentWidgets.add(CommentItem(
          comment: comment,
          userID: user,
        )));

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: double.infinity,
                  child: Image.network(
                    // selectedItem.imageUrl,
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                  child: InkWell(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 50,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (val) {
                    if(val.isEmpty) {
                      setState(() {
                        canComment = false;
                      });
                    }
                    if(val.isNotEmpty) {
                      setState(() {
                        canComment = true;
                      });
                    }
                  },
                  cursorHeight: 27,
                  style: TextStyle(decoration: TextDecoration.none),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 1, left: 25, right: 20, bottom: 1),
                      suffixIcon: canComment ? InkWell(
                        child: Icon(
                          Icons.send,
                        ),
                        onTap: () {
                          reviewItem = {
                            "id": widget.wholeItem.id,
                            "review": _controller.text.toString(),
                          };
                          callThisMethodOnTap(reviewItem);
                          _controller.clear();
                          setState(() {
                            canComment = false;
                          });
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                      ) : null,
                      fillColor: Colors.grey[300],
                      filled: true,
                      //prefixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Write a Comment.."),
                  controller: _controller,
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: commentWidgets,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
