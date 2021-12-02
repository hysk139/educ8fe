import 'dart:async';

import 'package:flutter/material.dart';

import 'boarding_page.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    new Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => boardingPage()), (route) => false);
      });
    });

    new Timer(
      Duration(milliseconds: 10),(){
        setState(() {
          _isVisible = true; // Now it is showing fade effect and navigating to Login page
        });
      }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: new BoxDecoration(
        color: Color(0xFF252834),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 270.0,
            width: 180.0,
            child: Center(
              child: Text(
                'ED\nUC\n∞',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.normal),
              ), //put your logo here
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xFF252834),
              border: Border.all(width: 2, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}