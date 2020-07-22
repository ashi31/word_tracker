import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_tracker/util/constants.dart';

class CloseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close,
        size: 40.0,
      ),
      onPressed: () {
        showDialog(
            context: context,
            child: AlertDialog(
              title: Text("Confirm Exit?"),
              actions: [
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No"),
                  borderSide: BorderSide(
                    color: kShadowColor,
                    width: 2.0,
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text("Yes"),
                ),
              ],
            ));
      },
    );
  }
}
