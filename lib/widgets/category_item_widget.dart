import 'dart:io';

import 'package:drama_app/models/item.dart';
import 'package:drama_app/providers/auth_provider.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/screens/form_screens/item_update_form.dart';
import 'package:drama_app/screens/items_screen.dart';
import 'package:drama_app/widgets/alert_box_widget.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatefulWidget {
  final String id;
  final String title;
  final String category;
  final String imageUrls;
  final List<String> genres;
  final Item wholeItem;
  final String trailerVideoUrl;

  ItemWidget({required this.wholeItem, required this.id, required this.title, required this.imageUrls, required this.category, required this.genres, required this.trailerVideoUrl});

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  void selectItemDetails(BuildContext ctx, String token) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ItemDetailsScreen(widget.id, widget.title, widget.category, widget.imageUrls, widget.trailerVideoUrl, widget.wholeItem, token);
        },
      ),
    );
  }

  void favBtnTap(bool isFav, BuildContext context, Item item) {
    if (isFav) {
      Provider.of<Items>(context, listen: false).delFavItems = item;
    } else {
      Provider.of<Items>(context, listen: false).addFavItems = item;
    }
  }

  Widget rateStars(double starCount) {
    List<Widget> starList = [];
    var count = starCount.round();

    for (var i = 0; i < count; i++) {
      starList.add(
        Icon(
          Icons.star_rate_rounded,
          color: Colors.grey[400],
          size: 20,
        ),
      );
    }
    if (count.toDouble() > starCount) {
      starList.removeLast();
      starList.add(
        Icon(
          Icons.star_half_rounded,
          color: Colors.grey[400],
          size: 20,
        ),
      );
    }
    return Container(
      width: 100,
      child: Row(
        children: [
          ...starList,
        ],
      ),
    );
  }

  Future<void> _deleteItemHandler(String token, Item item, BuildContext context) async {
    print("delete");

    var url = Uri.parse(
      "https://sl-cinema.herokuapp.com/admin/cinema/delete/item/" + item.id,
    );

    try {
      var response = await http.delete(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + token,
          "content-type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        showDialog<Null>(
          context: context,
          builder: (ctx) => AlertBox("Item Deleted Succesfully", "Sucsessfull", ctx),
        );
      } else {
        showDialog<Null>(
          context: context,
          builder: (ctx) => AlertBox("Error! Item not Deleted!", "Error Occurred", ctx),
        );
      }
    } catch (err) {
      print("error");
      showDialog<Null>(
        context: context,
        builder: (ctx) => AlertBox("Error! Item not Deleted!", "Error Occurred", ctx),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    final token = authData.getToken.toString();

    Color gradientStart = Colors.transparent;
    Color gradientEnd = Colors.black;

    return Container(
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () => {selectItemDetails(context, token)},
              child: Stack(
                children: <Widget>[
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [gradientStart, gradientEnd],
                      ).createShader(Rect.fromLTRB(0, 20, bounds.width, bounds.height - 40));
                    },
                    blendMode: BlendMode.darken,
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.imageUrls),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 3,
                    // right: 20,
                    child: Container(
                      width: 250,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      child: FittedBox(
                        alignment: Alignment.bottomLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                            color: Colors.grey[400],
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 3,
                    // right: 20,
                    child: Container(
                      width: 250,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      child: Text(
                        widget.wholeItem.genres[0],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey[400],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 230,
                    // right: 20,
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      child: rateStars(widget.wholeItem.ratings),
                    ),
                  ),
                ],
              ),
            ),

            /////////// Only for ADMIN and EDITORS//////////////////////////
            authData.userType == "ROLE_ADMIN" ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    // _editItemHandler();
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return ItemUpdateFormScreen(widget.wholeItem);
                    }));
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            content: Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                child: Center(
                                    child: Text(
                                  "Do you want to Delete?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.grey[700],
                                  ),
                                ))),
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
                                          _deleteItemHandler(token, widget.wholeItem, context);
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text(
                                          "yes",
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
                                          "no",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ) : SizedBox(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
