import 'package:flutter/material.dart';

import './question.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var questions = ['What\'s your favorite colour?', 'What\'s your favorite animal'];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: [
            Question(
              questions[_questionIndex],
            ),
            RaisedButton(child: Text('Answer 1'), onPressed: _answerQuestion),
            RaisedButton(child: Text('Answer 2'), onPressed: () => print('Answer 2 chosen!')), // anonymous function
            RaisedButton(
                child: Text('Answer 3'),
                onPressed: () {
                  // .... optional code if we wanna
                  print('Answer 3 chosen!');
                }),
          ],
        ),
      ),
    );
  }
}
