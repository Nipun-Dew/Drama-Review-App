import 'package:drama_app/providers/categories_provider.dart';
import 'package:drama_app/screens/category_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  CategoryItem(this.id, this.title, this.imageUrl);

  void selectCategory(BuildContext ctx) {
    Provider.of<Categories>(ctx, listen: false).categoryClick = true;
    Provider.of<Categories>(ctx, listen: false).setCatId = id;
    Provider.of<Categories>(ctx, listen: false).setCatTitle = title;
//    Navigator.of(ctx).push(
//      MaterialPageRoute(
//        builder: (_) {
//          return CategoryItemScreen(id, title);
//        },
//      ),
//    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      child: Container(
        // padding: EdgeInsets.only(top: 5),
        margin: EdgeInsets.only(top: 10),
        width: 300,
        height: 80,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.yellow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            )),
      ),
    );
  }
}
