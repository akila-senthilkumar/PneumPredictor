import 'package:flutter/material.dart';
import 'package:pneumpredictor/main.dart';

class Result extends StatelessWidget {
  int score;
  final String ans;
  Result(this.score, this.ans);

  String get resultPhrase {
    String resultText;
    print("result" + ans);
    // if (score < 5) {
    //   resultText = 'SAFE\n\nYour score is $score\n\n';
    // } else {
    //   resultText = 'SUSPECTED PNEUMONIA\n\nYour score is $score\n\n';
    // }
    if (ans == 'PNEUMONIA' && score >= 5) {
      resultText = 'SUSPECTED PNEUMONIA\n\n';
    } else if (ans == 'PNEUMONIA' && score < 5) {
      resultText =
          'SUSPECTED PNEUMONIA\n\nPlease consult a Medical Practitioner for further examination\n\n';
    } else if (ans == 'NORMAL' && score >= 5) {
      resultText =
          'OTHER RESPIRATORY COMPLICATIONS\n\nPlease consult a Medical Practitioner for further examination\n\n\n\n';
    } else {
      resultText = 'SAFE\n\n';
    }
    print(score);
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: CustomPaint(
            painter: OpenPainter(),
          ),
        ),
        Container(
          margin: EdgeInsets.all(40),
          child: Column(
            children: [
              Center(
                child: Text(
                  resultPhrase,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(255, 206, 120, 1)),
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'HOME SCREEN',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
              )
            ],
          ),
        ),
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

    canvas.drawCircle(Offset(190, -200), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
