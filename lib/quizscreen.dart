import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

class QuizHolderPage extends StatefulWidget {
  final String value;
  QuizHolderPage({Key key, @required this.value}) : super(key: key);
  @override
  _QuizHolderPageState createState() => _QuizHolderPageState(value);
}

class _QuizHolderPageState extends State<QuizHolderPage> {
  String value;
  _QuizHolderPageState(this.value);
  int questionIndex = 0;
  int totalScore = 0;

  var questions = [
    {
      'question': 'Q1. Do you consume Alcohol?',
      'answers': [
        {'text': 'YES', 'score': 1},
        {'text': 'NO', 'score': 0}
      ]
    },
    {
      'question': 'Q2. Select Age-group',
      'answers': [
        {'text': '>70 Years', 'score': 1},
        {'text': '<70 Years', 'score': 0},
      ]
    },
    {
      'question': 'Q3. Do you smoke?',
      'answers': [
        {'text': 'YES', 'score': 1},
        {'text': 'NO', 'score': 0}
      ]
    },
    {
      'question': 'Q4. Have you recently experienced nausea/vomiting/diarrhea?',
      'answers': [
        {'text': 'YES', 'score': 1},
        {'text': 'NO', 'score': 0},
      ]
    },
    {
      'question': 'Q5. Do you experience Asthma?',
      'answers': [
        {'text': 'YES', 'score': 1},
        {'text': 'NO', 'score': 0},
      ]
    },
    {
      'question': 'Q6. Do you take any immunosuppressants?',
      'answers': [
        {'text': ' YES', 'score': 1},
        {'text': 'NO', 'score': 0}
      ]
    },
    //
    {
      'question': 'Q7. Do you have fever?',
      'answers': [
        {'text': ' YES', 'score': 1},
        {'text': 'NO', 'score': 0}
      ]
    },
    //
    {
      'question': 'Q8. Do you experience chest pain while coughing?',
      'answers': [
        {'text': ' YES', 'score': 1},
        {'text': 'NO', 'score': 0}
      ]
    },
    //
    {
      'question': 'Q9. Do you experience shortness of breath?',
      'answers': [
        {'text': ' YES', 'score': 1},
        {'text': 'NO', 'score': 0}
      ]
    },
    //
    {
      'question': 'Q10. Do you feel tired?',
      'answers': [
        {'text': ' YES', 'score': 1},
        {'text': 'NO', 'score': 0}
      ]
    },
    //
  ];

  void answerQuestion(int score) {
    totalScore += score;
    setState(() {
      questionIndex += 1;
    });
    print(totalScore);
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 254, 209, 1),
        body: questionIndex < questions.length
            ? Quiz(questions, answerQuestion, questionIndex)
            : Result(totalScore, value),
      ),
    );
  }
}
