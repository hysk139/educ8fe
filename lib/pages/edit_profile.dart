
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/models/users.dart';
import 'package:http/http.dart' as http;
import 'profile_page.dart';
import 'login_page.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
        elevation: 0,
          leading: IconButton(
            onPressed: () {
              //tambahin back kemana
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage(text: widget.text)));
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          flexibleSpace:Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(20,0,5,10),
                                child:
                                Text(
                                  'Hi, ' + snapshot.data![index].name!,
                                  style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
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
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  child: TextFormField(
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
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  child: TextFormField(
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
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  child: TextFormField(
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
                                                    style: TextStyle(fontSize: 15),
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
                                                    style: TextStyle(fontSize: 15),
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
                                                    onPressed: () {
                                                      if (_formKey.currentState!.validate()) {
                                                        Navigator.of(context).pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder: (context) => ProfilePage(text: widget.text)
                                                            ),
                                                                (Route<dynamic> route) => false
                                                        );
                                                      }
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
              return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
            }
          }
      )
    );
  }

}