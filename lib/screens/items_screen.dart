import 'package:drama_app/providers/cast_provider.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/providers/role_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final String trailerVideoUrl;

  ItemDetailsScreen(this.id, this.title, this.category, this.imageUrl, this.trailerVideoUrl);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState(trailerVideoUrl: this.trailerVideoUrl);
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final String trailerVideoUrl;

  _ItemDetailsScreenState({required this.trailerVideoUrl});

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

  final ratingValues = [4.5, 3, 5];

  final initialRatingValue = 1;

  arraySum(List arr) {
    var sum = 0.0;
    arr.forEach((element) {
      sum = sum + element;
    });
    return sum;
  }

  late YoutubePlayerController _controller;

  initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(trailerVideoUrl).toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemData = Provider.of<Items>(context);
    final items = itemData.items;

    final castData = Provider.of<Casts>(context);
    final itemsCast = castData.items;

    final roleData = Provider.of<Roles>(context);
    final itemsRoles = roleData.items;

    final selectedItem = items.firstWhere((item) => item.id == widget.id);

    final selectedCast = [];
    final selectedRoles = [];

    itemsCast.forEach((cast) {
      selectedItem.cast.forEach((item) {
        if (cast.id == item) {
          selectedCast.add(cast);
        }
      });
    });

    itemsRoles.forEach((role) {
      selectedItem.directors.forEach((item) {
        if (role.id == item) {
          selectedRoles.add(role);
        }
      });
      selectedItem.producers.forEach((item) {
        if (role.id == item) {
          selectedRoles.add(role);
        }
      });
    });

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  ///////////////////////////////////////////////////////////////////////////////////
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 400.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction: 1.1,
                      aspectRatio: 16 / 9,
                    ),
                    items: [
                      ...selectedItem.imageUrl,
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: Image.network(
                              i,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
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
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    selectedItem.title,
                    style: TextStyle(fontFamily: "RobotoCondensed-Light", fontWeight: FontWeight.w500, fontSize: 25),
                  ),
                ),
              ),
              ////////////////////////////////////////////////////////////////////////////////////////////////
              Center(
                child: RatingBar.builder(
                  itemSize: 25,
                  initialRating: 3,
                  // initialRating: selectedItem.ratings,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 6.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratingValues.add(rating);
                    print(ratingValues);
                    print(rating);
                    print(arraySum(ratingValues) / ratingValues.length);
                  },
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 3, bottom: 15),
                  child: Text(
                    "4.5/5" + " (10)",
                    style: TextStyle(fontFamily: "RobotoCondensed-Light", fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, bottom: 5),
                child: Text(
                  "Plot Summary",
                  style: TextStyle(
                    fontFamily: "RobotoCondensed-Light",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20, left: 25, right: 25),
                child: Text(
                  selectedItem.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: "RobotoCondensed-Light", fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey[700]),
                ),
              ),
              /////////////////////////video Add///////////////////////////////////////////
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "Watch Trailer",
                  style: TextStyle(
                    fontFamily: "RobotoCondensed-Light",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
              ),

              ///////////////////////////////////////////////////////////////////////

              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "Cast",
                  style: TextStyle(
                    fontFamily: "RobotoCondensed-Light",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 2, right: 2),
                padding: EdgeInsets.only(left: 2, right: 2),
                // alignment: Alignment.center,
                height: 150,
                width: 400,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedCast.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(selectedCast[index].imageUrl),
                              maxRadius: 40,
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              selectedCast[index].name,
                              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      );
                    }),
              ),

              Container(
                margin: EdgeInsets.only(top: 5, left: 2, right: 2),
                padding: EdgeInsets.only(left: 2, right: 2),
                height: 150,
                width: 400,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ...selectedRoles.map((role) {
                        return Column(
                          children: [
                            Container(
                              width: 120,
                              margin: EdgeInsets.only(left: 5, right: 5, bottom: 2),
                              alignment: Alignment.center,
                              child: Text(
                                role.id[0] == "P" ? "Producer" : "Director",
                                style: TextStyle(
                                  fontFamily: "RobotoCondensed-Light",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2, left: 2, right: 2),
                              padding: EdgeInsets.only(left: 2, right: 2),
                              width: 120,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(role.imageUrl),
                                      maxRadius: 40,
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      role.name,
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[600]),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
