import 'package:flutter/material.dart';
import 'package:word_tracker/util/constants.dart';

class GameScreen extends StatefulWidget {
  static const id = "game_screen";
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool addWord = false;
  bool wrongWord = false;
  List<String> words = [];
  bool player1Turn = true;
  TextEditingController addNewWord = new TextEditingController();
//  CollectionReference f = Firestore.instance.collection("offline_games");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: DetailsAppBar(args: args),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                InkWell(
                    child: CircleAvatar(
                      child: Icon(
                        addWord
                            ? Icons.check
                            : wrongWord ? Icons.close : Icons.add,
                        color: addWord
                            ? Colors.green[900]
                            : wrongWord ? Colors.red[900] : Colors.white,
                      ),
                      radius: 25.0,
                      backgroundColor:
                          player1Turn ? kPlayer1Color : kPlayer2Color,
                    ),
                    onTap: () {
                      if (addWord && !wrongWord) {
                        setState(() {
                          words.add(addNewWord.text.toLowerCase());
                          addNewWord.clear();
                          player1Turn = !player1Turn;
                        });
                      } else {
                        return;
                      }
                    }),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: TextField(
                    onEditingComplete: () {
                      if (addWord) {
                        setState(() {
                          words.add(addNewWord.text.toLowerCase());
                          addNewWord.clear();
                          addWord = false;
                          wrongWord = false;
                        });
                      }
                    },
                    controller: addNewWord,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          wrongWord = false;
                          addWord = false;
                        });
                      } else if (value.substring(0, 1).toLowerCase() !=
                          args["alphabet"].toString().toLowerCase()) {
                        setState(() {
                          wrongWord = true;
                          addWord = false;
                        });
                      } else if (words.contains(value.toLowerCase())) {
                        setState(() {
                          wrongWord = true;
                          addWord = false;
                        });
                      } else {
                        setState(() {
                          wrongWord = false;
                          addWord = true;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) => Card(
                  color: index % 2 == 0 ? kPlayer1Color : kPlayer2Color,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: ListTile(
                    title: Text(words[index][0].toUpperCase() +
                        words[index].substring(1)),
                  ),
                ),
                itemCount: words.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Map args;
  DetailsAppBar({this.args});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        margin: EdgeInsets.all(0.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Alphabet : " +
                      args["alphabet"].toString().toUpperCase()),
                  Row(
                    children: [
                      Text("Player1 : " + args["player1Name"].toString()),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 10.0,
                        width: 20.0,
                        color: kPlayer1Color,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Player2 : " + args["player2Name"].toString()),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 10.0,
                        width: 20.0,
                        color: kPlayer2Color,
                      ),
                    ],
                  ),
                  Text("Mode : ${args["offlineMode"] ? "Offline" : "Online"}"),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: AlertDialogContent(),
                            ));
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.0);
}

class AlertDialogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Hola");
  }
}
