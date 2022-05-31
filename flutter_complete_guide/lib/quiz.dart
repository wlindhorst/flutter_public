import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  final int questionIndex;

  Quiz({@required this.questions, @required this.answerQuestion, @required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'],
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>).map((answer) {
          //spread operator before a list - take a list and pull all the values in the list out of it, to the surrounding list - adding values to the list without nesting lists
          //map will iterate through each item in the map

          // anonymous function '() => x' will still get the address of the answerQuestion, when we add the parens to the fN we can pass parameters
          // to the answerQuestion fN
          return Answer(() => answerQuestion(answer['score']), answer['text']);
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
    );
  }
}
