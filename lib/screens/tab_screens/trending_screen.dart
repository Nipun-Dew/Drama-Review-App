import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/auth_screen.dart';
import '../../providers/auth_provider.dart';
import '../../screens/sign_btn_screen.dart';

class TrendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<Auth>(context).isAuth ? SizedBox() : Center(
      child: ElevatedButton(
        child: Text("Login"),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                //return AuthScreen();
                return SignButtonScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
