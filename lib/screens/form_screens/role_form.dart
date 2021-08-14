import 'package:drama_app/models/cast.dart';
import 'package:drama_app/providers/cast_provider.dart';
import 'package:drama_app/widgets/alert_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleFormScreen extends StatefulWidget {
  @override
  _RoleFormScreenState createState() => _RoleFormScreenState();
}

class _RoleFormScreenState extends State<RoleFormScreen> {
  List<TextEditingController> controllers = [TextEditingController()];

  final _form = GlobalKey<FormState>();

  var _editedRole = Cast(
    id: "",
    name: "",
    description: "",
    imageUrls: [],
  );

  void dispose() {
    controllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  late int _imageCount;

  var _isLoading = false;

  void initState() {
    super.initState();
    _imageCount = 1;
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    var isthrowError = false;

    Provider.of<Casts>(context, listen: false).addRole(_editedRole).catchError((error) {
      isthrowError = true;

      return showDialog<Null>(
        context: context, builder: (ctx) => AlertBox("Error! Role Not Added!", "Error Occurred", ctx),
        // AlertDialog(
        //   title: Text("Error Occurred"),
        //   content: Text("Something went Wrong. Role Not Added!"),
        //   actions: <Widget>[
        //     TextButton(
        //       child: Text("Okay"),
        //       onPressed: () {
        //         Navigator.of(ctx).pop();
        //       },
        //     )
        //   ],
        // ),
      );
    }).then((_) {
      setState(() {
        _isLoading = false;
      });

      if (!isthrowError) {
        showDialog<Null>(
          context: context, builder: (ctx) => AlertBox("Item Added Succesfully", "Sucsessfull", ctx),
          // AlertDialog(
          //   title: Text("Sucsessfull"),
          //   content: Text("Item Added Succesfully"),
          //   actions: <Widget>[
          //     TextButton(
          //       child: Text("Awesome"),
          //       onPressed: () {
          //         Navigator.of(ctx).pop();
          //       },
          //     )
          //   ],
          // ),
        ).then((value) {
          Navigator.of(context).pop();
        });
      }

      if (isthrowError) {
        Navigator.of(context).pop();
      }

      // Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: _isLoading
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
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
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
                        ),
                        Center(
                          child: Text(
                            "Role Form",
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
                                    decoration: InputDecoration(labelText: 'Name'),
                                    textInputAction: TextInputAction.next,
                                    onSaved: (value) {
                                      _editedRole = Cast(
                                        id: _editedRole.id,
                                        name: value.toString(),
                                        description: _editedRole.description,
                                        imageUrls: _editedRole.imageUrls,
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
                                    decoration: InputDecoration(labelText: 'About'),
                                    maxLines: 3,
                                    // textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.multiline,
                                    onSaved: (value) {
                                      _editedRole = Cast(
                                        id: _editedRole.id,
                                        name: _editedRole.name,
                                        description: value.toString(),
                                        imageUrls: _editedRole.imageUrls,
                                      );
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter a Description";
                                      }
                                      if (value.length < 10) {
                                        return "Should at least 10 Characters";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 8,
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
                                                        controller: controllers[index],
                                                        textInputAction: TextInputAction.next,
                                                        onSaved: (value) {
                                                          _editedRole = Cast(
                                                            id: _editedRole.id,
                                                            name: _editedRole.name,
                                                            description: _editedRole.description,
                                                            // imageUrls: [value.toString()],
                                                            imageUrls: [..._editedRole.imageUrls, value.toString()],
                                                          );
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Enter a image URL";
                                                          }
                                                          if (!value.startsWith("http") || !value.startsWith("https")) {
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
                                                        border: Border.all(width: 1, color: Colors.black),
                                                      ),
                                                      child: FittedBox(
                                                        child: (controllers[index].text.isEmpty || (!controllers[index].text.startsWith("http") || !controllers[index].text.startsWith("https")))
                                                            ? Padding(
                                                                padding: EdgeInsets.all(10),
                                                                child: Text(
                                                                  "Add Image Url",
                                                                  style: TextStyle(fontSize: 5),
                                                                ),
                                                              )
                                                            : Image.network(controllers[index].text),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: screenWidth * 0.05,
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.add,
                                                          color: Theme.of(context).primaryColor,
                                                        ),
                                                        onPressed: () async {
                                                          setState(() {
                                                            controllers.add(TextEditingController());
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
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: ElevatedButton(
                                      style: ButtonStyle(),
                                      onPressed: _saveForm,
                                      // () {
                                      //   setState(() {
                                      //     _imageCount = 1;
                                      //   });
                                      // },
                                      child: const Text('Submit'),
                                    ),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
