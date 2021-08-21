import 'package:drama_app/screens/form_screens/item_form.dart';
import 'package:drama_app/screens/form_screens/role_form.dart';
import 'package:drama_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../screens/sign_btn_screen.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context, listen: true);

    Widget loadingPage = Center(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5), child: CircularProgressIndicator()));

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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            content: Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                child: Center(
                                    child: Text(
                                  "Do you want to logout?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.grey[700],
                                  ),
                                ))),
                            actions: [
                              Center(
                                child: Divider(
                                  thickness: 0.3,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                          Provider.of<Auth>(context, listen: false).logout();
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                                            return TabScreen();
                                          }));
                                        },
                                        child: Text(
                                          "yes",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text(
                                          "no",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        ))
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
        : FutureBuilder(
            future: Provider.of<Auth>(context, listen: true).autoLogin(),
            builder: (ctx, authResult) => authResult.connectionState == ConnectionState.waiting
                ? loadingPage
                : Center(
                    child: ElevatedButton(
                      child: Text("Login"),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return SignButtonScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ));
  }
}
