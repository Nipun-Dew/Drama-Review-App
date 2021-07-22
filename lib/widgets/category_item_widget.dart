import 'package:drama_app/models/item.dart';
import 'package:drama_app/screens/items_screen.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final Genre genre;

  ItemWidget({required this.id, required this.title, required this.imageUrl, required this.category, required this.genre});

  void selectItemDetails(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ItemDetailsScreen(this.id, this.title, this.category);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      "https://blog.hubspot.com/hubfs/Sales_Blog/famous-movie-quotes.jpg",
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
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.favorite),
                      ),
                      Text("like"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.favorite),
                      ),
                      Text("Comment"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.favorite),
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
