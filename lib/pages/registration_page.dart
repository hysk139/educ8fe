
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/pages/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'profile_page.dart';
import 'login_page.dart';

class RegistrationPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{
  double _headerHeight = 55;
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
            ),
            SafeArea(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(20,0,5,10),
                    child:
                    Text(
                      'REGISTER',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
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
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration('Your Name'),
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
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration("@mail.com"),
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
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Phone Number"),
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
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
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
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
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
                              SizedBox(height: 15.0),

                              FormField<bool>(
                                builder: (state) {
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: checkboxValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  checkboxValue = value!;
                                                  state.didChange(value);
                                                });
                                              }),
                                          Text("I accept all terms and conditions.", style: TextStyle(color: Colors.grey),),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.errorText ?? '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Theme.of(context).errorColor,fontSize: 12,),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                validator: (value) {
                                  if (!checkboxValue) {
                                    return 'You need to accept terms and conditions';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 15.0),

                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(context),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      "Register".toUpperCase(),
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
                                              builder: (context) => LoginPage()
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
     ),
    );
  }

}