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
  // late List<Item> displayItems;

  //var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      if (widget.id.toString() == 'teledrama') {
        Provider.of<Items>(context, listen: false).getTeledramas().then((_) {});
      }
      if (widget.id.toString() == 'web-series') {
        Provider.of<Items>(context, listen: false).getWebSeries().then((_) {});
      }
      if (widget.id.toString() == 'movie') {
        Provider.of<Items>(context, listen: false).getMovies().then((_) {});
      }
      if (widget.id.toString() == 'short-movie') {
        Provider.of<Items>(context, listen: false).getShortMovies().then((_) {});
      }
      if (widget.id.toString() == 'mini-series') {
        Provider.of<Items>(context, listen: false).getMiniSeries().then((_) {});
      }

      // if (widget.id.toString() == 'old-hits') {
      //   Provider.of<Items>(context, listen: false).getTeledramas().then((_) {
      // }
    });
    super.initState();
  }

  Future<void> _refreshItems(String id) async {
    // await Provider.of<Items>(context).getTeledramas();

    print("Refreshing");

    if (id.toString() == 'teledrama') {
      await Provider.of<Items>(context, listen: false).getTeledramas().then((_) {});
    }
    if (id.toString() == 'web-series') {
      await Provider.of<Items>(context, listen: false).getWebSeries().then((_) {});
    }
    if (id.toString() == 'movie') {
      await Provider.of<Items>(context, listen: false).getMovies().then((_) {});
    }
    if (id.toString() == 'short-movie') {
      await Provider.of<Items>(context, listen: false).getShortMovies().then((_) {});
    }
    if (id.toString() == 'mini-series') {
      await Provider.of<Items>(context, listen: false).getMiniSeries().then((_) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var displayItems;
    if (widget.id.toString() == 'teledrama') {
      displayItems = Provider.of<Items>(context).teledramaItems.toList();
    }
    if (widget.id.toString() == 'web-series') {
      displayItems = Provider.of<Items>(context).webseriesItems.toList();
    }
    if (widget.id.toString() == 'movie') {
      displayItems = Provider.of<Items>(context).movieItems.toList();
    }
    if (widget.id.toString() == 'short-movie') {
      displayItems = Provider.of<Items>(context).shortmovieItems.toList();
    }
    if (widget.id.toString() == 'mini-series') {
      displayItems = Provider.of<Items>(context).miniseriesItems.toList();
    }

    return Provider.of<Items>(context).isLoading
        ? Center(
            child: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
              child: CircularProgressIndicator(),
            ),
          )
        : RefreshIndicator(
            onRefresh: () => _refreshItems(widget.id.toString()),
            child: Column(
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
            ),
          );
  }
}
