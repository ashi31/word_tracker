import 'package:flutter/material.dart';
import 'package:word_tracker/screens/homePage.dart';
import 'package:word_tracker/screens/loading_screen.dart';
import 'package:word_tracker/screens/login_page.dart';
import 'package:word_tracker/screens/profile_page.dart';
import 'package:word_tracker/util/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
//      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }
}
