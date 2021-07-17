import 'package:drama_app/models/item.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItemScreen extends StatelessWidget {
  final String title;
  final String id;
  late List<Item> displayItems;

  CategoryItemScreen(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    final itemData = Provider.of<Items>(context);
    final items = itemData.items;

    displayItems = items.where((item) {
      return item.category.contains(id);
    }).toList();

    return Column(
      children: [
        ...displayItems.map((item) {
          return ItemWidget(
              id: item.id,
              title: item.title,
              imageUrl: item.imageUrl,
              category: item.category,
              genre: Genre.Action);
        })
//        ListView.builder(
//          itemBuilder: (ctx, index) {
//            return ItemWidget(
//                id: displayItems[index].id,
//                title: displayItems[index].title,
//                imageUrl: displayItems[index].imageUrl,
//                category: displayItems[index].category,
//                genre: Genre.Action);
//          },
//          itemCount: displayItems.length,
//        ),
      ],
    );
  }
}
