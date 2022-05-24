import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  //var questions = ['What\'s your favorite colour?', 'What\'s your favorite animal'];

  // Convert above to Map() or implicit map by {}
  final questions = const [
    {
      'questionText': 'What\'s your favorite colour?',
      'answers': ['black', 'red', 'green', 'white'],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': ['Rabbit', 'Snake', 'Elephant', 'Lion'],
    },
    {
      'questionText': 'What\'s your favorite car?',
      'answers': ['Lotus', 'Lamborghini', 'Ferarri', 'Ford'],
    }
  ];

  var _questionIndex = 0;

  void _answerQuestion() {
    //var aBool = true;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    print(_questionIndex);
    if (_questionIndex < questions.length) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < questions.length
            ? Column(
                children: [
                  Question(
                    questions[_questionIndex]['questionText'],
                  ),
                  ...(questions[_questionIndex]['answers'] as List<String>).map((answer) {
                    //spread operator before a list - take a list and pull all the values in the list out of it, to the surrounding list - adding values to the list without nesting lists
                    //map will iterate through each item in the map
                    return Answer(_answerQuestion, answer);
                  }).toList()
                  // Answer(_answerQuestion),
                  // Answer(_answerQuestion),
                  // Answer(_answerQuestion),
                  // // RaisedButton(child: Text('Answer 1'), onPressed: _answerQuestion),
                  // RaisedButton(child: Text('Answer 2'), onPressed: () => print('Answer 2 chosen!')), // anonymous function
                  // RaisedButton(
                  //     child: Text('Answer 3'),
                  //     onPressed: () {
                  //       // .... optional code if we wanna
                  //       print('Answer 3 chosen!');
                  //     }),
                ],
              )
            : Center(child: Text('No more questions')),
      ),
    );
  }
}
