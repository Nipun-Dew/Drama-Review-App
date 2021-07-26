import 'package:drama_app/providers/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String id;
  final String title;
  final String category;
  final String imageUrl;

  ItemDetailsScreen(this.id, this.title, this.category, this.imageUrl);

  Widget buildingSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.headline2),
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
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.37,
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
              buildingSectionTitle(context, selectedItem.title),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  selectedItem.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "RobotoCondensed-Light",
                      fontWeight: FontWeight.w500),
                ),
              ),
              buildingSectionTitle(context, "Director"),
              Text(
                selectedItem.director,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "RobotoCondensed-Light",
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              buildingSectionTitle(context, "Producer"),
              Text(
                selectedItem.producer,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "RobotoCondensed-Light",
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              buildingSectionTitle(context, "Cast"),
              buildContainer(
                ListView.builder(
                  itemCount: selectedItem.cast.length,
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(selectedItem.cast[index])),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
