
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
import 'material_page.dart';
import 'profile_page.dart';
import 'login_page.dart';

class AddTodoPage extends  StatefulWidget{
  const AddTodoPage({Key? key}): super(key:key);

  @override
  _AddTodoPage createState() => _AddTodoPage();
}

class _AddTodoPage extends State<AddTodoPage>{
  double _headerHeight = 10;
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleTodo = TextEditingController();
  TextEditingController descTodo = TextEditingController();
  TextEditingController deadline = TextEditingController();
  int _value = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        foregroundColor: warna,
        elevation: 0,
        shadowColor: Colors.white,
        title: Text(
            "Add To Do",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
        ),
        leading: IconButton(
          onPressed: () {
            //tambahin back kemana
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => materialPage()));
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),

        body: SingleChildScrollView(
          child: Container(
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
                          'Title',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: titleTodo,
                          decoration: ThemeHelper().textInputDecoration("Insert Todo"),
                          validator: (val) {
                            if(val!.isEmpty){
                              return "Title Cannot Empty";
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
                          'Description',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: descTodo,
                          decoration: ThemeHelper().textInputDecoration("Insert Description"),
                          validator: (val) {
                            if(val!.isEmpty){
                              return "Description Cannot Empty";
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
                          'Deadline',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: deadline,
                          decoration: ThemeHelper().textInputDecoration("Insert The Deadline"),
                          validator: (val) {
                            if(val!.isEmpty){
                              return "Deadline Cannot Empty";
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
                          'Type',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: ThemeHelper().dropDecoration(),
                        child: DropdownButton(
                            isExpanded: true,
                            value: _value,
                            items: [
                              DropdownMenuItem(
                                child: Text("TEST"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("TASK"),
                                value: 2,
                              ),
                            ],
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                              });
                            }
                            ),
                      ),

                      SizedBox(height: 25.0),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(context),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              "add to do".toUpperCase(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                            onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.of(context)
                                      .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              materialPage()
                                      ),
                                          (Route<dynamic> route) => false
                                  );
                              };
                            }
                        ),
                      ),
                      SizedBox(height: 30.0)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

}