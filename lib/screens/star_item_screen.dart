import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/cast.dart';

class StarItemScreen extends StatelessWidget {
  final Cast castItem;

  StarItemScreen(this.castItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Stack(children: [
              CarouselSlider(
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
                  ...castItem.imageUrls,
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
                  castItem.name,
                  style: TextStyle(fontFamily: "RobotoCondensed-Light", fontWeight: FontWeight.w500, fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20, left: 25, right: 25),
              child: Text(
                castItem.description,
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: "RobotoCondensed-Light", fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
