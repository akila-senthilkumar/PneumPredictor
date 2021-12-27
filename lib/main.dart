import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pneumpredictor/quizscreen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final style = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    //backgroundColor: Color.fromRGBO(255, 206, 120, 1),
  );
  File pickedImage;
  bool isImageLoaded = false;
  List _result;
  String _confidence = "";
  String _name = "";
  String _value;
  String sendtoscreen = "";
  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      applyModelOnImage(pickedImage);
      _value = _name;
    });
  }

  loadMyModel() async {
    var resultant = await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
    print("Result after loading model: $resultant");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _result = res;
      String str = _result[0]["label"];

      _name = str.substring(2);
      _confidence = _result != null
          ? (_result[0]['confidence'] * 100.0).toString().substring(0, 2) + "%"
          : "";
    });
    print("Model Applied");
    print(_result);
    print(_name);
    sendtoscreen = _name;
  }

  @override
  void initState() {
    super.initState();
    loadMyModel();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 254, 209, 1),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: CustomPaint(
                  painter: OpenPainter(),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Color.fromRGBO(255, 206, 120, 1),
                        child: (Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "WELCOME",
                            style: GoogleFonts.openSans(
                              textStyle: style,
                            ),
                          ),
                        )),
                      ),
                    ),
                    Container(
                      height: 350,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: IconButton(
                                icon: Icon(
                                  Icons.upload_rounded,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                tooltip: 'Upload Image',
                                onPressed: () {
                                  getImageFromGallery();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "UPLOAD IMAGE",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                            isImageLoaded
                                ? Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      File(pickedImage.path)),
                                                  fit: BoxFit.contain)),
                                        ),
                                        // Text(
                                        //     "Name: $_name \nConfidence: $_confidence"),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 200,
                                            ),
                                            Container(
                                              child: ButtonTheme(
                                                minWidth: 150,
                                                height: 55,
                                                child: RaisedButton(
                                                  color: Color.fromRGBO(
                                                      255, 206, 120, 1),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          // builder: (context) =>
                                                          //     QuizHolderPage()),
                                                          //adding _name uncomment previous line if it goes wrong
                                                          builder: (context) =>
                                                              QuizHolderPage(
                                                                  value:
                                                                      sendtoscreen)),
                                                    );
                                                  },
                                                  child: Text(
                                                    "NEXT PAGE",
                                                    style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    // Column(
                    //   children: [
                    //     isImageLoaded
                    //         ? Center(
                    //             child: Column(
                    //               children: [
                    //                 Container(
                    //                   height: 50,
                    //                   width: 50,
                    //                   decoration: BoxDecoration(
                    //                       image: DecorationImage(
                    //                           image: FileImage(
                    //                               File(pickedImage.path)),
                    //                           fit: BoxFit.contain)),
                    //                 ),
                    //                 Text(
                    //                     "Name: $_name \nConfidence: $_confidence"),
                    //               ],
                    //             ),
                    //           )
                    //         : Container(),
                    //     //Text("Name: $_name \nConfidence: $_confidence"),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 200,
                    //     ),
                    //     Container(
                    //       child: ButtonTheme(
                    //         minWidth: 150,
                    //         height: 55,
                    //         child: RaisedButton(
                    //           color: Color.fromRGBO(255, 206, 120, 1),
                    //           onPressed: () {
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   // builder: (context) => QuestionScreen()),
                    //                   builder: (context) => QuizHolderPage()),
                    //             );
                    //           },
                    //           child: Text(
                    //             "NEXT PAGE",
                    //             style: GoogleFonts.openSans(
                    //               textStyle: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w700),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Container(
                      child: CustomPaint(
                        painter: OpenPainter2(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromRGBO(255, 206, 120, 1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(380, 50), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromRGBO(255, 206, 120, 1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(-170, 120), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
