import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:word_tracker/screens/login_page.dart';
import 'package:word_tracker/util/sign_in.dart';
import 'package:word_tracker/widgets/offline_games.dart';

class ProfilePage extends StatelessWidget {
  static const String id = "profile_page";
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    int totalOnlineGames, totalOfflineGames;
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("user_details")
            .document("${args["email"].toString().split("@")[0]}")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return LinearProgressIndicator();
          }
          totalOnlineGames = snapshot.data["total_games"]["online_games"];
          totalOfflineGames = snapshot.data["total_games"]["offline_games"];
//          print(snapshot.data["offline_games"].runtimeType);
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
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w100),
                        ),
                        Text(
                          args["email"],
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w100),
                        ),
                        Text(
                          "total games played : ${totalOnlineGames + totalOfflineGames}",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w100),
                        ),
                        Expanded(
                          child: TabBar(
                            labelColor: Colors.pink,
                            tabs: [
                              new Text(
                                "Offline Games ($totalOfflineGames)",
                              ),
                              new Text(
                                "Online Games ($totalOnlineGames)",
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
                  OfflineGames(
                      offlineGamesList: snapshot.data["offline_games"]),
                  Column(
                    children: <Widget>[Text("Cart Page")],
                  )
                ],
              ),
            ),
          );
        });
  }
}
