import 'package:flutter/material.dart';
import 'package:word_tracker/screens/login_page.dart';
import 'package:word_tracker/util/sign_in.dart';

class ProfilePage extends StatelessWidget {
  static const String id = "profile_page";
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          child: SafeArea(
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(args["photoUrl"]),
                  ),
                  Text(
                    args["name"],
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w100),
                  ),
                  Text(
                    args["email"],
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w100),
                  ),
                  Text(
                    "total games played : 20",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w100),
                  ),
                  Expanded(
                    child: TabBar(
                      labelColor: Colors.pink,
                      tabs: [
                        new Text(
                          "Offline",
                        ),
                        new Text(
                          "Online",
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                child: IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    signOutGoogle();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginPage.id, (route) => false);
                  },
                ),
                right: 0.0,
              ),
            ]),
          ),
          preferredSize: Size.fromHeight(250.0),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              color: Colors.pink[100],
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (_, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
//                    child: Text("hello"),
                  ),
                  color: Colors.pink,
                ),
                itemCount: 3,
              ),
            ),
            Column(
              children: <Widget>[Text("Cart Page")],
            )
          ],
        ),
      ),
    );
  }
}
