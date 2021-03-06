
import 'dart:async';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'package:flutter_login_ui/models/todo.dart';
import 'package:flutter_login_ui/models/topic.dart';
import 'package:flutter_login_ui/models/users.dart';
import 'package:flutter_login_ui/pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'material_page.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';



Future<Todo> createTodo(String title, String description, String deadline, String type, int topicId) async {

  final response = await http.post(
    Uri.parse('https://teameduc8.herokuapp.com/api/todo/add/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "title": title,
      "description" : description,
      "deadline" : deadline,
      "type" : type,
      "topic_id" : topicId,
    }),
  );

  if (response.statusCode == 201) {
    return Todo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create subjects.');
  }
}

class AddTodoPage extends  StatefulWidget{
  final int? text, text2;
  final String? sub;
  final Topic? top;

  AddTodoPage({Key? key, @required this.text, required this.text2, required this.sub, required this.top}) : super(key: key);

  @override
  _AddTodoPage createState() => _AddTodoPage();
}

class _AddTodoPage extends State<AddTodoPage>{
  showAlertDialogPickedDateTime(BuildContext context, String dateTime) {
    Widget doneButton = MaterialButton(
      elevation: 5.0,
      child: Text('OK', style: TextStyle(color: warna)),
      onPressed: ()  {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog doneDateTime = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Date Time Picked : " + dateTime, textAlign: TextAlign.center),
      titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'montserrat'),
      actions: [
        doneButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return doneDateTime;
      },
    );
  }

  double _headerHeight = 10;
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleTodo = TextEditingController();
  TextEditingController descTodo = TextEditingController();
  TextEditingController deadline = TextEditingController();
  String _value = "TEST";
  String dateTimePicked = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFF252834),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFF252834),
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Color(0xFF252834),
        title: Text(
            "Add To Do",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
        ),
        leading: IconButton(
          onPressed: () {
            //tambahin back kemana
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>
                    materialPage(text: widget.text,
                      text2: widget.text2,
                      sub: widget.sub,
                      top: widget.top,)));
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
                          style: TextStyle(fontSize: 15, color: Colors.white),
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
                          style: TextStyle(fontSize: 15, color: Colors.white),
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
                        TextButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2018, 3, 5),
                                  maxTime: DateTime(2030, 12, 31), onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                    dateTimePicked = date.toString();
                                    showAlertDialogPickedDateTime(context, dateTimePicked);
                                  }, locale: LocaleType.en);
                            },
                            child: Text(
                              'Pick the date and time : ' + dateTimePicked,
                              style: TextStyle(color: Colors.blue),
                            ))
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(3,0,5,10),
                        child:
                        Text(
                          'Type',
                          style: TextStyle(fontSize: 15, color: Colors.white),
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
                                value: "TEST",
                              ),
                              DropdownMenuItem(
                                child: Text("TASK"),
                                value: "TASK",
                              ),
                            ],
                            onChanged: (String? value) {
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
                              createTodo(titleTodo.text, descTodo.text, dateTimePicked, _value, widget.top!.topic_id!);
                                if (_formKey.currentState!.validate()) {
                                  Navigator.of(context)
                                      .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              materialPage(text: widget.text,
                                                  text2: widget.text2,
                                                  sub: widget.sub,
                                                  top: widget.top)
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