import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/widgets/comments_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';

class CommentScreen extends StatelessWidget {
  final String id;
  final String imageUrl;
  final Item wholeItem;

  CommentScreen(this.id, this.imageUrl, this.wholeItem);

  @override
  Widget build(BuildContext context) {
    final itemData = Provider.of<Items>(context);
    final items = itemData.items;

    final selectedItem = items.firstWhere((item) => item.id == id);

    List<Widget> commentWidgets = [];
    selectedItem.reviews.forEach((user, comment) =>
        commentWidgets.add(CommentItem(
          comment: comment, userID: user,)));

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .padding
            .top),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.33,
                  width: double.infinity,
                  child: Image.network(
                    // selectedItem.imageUrl,
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .height * 0.02),
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
                  cursorHeight: 27,
                  style: TextStyle(decoration: TextDecoration.none),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 1, left: 25, right: 20, bottom: 1),
                      suffixIcon: Icon(Icons.send),
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
