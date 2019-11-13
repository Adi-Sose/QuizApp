import 'package:flutter/material.dart';
import 'package:queries/collections.dart';
import 'package:quiz_app/NullWidget.dart';
import 'package:quiz_app/Quiz/Answers.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // Members
  Collection<Question> _questions;
  int _currentQuestion = 0;
  int _totalPoints = 0;
  bool get isFinished => _currentQuestion == _questions.length;  // True if the quiz is finished

  // Constructor
  _QuizState() {
    // Initialize questions
    _questions = new Collection<Question>([
      new Question(
          id: 1,
          text: 'Omiljena boja',
          points: 1,
          answers: new Collection<Answer>([
            new Answer(orderNumber: 1, text: 'Plava', questionId: 1, isCorrect: true),
            new Answer(orderNumber: 2, text: 'Zuta', questionId: 1),
            new Answer(orderNumber: 3, text: 'Zelena', questionId: 1),
          ])),
      new Question(
          id: 2,
          text: 'Omiljena zivotinja',
          points: 2,
          answers: new Collection<Answer>([
            new Answer(orderNumber: 1, text: 'Macka', questionId: 2, isCorrect: true),
            new Answer(orderNumber: 2, text: 'Pas', questionId: 2),
            new Answer(orderNumber: 3, text: 'Ptica', questionId: 2),
          ])),
      new Question(
          id: 3,
          text: 'Najdrazi grad',
          points: 3,
          answers: new Collection<Answer>([
            new Answer(orderNumber: 4, text: 'Tuzla', questionId: 3),
            new Answer(orderNumber: 1, text: 'Sarajevo', questionId: 3),
            new Answer(orderNumber: 2, text: 'Mostar', questionId: 3, isCorrect: true),
            new Answer(orderNumber: 3, text: 'Zenica', questionId: 3),
          ])),
    ]);
  }


  // Functions
  void answerQuestion(bool correct, int id) {
    // Next question
    setState(() => _currentQuestion++);

    // Add points
    if (correct)
      setState(() => _totalPoints +=
          _questions.where((w) => w.id == id).firstOrDefault().points);
  }

  // Restart the quiz
  void _retartQuiz() =>
      setState(() => {_totalPoints = 0, _currentQuestion = 0});

  // Build
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        // If the quiz is finished display the finished message
        // Else display current question
        Container(
          child: isFinished
              ? Text('Finished!', textScaleFactor: 2.5)
              : Text('${_questions[_currentQuestion].text} ?',
                  textScaleFactor: 1.5),
          margin: EdgeInsets.only(bottom: isFinished ? 0 : 15.0),
        ),
        // If the quiz is not finished display possible answers
        isFinished
            ? null
            : Answers(_questions[_currentQuestion].answers, answerQuestion),
        // Display the points
        Text('Points: $_totalPoints', textScaleFactor: isFinished ? 2 : 1.5),
        // If the quiz is finished display the restart button
        isFinished
            ? RaisedButton(child: Text('Restart quiz'), onPressed: _retartQuiz)
            : null
      ].where(notNull).toList(), //This line checks for nulls and returns only widgets that are meant to be shown 
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    ));
  }
}

// Question class
class Question {
  int id;
  String text;
  Collection<Answer> answers;
  int points;

  Question({@required this.text, @required this.answers, @required this.points, @required this.id});
}
