import 'package:flutter/material.dart';

class RoleFormScreen extends StatefulWidget {
  @override
  _RoleFormScreenState createState() => _RoleFormScreenState();
}

class _RoleFormScreenState extends State<RoleFormScreen> {
  List<TextEditingController> controllers = [
    TextEditingController()
  ];
  //final _imageEditingCOntroler = TextEditingController();

  void dispose() {
    controllers.forEach((element) {
      element.dispose();
    });
    //_imageEditingCOntroler.dispose();
    super.dispose();
  }

  late int _imageCount;

  void initState() {
    super.initState();
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
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
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
                "Role Form",
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
                    decoration: InputDecoration(labelText: 'Name'),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'About'),
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
                                        controller: controllers[index], // TODO controller issue
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
                                        child: controllers[index].text.isEmpty
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
                                        icon: Icon(Icons.add, color: Theme.of(context).primaryColor,),
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
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        setState(() {
                          _imageCount = 1;
                        });
                      },
                      child: const Text('Submit'),
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    ));
  }
}
