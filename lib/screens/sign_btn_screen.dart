import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignButtonScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final topMargin = MediaQuery.of(context).padding.top;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(topMargin),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: width * 0.05),
                child: Text(
                  "Experience all the features",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 35,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.symmetric(horizontal: width * 0.085),
                child: Divider(color: Colors.pink[100], thickness: 2.6,),
              ),
              SizedBox(height: height * 0.08,),
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {},
              ),
              SizedBox(height: height * 0.025,),
              SignInButton(
                Buttons.Facebook,
                text: "Sign in with Facebook",
                onPressed: () {},
              ),
              SizedBox(height: height * 0.03,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Divider(color: Colors.grey[600], thickness: 0.2,)),
                    Text("    or    ", style: TextStyle(color: Colors.grey[800], fontSize: 16),),
                    Expanded(child: Divider(color: Colors.grey[600], thickness: 0.2,)),
                  ],
                ),
              ),

              SizedBox(height: height * 0.03,),
              SignInButtonBuilder(
                text: 'Continue with Email',
                icon: Icons.email,
                onPressed: () {},
                backgroundColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
