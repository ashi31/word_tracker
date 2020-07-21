import 'package:flutter/material.dart';
import 'package:word_tracker/util/constants.dart';

class CustomButton extends StatelessWidget {
  final String content;
  final bool selected;
  final Function onPressedCallBack;
  CustomButton({this.content, this.selected, this.onPressedCallBack});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 16,
        width: MediaQuery.of(context).size.width / 2,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: RaisedButton(
          onPressed: onPressedCallBack,
          shape: BeveledRectangleBorder(
              side: BorderSide(
                  color: selected ? kButtonColor : kShadowColor, width: 5.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 10.0,
          color: selected ? kShadowColor : kButtonColor,
          highlightColor: kButtonColor,
          focusColor: kButtonColor,
          splashColor: kButtonColor,
          focusElevation: 0.0,
          highlightElevation: 0.0,
          child: Text(content),
        ));
  }
}
