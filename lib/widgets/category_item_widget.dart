import 'package:drama_app/models/item.dart';
import 'package:drama_app/providers/auth_provider.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/screens/auth_screen.dart';
import 'package:drama_app/screens/items_screen.dart';
import 'package:drama_app/screens/sign_btn_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/comment_screen.dart';

class ItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String category;
  final String imageUrls;
  final List<String> genres;
  final Item wholeItem;
  final String trailerVideoUrl;

  ItemWidget({required this.wholeItem, required this.id, required this.title, required this.imageUrls, required this.category, required this.genres, required this.trailerVideoUrl});

  void selectItemDetails(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ItemDetailsScreen(id, title, category, imageUrls, trailerVideoUrl, wholeItem);
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

  @override
  Widget build(BuildContext context) {
    bool isFavourite = Provider.of<Items>(context, listen: true).getFavItems.contains(wholeItem);

    final authData = Provider.of<Auth>(context);
    final isUserAuth = authData.isAuth;

    final token = authData.getToken.toString();

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
              onTap: () => {selectItemDetails(context)},
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      //imageUrl,
                      imageUrls,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Positioned(
                  //   bottom: 20,
                  //   left: 20,
                  //   // right: 20,
                  //   child: Container(
                  //     width: 300,
                  //     color: Colors.black54,
                  //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  //     child: Text(
                  //       title,
                  //       style: TextStyle(
                  //         fontSize: 26,
                  //         color: Colors.white,
                  //       ),
                  //       softWrap: true,
                  //       overflow: TextOverflow.fade,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  // TODO - display the list of genres
                  // Text(
                  //   genreText,
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Like Count"),
                Text("Comment Count"),
              ],
            ),
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
                          : Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return CommentScreen(id, imageUrls, wholeItem, token);
                            }));
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
                          onPressed: () => favBtnTap(isFavourite, context, wholeItem),
                          icon: isFavourite
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.grey,
                                )),
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
