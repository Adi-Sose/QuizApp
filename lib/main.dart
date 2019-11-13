import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/Quiz/Quiz.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Quizz app')),
        body: Quiz(),
      ),
    );
  }
}