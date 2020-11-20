import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  bool _loading = true;
  File image;
  final _picker = ImagePicker();

  Future getImage() async {
    var pickedImage = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        _loading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add_a_photo,
        ),
        onPressed: () {
          getImage();
        },
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
                  : Container(),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
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
                    onTap: () {},
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
