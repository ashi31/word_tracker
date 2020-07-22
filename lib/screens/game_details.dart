import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GameDetails extends StatelessWidget {
  static const String id = "game_details";
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Card(
            margin: EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date : " +
                      args["game_details"]["date"]
                          .toDate()
                          .toString()
                          .substring(0, 10)
                          .split("-")
                          .reversed
                          .join("-")),
                  Text("Alphabet : " +
                      args["game_details"]["alphabet"]
                          .toString()
                          .toUpperCase()),
                  Text("Total Words : " +
                      args["game_details"]["total_words"].toString()),
                  Row(
                    children: [
                      Text("Player1 : " +
                          args["game_details"]["player1"].toString()),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 10.0,
                        width: 20.0,
                        color: Colors.pink[200],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Player2 : " +
                          args["game_details"]["player2"].toString()),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 10.0,
                        width: 20.0,
                        color: Colors.green[200],
                      ),
                    ],
                  ),
                  Text("Mode : " + args["mode"].toString().toUpperCase()),
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100.0),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("offline_games")
            .document("${args["game_details"]["game_id"]}")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return LinearProgressIndicator();
          }
          return Container(
            child: ListView.builder(
              itemBuilder: (context, index) => Card(
                color: index % 2 == 0 ? Colors.pink[200] : Colors.green[200],
                child: ListTile(
                  title: Text(snapshot.data["words"][index]),
                ),
              ),
              itemCount: snapshot.data["words"].length,
            ),
          );
        },
      ),
    );
  }
}
