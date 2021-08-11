import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import '../../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Map<String, String> authData = {"email": "", "password": "", "uname": ""};

  bool isLoginState = true;

  bool isLoading = false;

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final unameController = TextEditingController();

  bool validatePassword = false;
  bool validateEmail = false;
  bool validateUname = false;

  bool emailChecker(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  void showAlertBox(String title, String msg) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            content: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(child: Text(msg,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.grey[700],
                  ),
                ))),
            actions: [
              Center(child: Divider(thickness: 0.3, color: Colors.grey[600],),),
              Center(
                child: TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text("Close",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    )),
              )
            ],
          );
        });
  }

  void googleSign() async {
    final result = await FlutterWebAuth.authenticate(
        url:
            "https://sl-cinema.herokuapp.com/oauth2/authorize/google?redirect_uri=https://sl-cinema.herokuapp.com/oauth2/callback/google",
        callbackUrlScheme: "https://sl-cinema.herokuapp.com/oauth2/callback"
    );
    //print(result);
    final token = Uri.parse(result).queryParameters['token'];
    print(token);
  }

  Future<void> submit() async {
    try {
      setState(() {
        validatePassword = false;
        validateEmail = false;
        validateUname = false;
      });
      if (passwordController.text.isEmpty ||
          passwordController.text.length < 4) {
        setState(() {
          validatePassword = true;
        });
      }
      if (!emailChecker(emailController.text)) {
        setState(() {
          validateEmail = true;
        });
      }
      if (unameController.text.isEmpty && !isLoginState) {
        setState(() {
          validateUname = true;
        });
      }
      if (!validateUname && !validatePassword && !validateEmail) {
        authData['email'] = emailController.text;
        authData['password'] = passwordController.text;
        authData['uname'] = unameController.text;
        setState(() {
          isLoading = true;
        });
        if (isLoginState) {
          await Provider.of<Auth>(context, listen: false)
              .login(authData['email']!, authData['password']!);
          Navigator.of(context).pop();
          showAlertBox("Success!", "Login Successful!");
        } else {
          await Provider.of<Auth>(context, listen: false).signup(
              authData['uname']!, authData['email']!, authData['password']!);
          showAlertBox("Success!", "Signup Successful!");
          setState(() {
            isLoginState = true;
          });
        }
        emailController.clear();
        passwordController.clear();
        unameController.clear();
      }
    } catch (error) {
      showAlertBox("Error!", "Error Occurred");
      print(error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: isLoading
          ? Center(
              child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: CircularProgressIndicator()))
          : Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      margin: EdgeInsets.all(phoneWidth * 0.05),
                      child: Text(
                        isLoginState ? "Login" : "SignUp",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 35,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: phoneWidth * 0.17,
                    ),
                    !isLoginState
                        ? Center(
                            child: Container(
                              width: phoneWidth * 0.8,
                              margin: EdgeInsets.all(
                                phoneWidth * 0.05,
                              ),
                              child: TextFormField(
                                controller: unameController,
                                cursorHeight: 27,
                                style:
                                    TextStyle(decoration: TextDecoration.none),
                                decoration: InputDecoration(
                                    errorText:
                                        validateUname ? 'invalid input' : null,
                                    contentPadding: EdgeInsets.only(
                                        top: 1, left: 25, right: 20, bottom: 1),
                                    fillColor: Colors.grey[300],
                                    filled: true,
                                    prefixIcon: Icon(Icons.account_circle),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: "Enter Username"),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Center(
                      child: Container(
                        width: phoneWidth * 0.8,
                        margin: EdgeInsets.all(
                          phoneWidth * 0.05,
                        ),
                        child: TextFormField(
                          controller: emailController,
                          cursorHeight: 27,
                          style: TextStyle(decoration: TextDecoration.none),
                          decoration: InputDecoration(
                              errorText: validateEmail ? 'invalid input' : null,
                              contentPadding: EdgeInsets.only(
                                  top: 1, left: 25, right: 20, bottom: 1),
                              fillColor: Colors.grey[300],
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: "Enter Email"),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: phoneWidth * 0.8,
                        margin: EdgeInsets.all(
                          phoneWidth * 0.05,
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          cursorHeight: 27,
                          style: TextStyle(decoration: TextDecoration.none),
                          decoration: InputDecoration(
                              errorText:
                                  validatePassword ? 'invalid input' : null,
                              contentPadding: EdgeInsets.only(
                                  top: 1, left: 25, right: 20, bottom: 1),
                              fillColor: Colors.grey[300],
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: "Enter Password"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: phoneWidth * 0.07,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                        ),
                        onPressed: submit,
                        child: Text(isLoginState ? "Login" : "SignUp"),
                      ),
                    ),
                    SizedBox(
                      height: phoneWidth * 0.03,
                    ),
                    Center(
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            isLoginState = !isLoginState;
                            emailController.clear();
                            passwordController.clear();
                          });
                        },
                        child: Text(
                          isLoginState
                              ? "Dont have an account? Create a new account"
                              : "Have an account? Go to Login Screen...",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    // Container(
                    //   child: ElevatedButton(
                    //     child: Text("Google Signin"),
                    //     onPressed: googleSign,
                    //   ),
                    // )
                  ])),
    ));
  }
}
