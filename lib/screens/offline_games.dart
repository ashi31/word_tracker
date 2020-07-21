import 'package:flutter/material.dart';

class OfflineGames extends StatelessWidget {
  final List offlineGamesList;
  OfflineGames({this.offlineGamesList});
  @override
  Widget build(BuildContext context) {
    print(offlineGamesList[0]["date"].toDate());
    return Container(
      color: Colors.pink[100],
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemBuilder: (_, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Theme(
              data: ThemeData().copyWith(
                textTheme: TextTheme(
                  subtitle1: TextStyle(color: Colors.white, fontSize: 20.0),
                  bodyText2: TextStyle(color: Colors.white70, fontSize: 15.0),
                ),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(offlineGamesList[index]["date"]
                        .toDate()
                        .toString()
                        .substring(0, 10)
                        .split("-")
                        .reversed
                        .join("-")),
                    Text(offlineGamesList[index]["alphabet"]
                        .toString()
                        .toUpperCase()),
                    Text(offlineGamesList[index]["total_words"].toString()),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("player1 : ${offlineGamesList[index]["player1"]}"),
                    Text("player2 : ${offlineGamesList[index]["player2"]}"),
                  ],
                ),
                onTap: () {},
              ),
            ),
          ),
          color: Colors.pink,
        ),
        itemCount: offlineGamesList.length,
      ),
    );
  }
}
