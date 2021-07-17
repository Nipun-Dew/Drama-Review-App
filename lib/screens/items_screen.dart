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
              ),
            ),
            buildingSectionTitle(context, "Cast"),
          ],
        ),
      ),
    );
  }
}
