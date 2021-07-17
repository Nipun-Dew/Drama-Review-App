import 'package:drama_app/widgets/category_types_widget.dart';

import '../../providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/upcoming_drama_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryData = Provider.of<Categories>(context);
    final categories = categoryData.items;

    return Column(
      children: [
        UpcomingDramas(),
        Column(
          children: categories
              .map(
                (catData) => CategoryItem(catData.id, catData.title, catData.imageUrl),
              )
              .toList(),
        ),
      ],
    );
  }
}
