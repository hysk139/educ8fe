
import 'dart:async';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'package:flutter_login_ui/models/users.dart';
import 'package:flutter_login_ui/pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'profile_page.dart';
import 'login_page.dart';


Future<Users> editUser(String email, String password, String name, String phoneNumber, Users currentUser) async {
  if (email==''){
    email = currentUser.email!;
  }

  if (password==''){
    password = currentUser.password!;
  }
  if (name==''){
    name = currentUser.name!;
  }
  if (phoneNumber==''){
    phoneNumber = currentUser.phone_number!;
  }


  final response = await http.put(
    Uri.parse('https://teameduc8.herokuapp.com/api/edit/update/users/${currentUser.user_id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email": email,
      "password" : password,
      "name" : name,
      "phone_number": phoneNumber,
    }),


  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Users.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}


Future<List<Users>> fetchUsers(int? userId) async {
  final response = await http
      .get(Uri.parse('https://teameduc8.herokuapp.com/api/users/${userId}'));

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

class EditProfilePage extends  StatefulWidget{
  final int? text;

  EditProfilePage({Key? key, @required this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage>{
  double _headerHeight = 10;
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF252834),
        appBar: AppBar(
        elevation: 0,
          leading: IconButton(
            onPressed: () {
              //tambahin back kemana
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage(text: widget.text)));
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
        iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace:Container(
            decoration: BoxDecoration(
              color: Color(0xFF252834),
            ),
          ),
        ),
      body: FutureBuilder<List<Users>>(
          future : fetchUsers(widget.text),
          builder: (context, snapshot){

            if (snapshot.hasData) {
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: _headerHeight,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(20,0,5,10),
                                child:
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(20,0,5,10),
                                child:
                                Text(
                                  'Hi, ' + snapshot.data![index].name!,
                                  style: TextStyle(fontSize: 20, color: warna),
                                ),
                              ),
                              SafeArea(
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.fromLTRB(3,0,5,10),
                                                  child:
                                                  Text(
                                                    'Name',
                                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                                  ),
                                                ),
                                                Container(
                                                  child: TextFormField(
                                                    controller: name,
                                                    decoration: ThemeHelper().textInputDecoration(snapshot.data![index].name!),
                                                    validator: (val) {
                                                      if(val!.isEmpty){
                                                        return "Enter a valid name";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                                ),
                                                SizedBox(height: 15,),

                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.fromLTRB(3,0,5,10),
                                                  child:
                                                  Text(
                                                    'E-Mail',
                                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                                  ),
                                                ),
                                                Container(
                                                  child: TextFormField(
                                                    controller: email,
                                                    decoration: ThemeHelper().textInputDecoration(snapshot.data![index].email!),
                                                    keyboardType: TextInputType.emailAddress,
                                                    validator: (val) {
                                                      if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                                        return "Enter a valid email address";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                                ),
                                                SizedBox(height: 15.0),

                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.fromLTRB(3,0,5,10),
                                                  child:
                                                  Text(
                                                    'Phone Number',
                                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                                  ),
                                                ),
                                                Container(
                                                  child: TextFormField(
                                                    controller: phoneNumber,
                                                    decoration: ThemeHelper().textInputDecoration(snapshot.data![index].phone_number!),
                                                    keyboardType: TextInputType.phone,
                                                    validator: (val) {
                                                      if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                                                        return "Enter a valid phone number";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                                ),
                                                SizedBox(height: 15.0),

                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.fromLTRB(3,0,5,10),
                                                  child:
                                                  Text(
                                                    'Password',
                                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                                  ),
                                                ),
                                                Container(
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    controller: password,
                                                    decoration: ThemeHelper().textInputDecoration(
                                                        "Password"),
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Please enter your password";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                                ),
                                                SizedBox(height: 15.0),

                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.fromLTRB(3,0,5,10),
                                                  child:
                                                  Text(
                                                    'Confirm Password',
                                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                                  ),
                                                ),
                                                Container(
                                                  child: TextFormField(
                                                    controller: confirmpassword,
                                                    obscureText: true,
                                                    decoration: ThemeHelper().textInputDecoration(
                                                        "Re-Enter Password"),
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Please enter your password";
                                                      }
                                                      print(password.text);
                                                      print(confirmpassword.text);

                                                      if(password.text!=confirmpassword.text){
                                                        return "Password does not match";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                                ),
                                                SizedBox(height: 25.0),
                                                Container(
                                                  decoration: ThemeHelper().buttonBoxDecoration(context),
                                                  child: ElevatedButton(
                                                    style: ThemeHelper().buttonStyle(context),
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                                      child: Text(
                                                        "edit profile".toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                        Navigator.of(context).pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder: (context) => MainPage(text: widget.text)
                                                            ),
                                                                (Route<dynamic> route) => false
                                                        );
                                                        Users editedUser = await editUser(email.text, password.text, name.text, phoneNumber.text, snapshot.data![0]);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 30.0)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                        //return Text(snapshot.data![index].name!);
                      }
                  )
              );
            }
            else{
              return Center(child: CircularProgressIndicator(color: Colors.white));
            }
          }
      )
    );
  }

}