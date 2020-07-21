import 'package:flutter/material.dart';
import 'package:word_tracker/screens/homePage.dart';
import 'package:word_tracker/util/constants.dart';
import 'package:word_tracker/util/sign_in.dart';

class LoginPage extends StatefulWidget {
  static final String id = 'LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kLoaderPage,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 16,
//            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(horizontal: 100.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kShadowColor,
                  spreadRadius: 2.0,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: isLoading
                ? CircularProgressIndicator()
                : RaisedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      bool x = await signInWithGoogle();
                      if (x == true) {
                        Navigator.of(context).pushReplacementNamed(HomePage.id);
                      }
                      setState(() {
                        isLoading = false;
                      });
//                print(x);
                    },
                    color: kButtonColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          kGoogleLogo,
                          width: 30.0,
                        ),
                        Text(
                          'Google Sign in',
                          style: TextStyle(color: kShadowColor, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
