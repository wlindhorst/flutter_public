import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler; // will receive the pointer for the callback function
  final String answerText;

  Answer(this.selectHandler, this.answerText); // will allow to receive the passed pointer to the function in the calling class

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(child: Text(answerText), onPressed: selectHandler, textColor: Colors.white, color: Colors.blue),
    );
  }
}
