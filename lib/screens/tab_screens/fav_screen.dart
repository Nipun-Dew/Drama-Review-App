import 'package:drama_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/items_provider.dart';
import '../../models/item.dart';
import '../../widgets/category_item_widget.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<Items>(context, listen: true).getFavItems;

    return Column(
      children: [
        ...items.map((item) {
          return ItemWidget(
              id: item.id,
              title: item.title,
              imageUrl: item.imageUrl,
              category: item.category,
              genre: Genre.Action,
              wholeItem: item
          );
        })
      ],
    );
  }
}
