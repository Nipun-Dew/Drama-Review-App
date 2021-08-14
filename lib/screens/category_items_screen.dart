import 'package:drama_app/models/item.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryItemScreen extends StatefulWidget {
  final String title;
  final String id;

  CategoryItemScreen(this.id, this.title);

  @override
  _CategoryItemScreenState createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
  late List<Item> displayItems;

  var _isLoading = false;

  late String _methodSelector;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration.zero).then((_) {
      if (widget.id.toString() == 'teledrama') {
        Provider.of<Items>(context, listen: false).getTeledramas().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }

      if (widget.id.toString() == 'web-series') {
        Provider.of<Items>(context, listen: false).getWebSeries().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }

      if (widget.id.toString() == 'movie') {
        Provider.of<Items>(context, listen: false).getMovies().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }
      if (widget.id.toString() == 'short-movie') {
        Provider.of<Items>(context, listen: false).getShortMovies().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }
      if (widget.id.toString() == 'mini-series') {
        Provider.of<Items>(context, listen: false).getMiniSeries().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }

      // if (widget.id.toString() == 'old-hits') {
      //   Provider.of<Items>(context, listen: false).getTeledramas().then((_) {
      //     setState(() {
      //       _isLoading = false;
      //     });
      //   });
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemData = Provider.of<Items>(context);
    final displayItems = itemData.items.toList();

    // displayItems = items.where((item) {
    //   return item.category.contains(widget.id);
    // }).toList();

    return Column(
      children: [
        ...displayItems.map((item) {
          return ItemWidget(
            id: item.id,
            title: item.title,
            imageUrls: item.imageUrls[0],
            category: item.category,
            trailerVideoUrl: item.youtubeURL,
            genres: item.genres,
            wholeItem: item,
          );
        })
      ],
    );
  }
}
