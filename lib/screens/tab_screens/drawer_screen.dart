import 'package:drama_app/screens/form_screens/item_form.dart';
import 'package:drama_app/screens/form_screens/role_form.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return ItemFormScreen();
              }));
            },
            child: const Text('Add Items'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RoleFormScreen();
              }));
            },
            child: const Text('Add roles'),
          ),
        ],
      ),
    );
  }
}
