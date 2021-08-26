import 'dart:io';
import 'dart:math';

import 'package:drama_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/item.dart';
import 'comment_screen.dart';
import 'package:drama_app/screens/sign_btn_screen.dart';
import 'package:drama_app/providers/items_provider.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final String trailerVideoUrl;
  final Item wholeItem;
  final String token;

  ItemDetailsScreen(this.id, this.title, this.category, this.imageUrl,
      this.trailerVideoUrl, this.wholeItem, this.token);

  @override
  _ItemDetailsScreenState createState() =>
      _ItemDetailsScreenState(this.trailerVideoUrl, this.wholeItem, this.token);
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final String trailerVideoUrl;
  final Item wholeItem;
  final String token;

  final ratingValues = [];
  final initialRatingValue = 1;

  bool isFavourite = false;
  bool isLoading = true;
  late YoutubePlayerController _controller;

  _ItemDetailsScreenState(this.trailerVideoUrl, this.wholeItem, this.token);

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

  // arraySum(List arr) {
  //   var sum = 0.0;
  //   arr.forEach((element) {
  //     sum = sum + element;
  //   });
  //   return sum;
  // }

  double roundDouble(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      final favList =
          await Provider.of<Items>(context, listen: false).getFavourits(token);
      if (favList.isNotEmpty) {
        favList.forEach((item) {
          if (wholeItem.id.toString() == item.id.toString()) {
            isFavourite = true;
          } else {
            isFavourite = false;
          }
        });
      }
      isLoading = false;
    });

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

  Future<void> callOnRating(double ratingValue, Item item) async {
    print(ratingValue);

    var url = Uri.parse(
      "https://sl-cinema.herokuapp.com/user/cinema/rate?id=" +
          item.id +
          "&rate=" +
          ratingValue.toString(),
    );

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + widget.token,
          "content-type": "application/json",
        },
      );
      print(response.statusCode);
      print(response.body);
    } catch (err) {
      print("error");
    }
  }

  Future<List<Item>?> addItemToFavourites(String token, ctx) async {
    var url = Uri.parse(
      "https://sl-cinema.herokuapp.com/user/cinema/wish-list/add?id=" +
          wholeItem.id,
    );

    try {
      var response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + token,
          "content-type": "application/json",
        },
      );

      if (response.statusCode != 200) {
        setState(() {
          isFavourite = !isFavourite;
        });
      }

      final favList = await Provider.of<Items>(ctx, listen: false)
          .getFavourits(token.toString());

      print(response.statusCode);
      print(response.body);
      return favList;
    } catch (err) {
      print("error");
    }
  }

  void showAlertDialogBox(BuildContext context, double initialRateVal) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
              child: RatingBar.builder(
                itemSize: 25,
                initialRating: initialRateVal,
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
                  callOnRating(rating, wholeItem);
                },
              ),
            ),
          ),
          actions: [
            Center(
              child: Divider(
                thickness: 0.3,
                color: Colors.grey[600],
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    "Close",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  )),
            )
          ],
        );
      },
    );
  }

  Widget rateStars(double starCount) {
    List<Widget> starList = [];
    var count = starCount.round();

    for (var i = 0; i < count; i++) {
      starList.add(
        Icon(
          Icons.star_rate_rounded,
          color: Colors.amber,
          size: 33,
        ),
      );
    }
    if (count.toDouble() > starCount) {
      starList.removeLast();
      starList.add(
        Icon(
          Icons.star_half_rounded,
          color: Colors.amber,
          size: 33,
        ),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...starList,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    final isUserAuth = authData.isAuth;

    final authUserId = Provider.of<Auth>(context).getUserId;

    final selectedCast = [];

    final selectedRoles = [];

    wholeItem.cast.forEach((item) {
      selectedCast.add({
        "name": item['starID'],
        "roleName": item['role'],
        "imageUrl": item['imageUrl'],
      });
    });

    wholeItem.directors.forEach((item) {
      selectedRoles.add({
        "name": item['starID'],
        "roleName": item['role'],
        "imageUrl": item['imageUrl'],
      });
    });

    wholeItem.producers.forEach((item) {
      selectedRoles.add({
        "name": item['starID'],
        "roleName": item['role'],
        "imageUrl": item['imageUrl'],
      });
    });

    double initialRateVal = 0.0;

    if (wholeItem.rateMap.isEmpty) {
      initialRateVal = 0.0;
    } else {
      wholeItem.rateMap.forEach((item) {
        if (item['user'].toString() == authUserId.toString()) {
          initialRateVal = double.parse(item['rate'].toString());
        }
      });
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                      ...wholeItem.imageUrls,
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
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
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
                    wholeItem.title,
                    style: TextStyle(
                        fontFamily: "RobotoCondensed-Light",
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                ),
              ),
              ////////////////////////////////////////////////////////////////////////////////////////////////
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: rateStars(wholeItem.ratings),
              ),
              // Center(
              //   child: RatingBar.builder(
              //     itemSize: 25,
              //     initialRating: initialRateVal,
              //     // initialRating: selectedItem.ratings,
              //     minRating: 1,
              //     direction: Axis.horizontal,
              //     allowHalfRating: true,
              //     itemCount: 5,
              //     itemPadding: EdgeInsets.symmetric(horizontal: 6.0),
              //     itemBuilder: (context, _) => Icon(
              //       Icons.star,
              //       color: Colors.amber,
              //     ),
              //     onRatingUpdate: (rating) {
              //       ratingValues.add(rating);
              //       // print(ratingValues);
              //       // print(rating);
              //       callOnRating(rating, wholeItem);
              //     },
              //   ),
              // ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 3, bottom: 15),
                  child: Text(
                    roundDouble(wholeItem.ratings, 1).toString() +
                        " (" +
                        wholeItem.ratedCount.toString() +
                        ")",
                    style: TextStyle(
                        fontFamily: "RobotoCondensed-Light",
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        !isUserAuth
                            ? Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return SignButtonScreen();
                                  },
                                ),
                              )
                            : Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) {
                                  return CommentScreen(widget.id,
                                      widget.imageUrl, wholeItem, token);
                                }),
                              );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              !isUserAuth
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return SignButtonScreen();
                                        },
                                      ),
                                    )
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return CommentScreen(
                                              widget.id,
                                              widget.imageUrl,
                                              wholeItem,
                                              token);
                                        },
                                      ),
                                    );
                            },
                            icon: Icon(
                              Icons.add_comment_rounded,
                              color: Colors.grey,
                            ),
                          ),
                          Text("Review"),
                        ],
                      ),
                    ),
                    authData.userType != "ROLE_ADMIN" ? Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            isUserAuth
                                ? showAlertDialogBox(context, initialRateVal)
                                : Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return SignButtonScreen();
                                      },
                                    ),
                                  );
                          },
                          icon: Icon(
                            Icons.star_rounded,
                            size: 32,
                            color: Colors.grey,
                          ),
                        ),
                        Text("Rate  "),
                      ],
                    ) : SizedBox.shrink(),
                    isUserAuth &&  authData.userType != "ROLE_ADMIN" ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !isLoading
                            ? IconButton(
                                onPressed: () async {
                                  setState(() {
                                    isFavourite = !isFavourite;
                                  });
                                  final favList =
                                      await addItemToFavourites(token, context);
                                  setState(() {
                                    if (favList != null && favList.isNotEmpty) {
                                      favList.forEach((item) {
                                        if (wholeItem.id.toString() ==
                                            item.id.toString()) {
                                          isFavourite = true;
                                        } else {
                                          isFavourite = false;
                                        }
                                      });
                                    }
                                  });
                                },
                                icon: isFavourite
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.favorite,
                                        color: Colors.grey,
                                      ),
                              )
                            : SizedBox.shrink(),
                        Text("Favourite"),
                      ],
                    ) : SizedBox(),
                  ],
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
                padding: const EdgeInsets.only(
                    top: 10, bottom: 20, left: 25, right: 25),
                child: Text(
                  wholeItem.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "RobotoCondensed-Light",
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.grey[700]),
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

              ///Don't Delete this ////

              // Padding(
              //   padding: EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
              //   child: YoutubePlayer(
              //     controller: _controller,
              //     showVideoProgressIndicator: true,
              //   ),
              // ),

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
                height: 170,
                width: 400,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedCast.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 40,
                            child: Text(
                              selectedCast[index]["name"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(selectedCast[index]["imageUrl"]),
                              maxRadius: 40,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            child: Text(
                              selectedCast[index]["roleName"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    }),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "Roles",
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
                height: 200,
                width: 400,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedRoles.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 40,
                            child: Text(
                              selectedRoles[index]["name"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  selectedRoles[index]["imageUrl"]),
                              maxRadius: 40,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            child: Text(
                              selectedRoles[index]["roleName"]
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    }),
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
