import 'package:drama_app/screens/form_screens/item_form.dart';
import 'package:drama_app/screens/form_screens/role_form.dart';
import 'package:drama_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../screens/auth_screen.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<Auth>(context, listen: true).isAuth
        ? Center(
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
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text("Logout!"),
                            content: Container(height: MediaQuery.of(context).size.height * 0.1, child: Center(child: Text("Do you want to logout?"))),
                            actions: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                          Provider.of<Auth>(context, listen: false).logout();
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                                            return TabScreen();
                                          }));
                                        },
                                        child: Text("yes")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text("no"))
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: const Text('logout'),
                ),
              ],
            ),
          )
        : Center(
            child: ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return AuthScreen();
                    },
                  ),
                );
              },
            ),
          );
  }
}
