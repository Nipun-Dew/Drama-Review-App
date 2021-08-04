import 'dart:ui';

import 'package:flutter/material.dart';

class ItemFormScreen extends StatefulWidget {
  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _imageEditingCOntroler = TextEditingController();

  void dispose() {
    _imageEditingCOntroler.dispose();
    super.dispose();
  }

  late int _genreCount;
  late int _roleCount;
  late int _castCount;
  late int _imageCount;

  void initState() {
    super.initState();
    _genreCount = 1;
    _roleCount = 1;
    _castCount = 1;
    _imageCount = 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                child: InkWell(
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
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
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Item name'),
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Item Description'),
                        maxLines: 3,
                        // textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
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
                                            controller: _imageEditingCOntroler,
                                            textInputAction: TextInputAction.next,
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
                                            child: _imageEditingCOntroler.text.isEmpty
                                                ? Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                      "Add Image Url",
                                                      style: TextStyle(fontSize: 5),
                                                    ),
                                                  )
                                                : Image.network(_imageEditingCOntroler.text),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.05,
                                          child: IconButton(
                                            icon: Icon(Icons.plus_one),
                                            onPressed: () async {
                                              setState(() {
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth * 0.4,
                                      child: TextFormField(
                                        decoration: InputDecoration(labelText: 'Cast Name'),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    Container(
                                      width: screenWidth * 0.4,
                                      child: TextFormField(
                                        decoration: InputDecoration(labelText: 'Actor name'),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.05,
                                      child: IconButton(
                                        icon: Icon(Icons.plus_one),
                                        onPressed: () async {
                                          setState(() {
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
                        child: Column(
                          children: <Widget>[
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _roleCount,
                              itemBuilder: (context, index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth * 0.4,
                                      child: TextFormField(
                                        decoration: InputDecoration(labelText: 'Name'),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    Container(
                                      width: screenWidth * 0.4,
                                      child: TextFormField(
                                        decoration: InputDecoration(labelText: 'Role'),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.05,
                                      child: IconButton(
                                        icon: Icon(Icons.plus_one),
                                        onPressed: () async {
                                          setState(() {
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
                        // swidth: 250,
                        child: Column(
                          children: <Widget>[
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _genreCount,
                              itemBuilder: (context, index) {
                                return Row(children: <Widget>[
                                  Container(
                                    width: screenWidth * 0.85,
                                    child: TextFormField(
                                      decoration: InputDecoration(labelText: 'Genre Type'),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.05,
                                    child: IconButton(
                                      icon: Icon(Icons.plus_one),
                                      onPressed: () async {
                                        setState(() {
                                          _genreCount++;
                                        });
                                      },
                                    ),
                                  )
                                ]);
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () {
                            setState(() {
                              _genreCount = 1;
                              _castCount = 1;
                              _roleCount = 1;
                              _imageCount = 1;
                            });
                          },
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
    );
  }
}
