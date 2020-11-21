import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  bool _loading = true;
  File _image;
  final picker = ImagePicker();
  List _output;

  @override
  void initState() {
    super.initState();
    loadModal().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModal() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  pickImageFromGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  pickImageFromCamera() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add_a_photo,
        ),
        onPressed: () {},
      ),
      backgroundColor: Color(0xff101010),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        child: Column(
          children: [
            SizedBox(height: 85),
            Text(
              'TeachableMachine.com CNN',
              style: TextStyle(
                color: Color(0xffeeda28),
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Detect Dogs and Cat',
              style: TextStyle(
                color: Color(0xffe99600),
                fontWeight: FontWeight.w500,
                fontSize: 28.0,
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: _loading
                  ? Container(
                      width: 250.0,
                      child: Column(
                        children: [
                          Image.asset('assets/cat.png'),
                          SizedBox(height: 50.0),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: 250.0,
                            child: Image.file(_image),
                          ),
                          SizedBox(height: 20.0),
                          _output != null
                              ? Text(
                                  '${_output[0]['label'].subString}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickImageFromGallery,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 210,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 17.0,
                        horizontal: 24.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffe99600),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Take a photo',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: pickImageFromCamera,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 210,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 17.0,
                        horizontal: 24.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffe99600),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Camera Roll',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
