import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/border_radius.dart';
import 'package:flutter_login_ui/models/topic.dart';
import 'main_page.dart';
import 'material_page.dart';
import 'package:flutter_login_ui/models/subjects.dart';
import 'package:http/http.dart' as http;

Future<List<Topic>> fetchTopicInSubject(int? subjectId) async{
    final topicResponse = await
    http.get(Uri.parse('https://teameduc8.herokuapp.com/api/topics/${subjectId}'));

    if (topicResponse.statusCode == 200) {
      return compute(parseTopic, topicResponse.body);
    } else {
      throw Exception('Failed to load Subjects');
    }

}

List<Topic> parseTopic(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Topic>((json) => Topic.fromJson(json)).toList();
}

class TopicPage extends  StatefulWidget{
  final int? text, text2;
  final String? sub;

  TopicPage({Key? key, @required this.text, @required this.text2, required this.sub}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TopicPage();
  }
}

class _TopicPage extends State<TopicPage> {
  double _headerHeight = 10;
  Color warna = Colors.purple;

  showAlertDialogAdd(BuildContext context) {
    TextEditingController customController = TextEditingController();

    Widget textField = TextField(
      style: TextStyle(fontSize: 14.0),
      controller: customController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Topic Name',
      ),
    );
    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text('Add'),
      onPressed: () {

      },
    );
    // set up the AlertDialog
    AlertDialog editTopic = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Add Topic", textAlign: TextAlign.center),
      titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'montserrat'),
      actions: [
        textField,
        submitButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return editTopic;
      },
    );
  }

  showAlertDialogEdit(BuildContext context) {
    TextEditingController customController = TextEditingController();

    Widget textField = TextField(
      style: TextStyle(fontSize: 14.0),
      controller: customController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Topic Name',
      ),
    );
    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text('Edit'),
      onPressed: () {

      },
    );
    // set up the AlertDialog
    AlertDialog editTopic = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Edit Topic", textAlign: TextAlign.center),
      titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'montserrat'),
      actions: [
        textField,
        submitButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return editTopic;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            foregroundColor: warna,
            elevation: 0,
            shadowColor: Colors.white,
            title: Text(
                widget.sub!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
            ),
            leading: IconButton(
              onPressed: () {
                //tambahin back kemana
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(text: widget.text2)));
              },
              icon: Icon(Icons.arrow_back_ios_rounded),
            ),
            actions: [Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: IconButton(
                    icon: const Icon(Icons.add_circle_outline_outlined),
                    tooltip: 'Add Topic',
                    onPressed: () {
                      showAlertDialogAdd(context);
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                    }
                ),
              )
            ],
          ),
          body: FutureBuilder<List<Topic>>(
                    future : fetchTopicInSubject(widget.text),
                    builder: (context, snapshot){

                      if (snapshot.hasData) {
                        return Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: <Widget>[
                                      GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    materialPage()));
                                      },
                                      child: Card(
                                          color: Colors.grey.shade300,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  15)
                                          ),
                                          child: Row(
                                              children: [
                                                SizedBox(width: 20,),
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    snapshot.data![index].topic_name!,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontSize: 17,
                                                        fontWeight: FontWeight
                                                            .normal),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: const Icon(
                                                        Icons.edit_outlined),
                                                    tooltip: 'Edit',
                                                    onPressed: () {
                                                      showAlertDialogEdit(context);
                                                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: const Icon(Icons
                                                        .delete_outline_rounded),
                                                    tooltip: 'Delete',
                                                    onPressed: () {
                                                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                                                    },
                                                  ),
                                                )
                                              ]
                                          )
                                      ),
                                      ),
                                      SizedBox(height: 10.0),
                                    ],
                                  );
                                }
                            )
                        );
                      }
                      else{
                        return Center(child: CircularProgressIndicator(color: warna));
                      }
                    }
                ),
            ),
          );
  }
}