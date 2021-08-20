import 'dart:io';

import 'package:drama_app/models/item.dart';
import 'package:drama_app/providers/auth_provider.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/screens/auth_screen.dart';
import 'package:drama_app/screens/items_screen.dart';
import 'package:drama_app/screens/sign_btn_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/comment_screen.dart';

import 'package:http/http.dart' as http;

class ItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String category;
  final String imageUrls;
  final List<String> genres;
  final Item wholeItem;
  final String trailerVideoUrl;

  ItemWidget({required this.wholeItem, required this.id, required this.title, required this.imageUrls, required this.category, required this.genres, required this.trailerVideoUrl});

  void selectItemDetails(BuildContext ctx, String token) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ItemDetailsScreen(id, title, category, imageUrls, trailerVideoUrl, wholeItem, token);
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
    return Container(
      width: 100,
      child: Row(
        children: [
          ...starList,
        ],
      ),
    );
  }

  Future<void> addItemToFav(String token, ctx) async {
    var url = Uri.parse(
      "https://sl-cinema.herokuapp.com/user/cinema/wish-list/add?id=" + wholeItem.id,
    );

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + token,
          "content-type": "application/json",
        },
      );

      Provider.of<Items>(ctx, listen: false).getFavourits(token.toString()).then((_) {});

      print(response.statusCode);
      print(response.body);
    } catch (err) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFavourite = Provider.of<Items>(context, listen: true).getFavItems.contains(wholeItem);

    final authData = Provider.of<Auth>(context);
    final isUserAuth = authData.isAuth;

    final token = authData.getToken.toString();

    Color gradientStart = Colors.transparent;
    Color gradientEnd = Colors.black;

    return Container(
      child: Card(
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
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.darken,
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrls),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(15),
                      //     topRight: Radius.circular(15),
                      //   ),
                      //   child: Image.network(
                      //     //imageUrl,
                      //     imageUrls,
                      //     height: 250,
                      //     width: double.infinity,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 3,
                    // right: 20,
                    child: Container(
                      width: 250,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.grey[400],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 230,
                    // right: 20,
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      child: rateStars(wholeItem.ratings),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   child: Column(
            //     children: <Widget>[
            //       Text(
            //         title,
            //         style: TextStyle(
            //           fontSize: 26,
            //           fontWeight: FontWeight.w900,
            //         ),
            //       ),
            //       // TODO - display the list of genres
            //       // Text(
            //       //   genreText,
            //       //   style: TextStyle(
            //       //     fontSize: 20,
            //       //     fontWeight: FontWeight.w600,
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: <Widget>[
            //     Text("Like Count"),
            //     Text("Comment Count"),
            //   ],
            // ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.thumb_up),
                      ),
                      Text("like"),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      !isUserAuth
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return SignButtonScreen();
                                },
                              ),
                            )
                          : Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return CommentScreen(id, imageUrls, wholeItem, token);
                              }),
                            );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            !isUserAuth
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return SignButtonScreen();
                                      },
                                    ),
                                  )
                                : Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return CommentScreen(id, imageUrls, wholeItem, token);
                                      },
                                    ),
                                  );
                          },
                          icon: Icon(
                            Icons.comment,
                            color: Colors.grey,
                          ),
                        ),
                        Text("Review  "),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => {
                          // favBtnTap(isFavourite, context, wholeItem),
                          addItemToFav(token, context),
                        },
                        icon: isFavourite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite,
                                color: Colors.grey,
                              ),
                      ),
                      Text("Favourite"),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
