import 'package:flutter/material.dart';
import 'package:queries/collections.dart';

class Answers extends StatelessWidget {
  // Members
  final Collection<Answer> _answers;
  final Function _onPress;

  // Constructor
  Answers(this._answers, this._onPress);

  // Build
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Order answers by orderNumber
        ..._answers.orderBy((o) => o.orderNumber).toList().map((answer) {
          //Display a button for each possible answer
          return SizedBox(
            child: RaisedButton(
                child: Text('${answer.orderNumber}. ${answer.text}'),
                onPressed: () =>
                    (_onPress(answer.isCorrect, answer.questionId))),
            width: 150,
          );
        }).toList()
      ],
    );
  }
}

// Answer class
class Answer {
  String text;
  int orderNumber;
  bool isCorrect;
  int questionId;

  Answer({@required this.orderNumber, @required this.text, this.isCorrect = false, @required this.questionId});
}
