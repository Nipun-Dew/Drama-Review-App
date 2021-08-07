import 'dart:ui';

import 'package:drama_app/models/cast.dart';
import 'package:drama_app/models/item.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cast_provider.dart';

class ItemFormScreen extends StatefulWidget {
  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  List<TextEditingController> imageControllers = [TextEditingController()];

  void dispose() {
    imageControllers.forEach((element) => element.dispose());
    super.dispose();
  }

  // late int _genreCount;
  late int _roleCount;
  late int _castCount;
  late int _imageCount;

  void initState() {
    super.initState();
    // _genreCount = 1;
    _roleCount = 1;
    _castCount = 1;
    _imageCount = 1;
  }

  List<String> dropDownValCast = ['Sajitha Anthoney'];

  List<String> dropDownValRole = ['Sajitha Anthoney'];

  String dropDownValType = 'TeleDrama';

  List<String> dropDownValRoleType = ['Director'];

  bool _checkboxAction = false;
  bool _checkboxRomance = false;
  bool _checkboxHorror = false;
  bool _checkboxThriller = false;
  bool _checkboxBiography = false;
  bool _checkboxDrama = false;
  bool _checkboxComody = false;
  bool _checkboxFiction = false;

  final _form = GlobalKey<FormState>();

  List<String> selectedGenere = [];

  var _editedItem = Item(
    id: "",
    category: "",
    title: "",
    imageUrls: [],
    description: "",
    cast: [],
    directors: [],
    producers: [],
    genres: [],
    reviews: {},
    ratingValues: [],
    rateMap: {},
    ratings: 0,
    youtubeURL: "",
  );

