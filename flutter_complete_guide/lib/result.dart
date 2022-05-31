import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    var resultText = 'you suck!';
    if (resultScore <= 8) {
      resultText = 'Less than or equal 8';
    } else if (resultScore <= 12) {
      resultText = 'Kinda lame';
    } else if (resultScore <= 16) {
      resultText = 'work harder';
    } else {
      resultText = 'totally lame';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          onPressed: resetHandler,
          child: Text('Restart Quiz'),
          textColor: Colors.blue,
        )
      ],
    ));
  }
}
