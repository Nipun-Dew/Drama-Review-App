import 'dart:ui';

import 'package:drama_app/models/cast.dart';
import 'package:drama_app/models/item.dart';
import 'package:drama_app/providers/items_provider.dart';
import 'package:drama_app/widgets/alert_box_widget.dart';
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

  var _isLoading = false;

  var _isLoadingRoles = false;

  @override
  void initState() {
    _roleCount = 1;
    _castCount = 1;
    _imageCount = 1;

    setState(() {
      _isLoadingRoles = true;
    });

    Future.delayed(Duration.zero).then((_) {
      Provider.of<Casts>(context, listen: false).getRoles().then((_) {
        setState(() {
          _isLoadingRoles = false;
        });
      });
    });
    super.initState();
  }

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((_) {
  //     Provider.of<Casts>(context, listen: false).getRoles();
  //   });
  //   super.initState();
  // }

  List<String> dropDownValCast = ['Select Name'];

  List<String> dropDownValRole = ['Select Name'];

  String dropDownValType = 'Select Category';

  List<String> dropDownValRoleType = ['Select Role'];

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
    imageUrl: [],
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
    var isValid;

    isValid = _form.currentState!.validate();

    if (_editedItem.genres.length == 0) {
      isValid = false;

      showDialog(
        context: context,
        builder: (ctx) =>
            AlertBox("Please select a genre Type", "No Genre Selected", ctx),
      );
    }

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    var isthrowError = false;

    Provider.of<Items>(context, listen: false)
        .addItem(_editedItem)
        .catchError((error) {
      isthrowError = true;
      print(error);
      return showDialog<Null>(
        context: context,
        builder: (ctx) =>
            AlertBox("Error! Item not Added!", "Error Occurred", ctx),
      );
    }).then((_) {
      setState(() {
        _isLoading = false;
      });

      if (!isthrowError) {
        showDialog<Null>(
          context: context,
          builder: (ctx) =>
              AlertBox("Item Added Succesfully", "Sucsessfull", ctx),
        ).then((value) {
          Navigator.of(context).pop();
        });
      }

      if (isthrowError) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Cast> itemList = Provider.of<Casts>(context).items;

    final dropdownItemList = [
      "Select Name",
      ...itemList.map((cast) => cast.name)
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    final dropdownItemTypeList = [
      'Select Category',
      'TeleDrama',
      'Movie',
      'Short Movie',
      'Web Series',
      'Mini Series'
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    final dropdownRoleList = ['Select Role', 'Director', 'Producer']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: (_isLoading || _isLoadingRoles)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.01),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
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
                                decoration:
                                    InputDecoration(labelText: 'Item name'),
                                textInputAction: TextInputAction.next,
                                onSaved: (value) {
                                  _editedItem = Item(
                                    id: _editedItem.id,
                                    category: _editedItem.category,
                                    title: value.toString(),
                                    imageUrl: _editedItem.imageUrl,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter a Name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Item Description'),
                                maxLines: 3,
                                // textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.multiline,
                                onSaved: (value) {
                                  _editedItem = Item(
                                    id: _editedItem.id,
                                    category: _editedItem.category,
                                    title: _editedItem.title,
                                    imageUrl: _editedItem.imageUrl,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter a Name";
                                  }
                                  if (value.length < 10) {
                                    return ("Should be atleast 10 Characters");
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 5,
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
                                      child: DropdownButtonFormField<String>(
                                        value: dropDownValType,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.pink, fontSize: 12),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            String categoryType = '';

                                            dropDownValType = newValue!;
                                            if (dropDownValType.toString() ==
                                                'TeleDrama') {
                                              categoryType = 'teledrama';
                                            }
                                            if (dropDownValType.toString() ==
                                                'Movie') {
                                              categoryType = 'movie';
                                            }
                                            if (dropDownValType.toString() ==
                                                'Short Movie') {
                                              categoryType = 'short-movie';
                                            }
                                            if (dropDownValType.toString() ==
                                                'Web Series') {
                                              categoryType = 'web-series';
                                            }
                                            if (dropDownValType.toString() ==
                                                'Mini Series') {
                                              categoryType = 'mini-series';
                                            }

                                            _editedItem = Item(
                                              id: _editedItem.id,
                                              category: categoryType.toString(),
                                              title: _editedItem.title,
                                              imageUrl: _editedItem.imageUrl,
                                              description:
                                                  _editedItem.description,
                                              cast: _editedItem.cast,
                                              directors: _editedItem.directors,
                                              producers: _editedItem.producers,
                                              genres: _editedItem.genres,
                                              reviews: _editedItem.reviews,
                                              ratingValues:
                                                  _editedItem.ratingValues,
                                              rateMap: _editedItem.rateMap,
                                              ratings: _editedItem.ratings,
                                              youtubeURL:
                                                  _editedItem.youtubeURL,
                                            );
                                          });
                                        },
                                        validator: (value) {
                                          if (value.toString() ==
                                              "Select Category") {
                                            return "Select a Category";
                                          }
                                          return null;
                                        },
                                        items: dropdownItemTypeList,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Video Url'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.next,
                                onSaved: (value) {
                                  _editedItem = Item(
                                    id: _editedItem.id,
                                    category: _editedItem.category,
                                    title: _editedItem.title,
                                    imageUrl: _editedItem.imageUrl,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter a Video URL";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width: screenWidth * 0.4,
                                                  height: 150,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        labelText: 'Image Url'),
                                                    keyboardType:
                                                        TextInputType.url,
                                                    controller:
                                                        imageControllers[index],
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _editedItem = Item(
                                                        id: _editedItem.id,
                                                        category: _editedItem
                                                            .category,
                                                        title:
                                                            _editedItem.title,
                                                        imageUrl: [
                                                          ..._editedItem
                                                              .imageUrl,
                                                          value.toString()
                                                        ],
                                                        description: _editedItem
                                                            .description,
                                                        cast: _editedItem.cast,
                                                        directors: _editedItem
                                                            .directors,
                                                        producers: _editedItem
                                                            .producers,
                                                        genres:
                                                            _editedItem.genres,
                                                        reviews:
                                                            _editedItem.reviews,
                                                        ratingValues:
                                                            _editedItem
                                                                .ratingValues,
                                                        rateMap:
                                                            _editedItem.rateMap,
                                                        ratings:
                                                            _editedItem.ratings,
                                                        youtubeURL: _editedItem
                                                            .youtubeURL,
                                                      );
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter a Image URL";
                                                      }
                                                      if (!value.startsWith(
                                                              "http") ||
                                                          !value.startsWith(
                                                              "https")) {
                                                        return "Enter a Valid URL";
                                                      }
                                                      return null;
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
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black),
                                                  ),
                                                  child: FittedBox(
                                                    child: (imageControllers[
                                                                    index]
                                                                .text
                                                                .isEmpty ||
                                                            (!imageControllers[
                                                                        index]
                                                                    .text
                                                                    .startsWith(
                                                                        "http") ||
                                                                !imageControllers[
                                                                        index]
                                                                    .text
                                                                    .startsWith(
                                                                        "https")))
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(
                                                              "Add Image Url",
                                                              style: TextStyle(
                                                                  fontSize: 5),
                                                            ),
                                                          )
                                                        : Image.network(
                                                            imageControllers[
                                                                    index]
                                                                .text),
                                                  ),
                                                ),
                                                Container(
                                                  width: screenWidth * 0.05,
                                                  child: IconButton(
                                                    icon: Icon(Icons.add),
                                                    onPressed: () async {
                                                      setState(() {
                                                        imageControllers.add(
                                                            TextEditingController());
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
                              SizedBox(
                                height: 8,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: screenWidth * 0.3,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    labelText: 'Cast Name'),
                                                textInputAction:
                                                    TextInputAction.next,
                                                onSaved: (value) {
                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: [
                                                      ..._editedItem.cast,
                                                      {
                                                        "role":
                                                            value.toString(),
                                                        "name": dropDownValCast[
                                                                index]
                                                            .toString(),
                                                      }
                                                    ],
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: _editedItem.genres,
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter a Name";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.05,
                                            ),
                                            Container(
                                              width: screenWidth * 0.5,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                value: dropDownValCast[index],
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.pink,
                                                    fontSize: 12),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropDownValCast[index] =
                                                        newValue!;
                                                  });
                                                },
                                                items: dropdownItemList,
                                                validator: (value) {
                                                  if (value.toString() ==
                                                      "Select Name") {
                                                    return "Select a Name";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: screenWidth * 0.05,
                                              child: IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () async {
                                                  setState(() {
                                                    dropDownValCast
                                                        .add('Select Name');
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
                              SizedBox(
                                height: 8,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            // Container(
                                            //   width: screenWidth * 0.4,
                                            //   child: TextFormField(
                                            //     decoration: InputDecoration(labelText: 'Role'),
                                            //     textInputAction: TextInputAction.next,
                                            //   ),
                                            // ),
                                            Container(
                                              width: screenWidth * 0.3,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                value:
                                                    dropDownValRoleType[index],
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.pink,
                                                    fontSize: 12),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropDownValRoleType[index] =
                                                        newValue!;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value.toString() ==
                                                      "Select Role") {
                                                    return "Select a Role";
                                                  }
                                                  if (_editedItem
                                                          .producers.length ==
                                                      0) {
                                                    return "Add a Producer";
                                                  }
                                                  if (_editedItem
                                                          .directors.length ==
                                                      0) {
                                                    return "Add a Director";
                                                  }
                                                  return null;
                                                },
                                                items: dropdownRoleList,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.05,
                                            ),
                                            Container(
                                              width: screenWidth * 0.5,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                value: dropDownValRole[index],
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.pink,
                                                    fontSize: 12),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropDownValRole[index] =
                                                        newValue!;

                                                    if (dropDownValRoleType[
                                                                index]
                                                            .toString() ==
                                                        'Director') {
                                                      // selectedDirectors.add({
                                                      //   "role": dropDownValRoleType[index],
                                                      //   "starID": dropDownValRole[index],
                                                      // });
                                                      _editedItem = Item(
                                                        id: _editedItem.id,
                                                        category: _editedItem
                                                            .category,
                                                        title:
                                                            _editedItem.title,
                                                        imageUrl: _editedItem
                                                            .imageUrl,
                                                        description: _editedItem
                                                            .description,
                                                        cast: _editedItem.cast,
                                                        directors: [
                                                          ..._editedItem
                                                              .directors,
                                                          {
                                                            "role":
                                                                dropDownValRoleType[
                                                                    index],
                                                            "starID":
                                                                dropDownValRole[
                                                                    index],
                                                          }
                                                        ],
                                                        producers: _editedItem
                                                            .producers,
                                                        genres:
                                                            _editedItem.genres,
                                                        reviews:
                                                            _editedItem.reviews,
                                                        ratingValues:
                                                            _editedItem
                                                                .ratingValues,
                                                        rateMap:
                                                            _editedItem.rateMap,
                                                        ratings:
                                                            _editedItem.ratings,
                                                        youtubeURL: _editedItem
                                                            .youtubeURL,
                                                      );
                                                    }
                                                    if (dropDownValRoleType[
                                                                index]
                                                            .toString() ==
                                                        'Producer') {
                                                      // selectedProducers.add({
                                                      //   "role": dropDownValRoleType[index],
                                                      //   "starID": dropDownValRole[index],
                                                      // });
                                                      _editedItem = Item(
                                                        id: _editedItem.id,
                                                        category: _editedItem
                                                            .category,
                                                        title:
                                                            _editedItem.title,
                                                        imageUrl: _editedItem
                                                            .imageUrl,
                                                        description: _editedItem
                                                            .description,
                                                        cast: _editedItem.cast,
                                                        directors: _editedItem
                                                            .directors,
                                                        producers: [
                                                          ..._editedItem
                                                              .producers,
                                                          {
                                                            "role":
                                                                dropDownValRoleType[
                                                                    index],
                                                            "starID":
                                                                dropDownValRole[
                                                                    index],
                                                          }
                                                        ],
                                                        genres:
                                                            _editedItem.genres,
                                                        reviews:
                                                            _editedItem.reviews,
                                                        ratingValues:
                                                            _editedItem
                                                                .ratingValues,
                                                        rateMap:
                                                            _editedItem.rateMap,
                                                        ratings:
                                                            _editedItem.ratings,
                                                        youtubeURL: _editedItem
                                                            .youtubeURL,
                                                      );
                                                    }
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value.toString() ==
                                                      "Select Name") {
                                                    return "Select a Name";
                                                  }
                                                  return null;
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
                                                    dropDownValRole
                                                        .add('Select Name');
                                                    dropDownValRoleType
                                                        .add('Select Role');
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
                              SizedBox(
                                height: 8,
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
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text('Action'),
                                            value: _checkboxAction,
                                            activeColor: Colors.pink,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkboxAction =
                                                    !_checkboxAction;
                                                if (_checkboxAction) {
                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: [
                                                      ..._editedItem.genres,
                                                      "Action"
                                                    ],
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                } else {
                                                  _editedItem.genres
                                                      .removeWhere((element) =>
                                                          element.toString() ==
                                                          "Action");

                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: _editedItem.genres,
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text('Romance'),
                                            value: _checkboxRomance,
                                            activeColor: Colors.pink,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkboxRomance =
                                                    !_checkboxRomance;
                                                if (_checkboxRomance) {
                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: [
                                                      ..._editedItem.genres,
                                                      "Romance"
                                                    ],
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                } else {
                                                  _editedItem.genres
                                                      .removeWhere((element) =>
                                                          element.toString() ==
                                                          "Romance");

                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: _editedItem.genres,
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
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
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text('Horror'),
                                            value: _checkboxHorror,
                                            activeColor: Colors.pink,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkboxHorror =
                                                    !_checkboxHorror;
                                                if (_checkboxHorror) {
                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: [
                                                      ..._editedItem.genres,
                                                      "Horror"
                                                    ],
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                } else {
                                                  _editedItem.genres
                                                      .removeWhere((element) =>
                                                          element.toString() ==
                                                          "Horror");

                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: _editedItem.genres,
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text('Thriller'),
                                            value: _checkboxThriller,
                                            activeColor: Colors.pink,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkboxThriller =
                                                    !_checkboxThriller;
                                                if (_checkboxThriller) {
                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: [
                                                      ..._editedItem.genres,
                                                      "Thriller"
                                                    ],
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                } else {
                                                  _editedItem.genres
                                                      .removeWhere((element) =>
                                                          element.toString() ==
                                                          "Thriller");

                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: _editedItem.genres,
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
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
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text('Biography'),
                                            value: _checkboxBiography,
                                            activeColor: Colors.pink,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkboxBiography =
                                                    !_checkboxBiography;
                                                if (_checkboxBiography) {
                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: [
                                                      ..._editedItem.genres,
                                                      "Biography"
                                                    ],
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                } else {
                                                  _editedItem.genres
                                                      .removeWhere((element) =>
                                                          element.toString() ==
                                                          "Biography");

                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: _editedItem.genres,
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text('Drama'),
                                            value: _checkboxDrama,
                                            activeColor: Colors.pink,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkboxDrama =
                                                    !_checkboxDrama;
                                                if (_checkboxDrama) {
                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: [
                                                      ..._editedItem.genres,
                                                      "Drama"
                                                    ],
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                } else {
                                                  _editedItem.genres
                                                      .removeWhere((element) =>
                                                          element.toString() ==
                                                          "Drama");

                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: _editedItem.genres,
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
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
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text('Comedy'),
                                            value: _checkboxComody,
                                            activeColor: Colors.pink,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkboxComody =
                                                    !_checkboxComody;
                                                if (_checkboxComody) {
                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: [
                                                      ..._editedItem.genres,
                                                      "Comedy"
                                                    ],
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                } else {
                                                  _editedItem.genres
                                                      .removeWhere((element) =>
                                                          element.toString() ==
                                                          "Comedy");

                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: _editedItem.genres,
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text('Fiction'),
                                            value: _checkboxFiction,
                                            activeColor: Colors.pink,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkboxFiction =
                                                    !_checkboxFiction;
                                                if (_checkboxFiction) {
                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: [
                                                      ..._editedItem.genres,
                                                      "Fiction"
                                                    ],
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
                                                  );
                                                } else {
                                                  _editedItem.genres
                                                      .removeWhere((element) =>
                                                          element.toString() ==
                                                          "Fiction");

                                                  _editedItem = Item(
                                                    id: _editedItem.id,
                                                    category:
                                                        _editedItem.category,
                                                    title: _editedItem.title,
                                                    imageUrl:
                                                        _editedItem.imageUrl,
                                                    description:
                                                        _editedItem.description,
                                                    cast: _editedItem.cast,
                                                    directors:
                                                        _editedItem.directors,
                                                    producers:
                                                        _editedItem.producers,
                                                    genres: _editedItem.genres,
                                                    reviews:
                                                        _editedItem.reviews,
                                                    ratingValues: _editedItem
                                                        .ratingValues,
                                                    rateMap:
                                                        _editedItem.rateMap,
                                                    ratings:
                                                        _editedItem.ratings,
                                                    youtubeURL:
                                                        _editedItem.youtubeURL,
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
