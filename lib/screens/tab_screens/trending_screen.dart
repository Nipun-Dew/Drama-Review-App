import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/auth_screen.dart';
import '../../providers/auth_provider.dart';
import '../../screens/sign_btn_screen.dart';

class TrendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget loadingPage = Center(
        child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
            child: CircularProgressIndicator()));

    return Provider.of<Auth>(context).isAuth
        ? SizedBox()
        : FutureBuilder(
            future: Provider.of<Auth>(context, listen: true).autoLogin(),
            builder: (ctx, authResult) =>
                authResult.connectionState == ConnectionState.waiting
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
