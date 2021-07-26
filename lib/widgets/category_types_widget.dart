import 'package:drama_app/providers/categories_provider.dart';
import 'package:drama_app/screens/category_items_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  CategoryItem(this.id, this.title, this.imageUrl);

  void selectCategory(BuildContext ctx) {
    Provider
        .of<Categories>(ctx, listen: false)
        .categoryClick = true;
    Provider
        .of<Categories>(ctx, listen: false)
        .setCatId = id;
    Provider
        .of<Categories>(ctx, listen: false)
        .setCatTitle = title;
  }

  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double phoneHeight = MediaQuery
        .of(context)
        .size
        .height;

    return InkWell(
      onTap: () => selectCategory(context),
      child: Container(
        // padding: EdgeInsets.only(top: 5),
        margin: EdgeInsets.only(top: phoneHeight * 0.02),
        width: phoneWidth * 0.95,
        height: phoneHeight * 0.15,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.yellow,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme
                  .of(context)
                  .primaryColor,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor.withOpacity(0.7), BlendMode.dstATop,),
                  image: NetworkImage(
                      imageUrl
                  )
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 34,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
