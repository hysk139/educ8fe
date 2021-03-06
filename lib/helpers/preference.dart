import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';

class Preference{
  // Save background color
  static Future <bool> setEducColor(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if(prefs == null) return 0;
    return prefs.setInt('color', value);
  }

  static getWarna(int value){
    if (value == 0){
      warna = Color(0xFF246BFD);
      //return Colors.indigo;
    }
    if (value == 1){
      warna = Color(0xFFCA85EB);
      //return Colors.indigo;
    }
    if(value == 2){
      warna = Colors.green;
      //return Colors.green;
    }
    if(value == 3){
      warna = Colors.purple;
      //return Colors.purple;
    }
    if(value == 4){
      warna = Colors.pink;
      //return Colors.pink;
    }
    if(value == 5){
      warna = Colors.red;
      //return Colors.red;
    }
    if(value == 6){
      warna = Color(0xFF246BFD);
      //return Colors.yellow;
    }
  }

  static Future <bool> setIsViewed(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if(prefs == null) return 0;
    return prefs.setInt('isViewed', value);
  }

  static getStatus(int value){
    isViewed = value;
  }

  static Future <bool> setUser(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if(prefs == null) return 0;
    return prefs.setInt('userId', value);
  }

  static getUserId(int value){
    userID = value;
  }
}