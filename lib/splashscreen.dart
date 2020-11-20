import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'homepage.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomePage(),
      title: Text(
        'Dog and Cat',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(0xffe99600),
        ),
      ),
      image: Image.asset('assets/cat.png'),
      backgroundColor: Colors.black,
      photoSize: 50,
      loaderColor: Color(0xffeeda28),
    );
  }
}
