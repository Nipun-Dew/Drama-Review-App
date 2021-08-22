import 'package:drama_app/models/item.dart';
import 'package:drama_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/items_provider.dart';
import '../../models/item.dart';
import '../../widgets/category_item_widget.dart';
import '../../providers/auth_provider.dart';
import '../../screens/sign_btn_screen.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      final token = Provider.of<Auth>(context, listen: false).getToken;
      Provider.of<Items>(context, listen: false)
          .getFavourits(token.toString())
          .then((_) {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingPage = Center(
        child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
            child: CircularProgressIndicator()));

    List<Item> items = Provider.of<Items>(context, listen: true).getFavItems;

    return Provider.of<Auth>(context).isAuth
        ? Column(
            children: [
              ...items.map((item) {
                return ItemWidget(
                  id: item.id,
                  title: item.title,
                  imageUrls: item.imageUrls[0],
                  category: item.category,
                  genres: item.genres,
                  wholeItem: item,
                  trailerVideoUrl: item.youtubeURL,
                );
              })
            ],
          )
        : FutureBuilder(
            future: Provider.of<Auth>(context, listen: true).autoLogin(),
            builder: (ctx, authResult) =>
                authResult.connectionState == ConnectionState.waiting
                    ? loadingPage
                    : Center(
                        child: ElevatedButton(
                          child: Text("Login"),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return SignButtonScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ));
  }
}
