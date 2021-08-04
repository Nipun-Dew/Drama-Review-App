import 'package:flutter/material.dart';

class RoleFormScreen extends StatefulWidget {
  @override
  _RoleFormScreenState createState() => _RoleFormScreenState();
}

class _RoleFormScreenState extends State<RoleFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SingleChildScrollView(
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
                "Role Form",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
