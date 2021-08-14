import 'package:drama_app/widgets/category_types_widget.dart';

import '../../providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/upcoming_drama_widget.dart';
import '../category_items_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isCatClicked = Provider.of<Categories>(context, listen: true).categoryClicked;
    String id = Provider.of<Categories>(context, listen: true).catId;
    String title = Provider.of<Categories>(context, listen: true).catTitle;

    final categoryData = Provider.of<Categories>(context);
    final categories = categoryData.items;

    return !isCatClicked
        ? Column(
            children: [
              UpcomingDramas(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Column(
                children: categories
                    .map(
                      (catData) => CategoryItem(catData.id, catData.title, catData.imageUrl),
                    )
                    .toList(),
              ),
            ],
          )
        : CategoryItemScreen(id, title);
  }
}
