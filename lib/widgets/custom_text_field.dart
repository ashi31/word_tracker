import 'package:flutter/material.dart';
import 'package:word_tracker/util/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function onChangedCallback;
  final bool correct;
  final String initialValue;
  CustomTextField(
      {this.hintText, this.onChangedCallback, this.correct, this.initialValue});
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 3.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: width,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: TextStyle(
                color: kShadowColor,
              ),
            ),
            style: TextStyle(color: Colors.white),
            onChanged: onChangedCallback,
            initialValue: initialValue,
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
          correct ? Icons.check : Icons.close,
          color: correct ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
