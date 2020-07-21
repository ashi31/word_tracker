import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:word_tracker/models/close_app.dart';
import 'package:word_tracker/models/custom_button.dart';
import 'package:word_tracker/screens/profile_page.dart';
import 'package:word_tracker/util/constants.dart';

bool offline = true;
bool online = false;

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    email = user.email;
    imageUrl = user.photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kButtonColor,
        title: IconButton(
          icon: Icon(
            Icons.account_circle,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(ProfilePage.id, arguments: {
              "name": name,
              "email": email,
              "photoUrl": imageUrl
            });
          },
        ),
        actions: [
          CloseApp(),
        ],
      ),
      backgroundColor: kButtonColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                    content: "Offline",
                    selected: offline,
                    onPressedCallBack: () {
                      offline = true;
                      online = false;
                      setState(() {});
                    }),
                CustomButton(
                  content: "Online",
                  selected: online,
                  onPressedCallBack: () {
                    offline = false;
                    online = true;
                    setState(() {});
                  },
                ),
              ],
            ),
            StartButton(),
          ],
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width / 1.2,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: RaisedButton(
          onPressed: () {},
          shape: BeveledRectangleBorder(
              side: BorderSide(color: kShadowColor, width: 5.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 10.0,
          color: kButtonColor,
          highlightColor: kButtonColor,
          focusColor: kButtonColor,
          splashColor: kButtonColor,
          focusElevation: 0.0,
          highlightElevation: 0.0,
          child: Text("Start"),
        ));
  }
}

class LoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              kAppTitle,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            background: Opacity(
              opacity: 0.3,
              child: Image(
                image: AssetImage('assets/images/appbarimage.jpg'),
                fit: BoxFit.cover,
//                    width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          elevation: 0.0,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                    title: Text('$index'),
                  ),
              childCount: 20),
        ),
//        SliverList(
//          delegate: SliverChildListDelegate(
//            [
//              Container(
//                height: MediaQuery.of(context).size.height - 90,
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(40),
//                      topRight: Radius.circular(40),
//                    )),
//                child: Center(child: Text('data')),
//              )
//            ],
//          ),
//        )
      ],
    );
  }
}

class NotLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {},
        ),
      ),
    );
  }
}
