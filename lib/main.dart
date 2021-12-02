import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/preference.dart';
import 'helpers/globals.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  static getEducColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if (prefs == null) return 0;
    int value = prefs.getInt('color') ?? 0;
    Preference.getWarna(value);
  }

  @override
  Widget build(BuildContext context) {
    getEducColor();
    return MaterialApp(
      title: 'Educ 8',
      theme: ThemeData(
        //primaryColor: warna,
        fontFamily: 'montserrat',
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(title: 'Educ 8'),
    );
  }
}/*
int? isviewed;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isviewed != 0 ? OnBoard() : Home(),
    );
  }
}
*/