  void _saveForm() {
    _form.currentState!.save();
    Provider.of<Items>(context, listen: false).addItem(_editedItem);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<Cast> itemList = Provider.of<Casts>(context).items;

    final dropdownItemList = [...itemList.map((cast) => cast.name)].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    final dropdownItemTypeList = ['TeleDrama', 'Movie', 'Short Movie', 'Web Series', 'Mini Series'].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    final dropdownRoleList = ['Director', 'Producer'].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  child: InkWell(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Center(
                  child: Text(
                    "Item Form",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  width: screenWidth,
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Item name'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedItem = Item(
                              id: _editedItem.id,
                              category: _editedItem.category,
                              title: value.toString(),
                              imageUrls: _editedItem.imageUrls,
                              description: _editedItem.description,
                              cast: _editedItem.cast,
                              directors: _editedItem.directors,
                              producers: _editedItem.producers,
                              genres: _editedItem.genres,
                              reviews: _editedItem.reviews,
                              ratingValues: _editedItem.ratingValues,
                              rateMap: _editedItem.rateMap,
                              ratings: _editedItem.ratings,
                              youtubeURL: _editedItem.youtubeURL,
                            );
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Item Description'),
                          maxLines: 3,
                          // textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          onSaved: (value) {
                            _editedItem = Item(
                              id: _editedItem.id,
                              category: _editedItem.category,
                              title: _editedItem.title,
                              imageUrls: _editedItem.imageUrls,
                              description: value.toString(),
                              cast: _editedItem.cast,
                              directors: _editedItem.directors,
                              producers: _editedItem.producers,
                              genres: _editedItem.genres,
                              reviews: _editedItem.reviews,
                              ratingValues: _editedItem.ratingValues,
                              rateMap: _editedItem.rateMap,
                              ratings: _editedItem.ratings,
                              youtubeURL: _editedItem.youtubeURL,
                            );
                          },
                        ),

                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: screenWidth * 0.4,
                                child: Text("Item Type"),
                                padding: EdgeInsets.only(top: 15),
                              ),
                              Container(
                                width: screenWidth * 0.4,
                                child: DropdownButton<String>(
                                  value: dropDownValType,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.pink, fontSize: 12),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      String categoryType = '';

                                      dropDownValType = newValue!;
                                      if (dropDownValType.toString() == 'TeleDrama') {
                                        categoryType = 'teledrama';
                                      }
                                      if (dropDownValType.toString() == 'Movie') {
                                        categoryType = 'movie';
                                      }
                                      if (dropDownValType.toString() == 'Short Movie') {
                                        categoryType = 'short-movie';
                                      }
                                      if (dropDownValType.toString() == 'Web Series') {
                                        categoryType = 'web-series';
                                      }
                                      if (dropDownValType.toString() == 'Mini Series') {
                                        categoryType = 'mini-series';
                                      }

                                      _editedItem = Item(
                                        id: _editedItem.id,
                                        category: categoryType.toString(),
                                        title: _editedItem.title,
                                        imageUrls: _editedItem.imageUrls,
                                        description: _editedItem.description,
                                        cast: _editedItem.cast,
                                        directors: _editedItem.directors,
                                        producers: _editedItem.producers,
                                        genres: _editedItem.genres,
                                        reviews: _editedItem.reviews,
                                        ratingValues: _editedItem.ratingValues,
                                        rateMap: _editedItem.rateMap,
                                        ratings: _editedItem.ratings,
                                        youtubeURL: _editedItem.youtubeURL,
                                      );
                                    });
                                  },
                                  items: dropdownItemTypeList,
                                ),
                              ),
                            ],
                          ),
                        ),

                        TextFormField(
                          decoration: InputDecoration(labelText: 'Video Url'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedItem = Item(
                              id: _editedItem.id,
                              category: _editedItem.category,
                              title: _editedItem.title,
                              imageUrls: _editedItem.imageUrls,
                              description: _editedItem.description,
                              cast: _editedItem.cast,
                              directors: _editedItem.directors,
                              producers: _editedItem.producers,
                              genres: _editedItem.genres,
                              reviews: _editedItem.reviews,
                              ratingValues: _editedItem.ratingValues,
                              rateMap: _editedItem.rateMap,
                              ratings: _editedItem.ratings,
                              youtubeURL: value.toString(),
                            );
                          },
                        ),
                        Container(
                          width: screenWidth,
                          child: Column(
                            children: <Widget>[
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _imageCount,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 150,
                                      width: screenWidth * 0.4,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: screenWidth * 0.4,
                                            height: 150,
                                            child: TextFormField(
                                              decoration: InputDecoration(labelText: 'Image Url'),
                                              keyboardType: TextInputType.url,
                                              controller: imageControllers[index],
                                              textInputAction: TextInputAction.next,
                                              onSaved: (value) {
                                                _editedItem = Item(
                                                  id: _editedItem.id,
                                                  category: _editedItem.category,
                                                  title: _editedItem.title,
                                                  imageUrls: [..._editedItem.imageUrls, value.toString()],
                                                  description: _editedItem.description,
                                                  cast: _editedItem.cast,
                                                  directors: _editedItem.directors,
                                                  producers: _editedItem.producers,
                                                  genres: _editedItem.genres,
                                                  reviews: _editedItem.reviews,
                                                  ratingValues: _editedItem.ratingValues,
                                                  rateMap: _editedItem.rateMap,
                                                  ratings: _editedItem.ratings,
                                                  youtubeURL: _editedItem.youtubeURL,
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.05,
                                          ),
                                          Container(
                                            width: screenWidth * 0.4,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1, color: Colors.black),
                                            ),
                                            child: FittedBox(
                                              child: imageControllers[index].text.isEmpty
                                                  ? Padding(
                                                      padding: EdgeInsets.all(10),
                                                      child: Text(
                                                        "Add Image Url",
                                                        style: TextStyle(fontSize: 5),
                                                      ),
                                                    )
                                                  : Image.network(imageControllers[index].text),
                                            ),
                                          ),
                                          Container(
                                            width: screenWidth * 0.05,
                                            child: IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () async {
                                                setState(() {
                                                  imageControllers.add(TextEditingController());
                                                  _imageCount++;
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          // swidth: 250,
                          child: Column(
                            children: <Widget>[
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _castCount,
                                itemBuilder: (context, index) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: screenWidth * 0.4,
                                        child: TextFormField(
                                          decoration: InputDecoration(labelText: 'Cast Name'),
                                          textInputAction: TextInputAction.next,
                                          onSaved: (value) {
                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: [
                                                ..._editedItem.cast,
                                                {
                                                  "role": value.toString(),
                                                  "name": dropDownValCast[index].toString(),
                                                }
                                              ],
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.05,
                                      ),
                                      Container(
                                        width: screenWidth * 0.4,
                                        child: DropdownButton<String>(
                                          value: dropDownValCast[index],
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.pink, fontSize: 12),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropDownValCast[index] = newValue!;
                                            });
                                          },
                                          items: dropdownItemList,
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth * 0.05,
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () async {
                                            setState(() {
                                              dropDownValCast.add('Sajitha Anthoney');
                                              _castCount++;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          // swidth: 250,
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: <Widget>[
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _roleCount,
                                itemBuilder: (context, index) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      // Container(
                                      //   width: screenWidth * 0.4,
                                      //   child: TextFormField(
                                      //     decoration: InputDecoration(labelText: 'Role'),
                                      //     textInputAction: TextInputAction.next,
                                      //   ),
                                      // ),
                                      Container(
                                        width: screenWidth * 0.4,
                                        child: DropdownButton<String>(
                                          value: dropDownValRoleType[index],
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.pink, fontSize: 12),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropDownValRoleType[index] = newValue!;
                                            });
                                          },
                                          items: dropdownRoleList,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.05,
                                      ),
                                      Container(
                                        width: screenWidth * 0.4,
                                        child: DropdownButton<String>(
                                          value: dropDownValRole[index],
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.pink, fontSize: 12),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropDownValRole[index] = newValue!;

                                              if (dropDownValRoleType[index].toString() == 'Director') {
                                                // selectedDirectors.add({
                                                //   "role": dropDownValRoleType[index],
                                                //   "starID": dropDownValRole[index],
                                                // });
                                                _editedItem = Item(
                                                  id: _editedItem.id,
                                                  category: _editedItem.category,
                                                  title: _editedItem.title,
                                                  imageUrls: _editedItem.imageUrls,
                                                  description: _editedItem.description,
                                                  cast: _editedItem.cast,
                                                  directors: [
                                                    ..._editedItem.directors,
                                                    {
                                                      "role": dropDownValRoleType[index],
                                                      "starID": dropDownValRole[index],
                                                    }
                                                  ],
                                                  producers: _editedItem.producers,
                                                  genres: _editedItem.genres,
                                                  reviews: _editedItem.reviews,
                                                  ratingValues: _editedItem.ratingValues,
                                                  rateMap: _editedItem.rateMap,
                                                  ratings: _editedItem.ratings,
                                                  youtubeURL: _editedItem.youtubeURL,
                                                );
                                              }
                                              if (dropDownValRoleType[index].toString() == 'Producer') {
                                                // selectedProducers.add({
                                                //   "role": dropDownValRoleType[index],
                                                //   "starID": dropDownValRole[index],
                                                // });
                                                _editedItem = Item(
                                                  id: _editedItem.id,
                                                  category: _editedItem.category,
                                                  title: _editedItem.title,
                                                  imageUrls: _editedItem.imageUrls,
                                                  description: _editedItem.description,
                                                  cast: _editedItem.cast,
                                                  directors: _editedItem.directors,
                                                  producers: [
                                                    ..._editedItem.producers,
                                                    {
                                                      "role": dropDownValRoleType[index],
                                                      "starID": dropDownValRole[index],
                                                    }
                                                  ],
                                                  genres: _editedItem.genres,
                                                  reviews: _editedItem.reviews,
                                                  ratingValues: _editedItem.ratingValues,
                                                  rateMap: _editedItem.rateMap,
                                                  ratings: _editedItem.ratings,
                                                  youtubeURL: _editedItem.youtubeURL,
                                                );
                                              }
                                            });
                                          },
                                          items: dropdownItemList,
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth * 0.05,
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () async {
                                            setState(() {
                                              dropDownValRole.add('Sajitha Anthoney');
                                              dropDownValRoleType.add('Director');
                                              _roleCount++;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Text("Genre Types"),
                          padding: EdgeInsets.only(top: 15),
                        ),
                        // Container(
                        //   // swidth: 250,
                        //   child: Column(
                        //     children: <Widget>[
                        //       ListView.builder(
                        //         physics: NeverScrollableScrollPhysics(),
                        //         shrinkWrap: true,
                        //         itemCount: _genreCount,
                        //         itemBuilder: (context, index) {
                        //           return Row(children: <Widget>[
                        //             Container(
                        //               width: screenWidth * 0.85,
                        //               child: TextFormField(
                        //                 decoration: InputDecoration(labelText: 'Genre Type'),
                        //                 textInputAction: TextInputAction.next,
                        //               ),
                        //             ),
                        //             Container(
                        //               width: screenWidth * 0.05,
                        //               child: IconButton(
                        //                 icon: Icon(Icons.plus_one),
                        //                 onPressed: () async {
                        //                   setState(() {
                        //                     _genreCount++;
                        //                   });
                        //                 },
                        //               ),
                        //             )
                        //           ]);
                        //         },
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Container(
                          width: screenWidth,
                          // height: 300,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Action'),
                                      value: _checkboxAction,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxAction = !_checkboxAction;
                                          if (_checkboxAction) {
                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: [..._editedItem.genres, "Action"],
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          } else {
                                            _editedItem.genres.removeWhere((element) => element.toString() == "Action");

                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Romance'),
                                      value: _checkboxRomance,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxRomance = !_checkboxRomance;
                                          if (_checkboxRomance) {
                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: [..._editedItem.genres, "Romance"],
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          } else {
                                            _editedItem.genres.removeWhere((element) => element.toString() == "Romance");

                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Horror'),
                                      value: _checkboxHorror,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxHorror = !_checkboxHorror;
                                          if (_checkboxHorror) {
                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: [..._editedItem.genres, "Horror"],
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          } else {
                                            _editedItem.genres.removeWhere((element) => element.toString() == "Horror");

                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Thriller'),
                                      value: _checkboxThriller,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxThriller = !_checkboxThriller;
                                          if (_checkboxThriller) {
                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: [..._editedItem.genres, "Thriller"],
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          } else {
                                            _editedItem.genres.removeWhere((element) => element.toString() == "Thriller");

                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Biography'),
                                      value: _checkboxBiography,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxBiography = !_checkboxBiography;
                                          if (_checkboxBiography) {
                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: [..._editedItem.genres, "Biography"],
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          } else {
                                            _editedItem.genres.removeWhere((element) => element.toString() == "Biography");

                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Drama'),
                                      value: _checkboxDrama,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxDrama = !_checkboxDrama;
                                          if (_checkboxDrama) {
                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: [..._editedItem.genres, "Drama"],
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          } else {
                                            _editedItem.genres.removeWhere((element) => element.toString() == "Drama");

                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Comedy'),
                                      value: _checkboxComody,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxComody = !_checkboxComody;
                                          if (_checkboxComody) {
                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: [..._editedItem.genres, "Comedy"],
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          } else {
                                            _editedItem.genres.removeWhere((element) => element.toString() == "Comedy");

                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Fiction'),
                                      value: _checkboxFiction,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxFiction = !_checkboxFiction;
                                          if (_checkboxFiction) {
                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: [..._editedItem.genres, "Fiction"],
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          } else {
                                            _editedItem.genres.removeWhere((element) => element.toString() == "Fiction");

                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: _editedItem.category,
                                              title: _editedItem.title,
                                              imageUrls: _editedItem.imageUrls,
                                              description: _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues: _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL: _editedItem.youtubeURL,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(),
                            onPressed: _saveForm,
                            // () {
                            //   /// Check This
                            //   setState(() {
                            //     // _genreCount = 1;
                            //     _castCount = 1;
                            //     _roleCount = 1;
                            //     _imageCount = 1;
                            //   });
                            //   _saveForm();
                            // },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
