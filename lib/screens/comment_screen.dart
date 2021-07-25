import 'package:flutter/material.dart';

import '../models/item.dart';

class CommentScreen extends StatelessWidget {
  final String imageUrl;
  final Item wholeItem;

  CommentScreen(this.imageUrl, this.wholeItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: double.infinity,
                  child: Image.network(
                    // selectedItem.imageUrl,
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
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
              SizedBox(height: 80,),
              Center(
                child: Text("Comments are here!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
