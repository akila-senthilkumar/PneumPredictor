import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pneumpredictor/main.dart';
import 'package:pneumpredictor/newquestion.dart';
import 'package:pneumpredictor/answer.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questionList;
  final Function(int) selectHandler;

  Quiz(
    this.questionList,
    this.selectHandler,
    this.questionIndex,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Question(questionList[questionIndex]['question'] as String),
        // ...(questionList[questionIndex]['answers'] as List<Map<String, Object>>)
        //     .map((answer) {
        //   return Answer(answer['text'] as String,
        //       () => selectHandler(answer['score'] as int));
        // }).toList(),
        Container(
          margin: EdgeInsets.only(top: 60, left: 20),
          child: ButtonTheme(
            minWidth: 50,
            height: 55,
            child: FlatButton(
              shape: CircleBorder(),
              color: Color.fromRGBO(255, 206, 120, 1),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: IconButton(
                alignment: Alignment.center,
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
            ),
          ),
        ),
        Container(
          child: CustomPaint(
            painter: OpenPainter(),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Question(questionList[questionIndex]['question'] as String),
              ...(questionList[questionIndex]['answers']
                      as List<Map<String, Object>>)
                  .map((answer) {
                return Answer(answer['text'] as String,
                    () => selectHandler(answer['score'] as int));
              }).toList(),
            ],
          ),
        )
      ],
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromRGBO(255, 206, 120, 1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(190, -250), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
