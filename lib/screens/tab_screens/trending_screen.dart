import 'package:flutter/material.dart';

import '../../screens/auth_screen.dart';

class TrendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
