import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/helpers/preference.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'package:flutter_login_ui/models/users.dart';
import 'package:http/http.dart' as http;
import 'registration_page.dart';
import 'main_page.dart';

int? userId;
Future<List<Users>> fetchUsers() async {
  final response = await http
      .get(Uri.parse('https://teameduc8.herokuapp.com/api/users'));

  if (response.statusCode == 200) {
    return compute(parseUsers, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Subjects');
  }
}

List<Users> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Users>((json) => Users.fromJson(json)).toList();
}

Future<bool> authenticate(String username, String password) async{
  List<Users> userList = await fetchUsers();
  bool match =false;
  userList.forEach((Users a) {
    if(username == a.email && password == a.password){
      match = true;
      userId = a.user_id;
    }
  });
  return match;
}

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  double _headerHeight = 100;
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF252834),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child:
              Image.asset(
                "assets/images/Group-6.png",
                scale: 0.8,
                fit: BoxFit.fitHeight,
              ),
            ),

            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),// This will be the login form
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(3,0,5,30),
                        child:
                        Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat' ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(3,0,5,10),
                                child:
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white),
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  controller: _controllerUser,
                                  decoration: ThemeHelper().textInputDecoration("@mail.com"),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if(val!.isEmpty || !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                      return "Enter a valid email address";
                                    }
                                    return null;
                                  },
                                ),
                                // decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(3,0,5,10),
                                child:
                                Text(
                                  'Password',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white),
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  controller: _controllerPassword,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration('Password'),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                ),
                                // decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                  decoration: ThemeHelper().buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                      style: ThemeHelper().buttonStyle(context),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                        child: Text(
                                          "login".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Future<bool> match = authenticate(
                                            _controllerUser.text,
                                            _controllerPassword.text);
                                        {
                                          if (_formKey.currentState!.validate() &&
                                              await match) {
                                            Preference.setUser(userId!);
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainPage(text: userId,)
                                                ),
                                                    (Route<dynamic> route) => false
                                            );
                                          };
                                        };
                                      }
                                  )
                              ),

                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(10,80,10,20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: "Don\'t have an account yet? \n", style: TextStyle(color: Color(0xFFFFFFFF))),

                                          TextSpan(
                                            text: 'Register',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                              },
                                            style: TextStyle(fontWeight: FontWeight.bold, color: warna),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}