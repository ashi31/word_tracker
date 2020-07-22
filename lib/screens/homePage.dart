import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:word_tracker/screens/profile_page.dart';
import 'package:word_tracker/util/constants.dart';
import 'package:word_tracker/widgets/close_app.dart';
import 'package:word_tracker/widgets/custom_button.dart';

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
    double width = MediaQuery.of(context).size.width;
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
        width: width,
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
                (offline == true)
                    ? SizedBox(
                        width: width / 2.3,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: "Player  1 Name",
                              onChangedCallback: (String value) {
                                print(value);
                              },
                            ),
                            CustomTextField(
                              hintText: "Player  2 Name",
                              onChangedCallback: (String value) {
                                print(value);
                              },
                            ),
                            CustomTextField(
                              hintText: "Alphabet",
                              onChangedCallback: (String value) {
                                print(value);
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
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

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function onChangedCallback;
  CustomTextField({this.hintText, this.onChangedCallback});
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 3.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: width,
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: TextStyle(
                color: kShadowColor,
              ),
            ),
            style: TextStyle(color: Colors.white),
            onChanged: onChangedCallback,
          ),
          decoration: ShapeDecoration(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: kShadowColor)),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0),
          margin: EdgeInsets.symmetric(vertical: 5.0),
        ),
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      ],
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
          child: Text(
            "Start",
            style: TextStyle(color: Colors.white),
          ),
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
