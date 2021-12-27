import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImageUploadScreen extends StatefulWidget {
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  bool _loading = false;
  File _image;
  List _outputs;
  final _imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/tf_lite_model.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  pickImage() async {
    var image = await _imagePicker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    //return Container();
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 254, 209, 1),
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _image == null
                      ? Container()
                      : Container(
                          child: Image.file(_image),
                          height: 500,
                          width: MediaQuery.of(context).size.width - 200,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  _outputs != null
                      ? Text(
                          "${_outputs[0]["labels"]}"
                              .replaceAll(RegExp(r'[0-9]'), ''),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              background: Paint()..color = Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      : Text("Classification Waiting"),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(255, 206, 120, 1),
        onPressed: pickImage,
        tooltip: 'Classify',
        child: Icon(Icons.upload_file),
      ),
    );
  }
}
