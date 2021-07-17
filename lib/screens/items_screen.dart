import 'package:drama_app/providers/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String id;
  final String title;
  final String category;

  ItemDetailsScreen(this.id, this.title, this.category);

  Widget buildingSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.title),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemData = Provider.of<Items>(context);
    final items = itemData.items;

    final selectedItem = items.firstWhere((item) => item.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                // selectedItem.imageUrl,
                "https://www.fmarion.edu/wp-content/uploads/2018/01/Movie-Night.jpg",
                fit: BoxFit.cover,
              ),
            ),
            buildingSectionTitle(context, selectedItem.title),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                selectedItem.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "RobotoCondensed-Light", fontWeight: FontWeight.w500),
              ),
            ),
            buildingSectionTitle(context, "Director"),
            Text(
              selectedItem.director,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "RobotoCondensed-Light", fontWeight: FontWeight.w400, fontSize: 20),
            ),
            buildingSectionTitle(context, "Producer"),
            Text(
              selectedItem.producer,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "RobotoCondensed-Light", fontWeight: FontWeight.w400, fontSize: 20),
            ),
            buildingSectionTitle(context, "Cast"),
            buildContainer(
              ListView.builder(
                itemCount: selectedItem.cast.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), child: Text(selectedItem.cast[index])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
