import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:word_tracker/screens/homePage.dart';
import 'package:word_tracker/screens/login_page.dart';
import 'package:word_tracker/util/constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    _auth.currentUser().then((currentUser) {
      if (currentUser == null) {
        Timer(Duration(seconds: 2),
            () => Navigator.of(context).pushReplacementNamed(LoginPage.id));
      } else {
        Timer(Duration(seconds: 2),
            () => Navigator.of(context).pushReplacementNamed(HomePage.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kLoaderPage,
        child:
            SpinKitChasingDots(itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? kShadowColor : Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          );
        }),
      ),
    );
  }
}
