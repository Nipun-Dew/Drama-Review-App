import 'package:drama_app/models/item.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/screens/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final Genre genre;
  final Item wholeItem;

  ItemWidget(
      {required this.wholeItem,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.category,
      required this.genre});

  void selectItemDetails(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ItemDetailsScreen(id, title, category, imageUrl);
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
    bool isFavourite =
        Provider.of<Items>(context, listen: true).getFavItems.contains(wholeItem);

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
                      imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    // right: 20,
                    child: Container(
                      width: 300,
                      color: Colors.black54,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.comment),
                      ),
                      Text("Comment"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          onPressed: () =>
                              favBtnTap(isFavourite, context, wholeItem),
                          icon: isFavourite
                              ? Icon(Icons.favorite, color: Colors.red,)
                              : Icon(Icons.favorite, color: Colors.grey,)),
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
