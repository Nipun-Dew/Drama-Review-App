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

  String dropdownValue = 'Sajitha Anthoney';

  final dropdownItemList = <String>[
    'Sajitha Anthoney',
    'Meena Kumari',
    'Thumidu Dodanthenna',
    'Giriraj Kushalya',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  bool _checkboxAction = false;
  bool _checkboxRomance = false;
  bool _checkboxHorror = false;
  bool _checkboxThriller = false;
  bool _checkboxBiography = false;
  bool _checkboxDrama = false;
  bool _checkboxComody = false;
  bool _checkboxFiction = false;

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
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Video Url'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.next,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        elevation: 16,
                                        style: const TextStyle(color: Colors.deepPurple, fontSize: 12),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: dropdownItemList,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth * 0.4,
                                      child: TextFormField(
                                        decoration: InputDecoration(labelText: 'Role'),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    Container(
                                      width: screenWidth * 0.4,
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        elevation: 16,
                                        style: const TextStyle(color: Colors.deepPurple, fontSize: 12),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: dropdownItemList,
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
                          onPressed: () {
                            setState(() {
                              // _genreCount = 1;
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
