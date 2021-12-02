import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/helpers/preference.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'boarding_page.dart';
import 'login_page.dart';
import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  static getIsViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if (prefs == null) return 0;
    int value = prefs.getInt('isViewed') ?? 0;
    Preference.getStatus(value);
  }

  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if (prefs == null) return 0;
    int value = prefs.getInt('userId') ?? 0;
    Preference.getUserId(value);
  }

  _SplashScreenState(){
    getIsViewed();
    getUser();

    new Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        if (isViewed == 0){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => boardingPage()), (route) => false);
        }
        else {
          if (userID == 0){
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
          }
          else {
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainPage(text: userID)), (route) => false);
          }
        };
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