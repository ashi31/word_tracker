import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:word_tracker/screens/login_page.dart';
import 'package:word_tracker/util/constants.dart';
import 'package:word_tracker/util/sign_in.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool loggedIn = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String name;
  String email;
  String imageUrl;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    final FirebaseUser user = await _auth.currentUser();
    name = user.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kButtonColor,
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () async {
              signOutGoogle();
              Navigator.of(context).pushReplacementNamed(LoginPage.id);
            },
            child: Text("Hello $name"),
          ),
        ),
      ),
    );
  }
}
