//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/helpers/Utils.dart';
import 'package:flutter_login_ui/helpers/color_preference.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'package:flutter_login_ui/models/subjects.dart';
import 'package:flutter_login_ui/models/todo.dart';
import 'package:flutter_login_ui/models/topic.dart';
import 'package:flutter_login_ui/pages/topic_page.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/src/painting/border_radius.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_page.dart';
import 'topic_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:developer';


List<Subjects> subjectPerUser =[];
Future<List<Subjects>> fetchSubjects(int? userId) async {
  final response = await http
      .get(Uri.parse('https://teameduc8.herokuapp.com/api/subjects/${userId}'));

  if (response.statusCode == 200) {
    subjectPerUser = await compute(parseSubjects, response.body);
    return subjectPerUser;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Subjects');
  }
}

List<Subjects> parseSubjects(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Subjects>((json) => Subjects.fromJson(json)).toList();
}

Future<List<Topic>> fetchTopic(List<Subjects> allSubjectsInUser) async{
  List<Topic> allTopic = [];
  for (int i = 0 ; i < allSubjectsInUser.length ; i++){
    var topicResponse = await
    http.get(Uri.parse('https://teameduc8.herokuapp.com/api/topics/${allSubjectsInUser[i].subject_id}'));

    if (topicResponse.statusCode == 200) {
      List<Topic> topicsFromSubject = await compute(parseTopic, topicResponse.body);
      allTopic.addAll(topicsFromSubject);
    } else {
      continue;
    }
  }
  return allTopic;
}

Future<List<Todo>> fetchAllTodo(int? userId) async {
  List<Todo> allTodo = [];
  List<Todo> todoFromTopics = [];
  List<Subjects> allSubjectsInUser = await fetchSubjects(userId);
  List<Topic> allTopic = await fetchTopic(allSubjectsInUser);
  for (Topic topic in allTopic) {

    final todoResponse = await
    http.get(Uri.parse('https://teameduc8.herokuapp.com/api/todo/${topic.topic_id}'));
    if (todoResponse.statusCode == 200) {
      List<Todo> todoFromTopics = await compute(parseTodo, todoResponse.body);
      allTodo.addAll(todoFromTopics);
    } else {
      continue;
    }
  }
  return allTodo;

}

Future<List<Todo>> fetchTodo(int topicId) async {
  final response = await
  http.get(Uri.parse('https://teameduc8.herokuapp.com/api/todo/${topicId}'));

  if (response.statusCode == 200) {
    return compute(parseTodo, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Todo');
  }
}

List<Todo> parseTodo(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Todo>((json) => Todo.fromJson(json)).toList();
}

List<Topic> parseTopic(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Topic>((json) => Topic.fromJson(json)).toList();
}

Future<Subjects> editSubjects(String name, Subjects currentSubject) async {
  if (name==''){
    name = currentSubject.name!;
  }


  final response = await http.put(
    Uri.parse('https://teameduc8.herokuapp.com/api/edit/update/subject/${currentSubject.subject_id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "name": name
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Subjects.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<Subjects> createSubjects(String subjectName, int userId) async {

  final response = await http.post(
    Uri.parse('https://teameduc8.herokuapp.com/api/subjects/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "name": subjectName,
      "user_id" : userId,
    }),
  );

  if (response.statusCode == 201) {
    return Subjects.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create subjects.');
  }
}

Future<List<Topic>> fetchTopicMain(int? subjectId) async{
  final topicResponse = await
  http.get(Uri.parse('https://teameduc8.herokuapp.com/api/topics/${subjectId}'));

  if (topicResponse.statusCode == 200) {
    return compute(parseTopic, topicResponse.body);
  } else {
    throw Exception('Failed to load Subjects');
  }

}


deleteSubjectById(int subjectId) async {
  final response = await
  http.delete(Uri.parse('https://teameduc8.herokuapp.com/api/edit/delete/subject/${subjectId}'));

  if (response.statusCode != 200) {
    throw Exception('Failed to delete subject');
  }
}

List<Topic> parseTopicMain(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Topic>((json) => Topic.fromJson(json)).toList();
}

deleteTodoById(int todoId) async {
  final response = await
  http.delete(Uri.parse('https://teameduc8.herokuapp.com/api/edit/delete/todo/${todoId}'));

  if (response.statusCode != 200) {
    throw Exception('Failed to delete subject');
  }
}
//======================

class MainPage extends StatefulWidget{
  final int? text;

  MainPage({Key? key, @required this.text}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // receive data from the FirstScreen as a parameter
  //MainPage({Key? key, @required this.text}) : super(key: key);
  //List<Subjects> subjects = Utils.getMockedSubjects();
  int tab = 0;

  showAlertDialogTodo(BuildContext context, String title, String type, String deadline, String Desc) {
    Widget info = Column(
      children: [
        Text("Title", textAlign: TextAlign.left,style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'montserrat')),
        Text(title, textAlign: TextAlign.left,style: TextStyle(fontSize: 17, color: Colors.black, fontFamily: 'montserrat')),
        Text(type, textAlign: TextAlign.left,style: TextStyle(fontSize: 17, color: Colors.black, fontFamily: 'montserrat')),
        Text(deadline, textAlign: TextAlign.left,style: TextStyle(fontSize: 17, color: Colors.black, fontFamily: 'montserrat')),
        Text (Desc, textAlign: TextAlign.left,style: TextStyle(fontSize: 17, color: Colors.black, fontFamily: 'montserrat')),
      ]
    );
    // set up the AlertDialog
    AlertDialog showInfo = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Informasi"),
      titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'montserrat'),
      actions: [
        info,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return showInfo;
      },
    );
  }

  showAlertDialogDeleteTodo(BuildContext context, Todo currentTodo) {
    TextEditingController customController = TextEditingController();


    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text('Done'),
      onPressed: () {
        deleteTodoById(currentTodo.todo_id!);
        Navigator.of(context)
            .pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    MainPage(text: widget.text,)
            ),
                (Route<dynamic> route) => false
        );
      },
    );
    // set up the AlertDialog
    AlertDialog deleteTodo = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Done With Task or Test?", textAlign: TextAlign.center),
      titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'montserrat'),
      actions: [
        submitButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return deleteTodo;
      },
    );
  }

  showAlertDialogDelete(BuildContext context, Subjects currentSubject) {
    TextEditingController customController = TextEditingController();


    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text('Delete'),
      onPressed: () {
        deleteSubjectById(currentSubject.subject_id!);
        Navigator.of(context)
            .pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    MainPage(text: widget.text,)
            ),
                (Route<dynamic> route) => false
        );
      },
    );
    // set up the AlertDialog
    AlertDialog deleteSubject = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Delete Subject?", textAlign: TextAlign.center),
      titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'montserrat'),
      actions: [
        submitButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return deleteSubject;
      },
    );
  }

  showAlertDialogEdit(BuildContext context, Subjects currentSubject) {
    TextEditingController customController = TextEditingController();

    Widget textField = TextField(
      style: TextStyle(fontSize: 14.0),
      controller: customController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Subject Name',
      ),
    );
    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text('Edit'),
      onPressed: () {
        editSubjects(customController.text, currentSubject);
        Navigator.of(context)
            .pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    MainPage(text: widget.text,)
            ),
                (Route<dynamic> route) => false
        );
      },
    );
    // set up the AlertDialog
    AlertDialog editsubject = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Edit Subject", textAlign: TextAlign.center),
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
        return editsubject;
      },
    );
  }

  showAlertDialogAddSubject(BuildContext context) {
    TextEditingController customController = TextEditingController();

    Widget textField = TextField(
      style: TextStyle(fontSize: 14.0),
      controller: customController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Subject Name',
      ),
    );
    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text('Add'),
      onPressed: () {
        createSubjects(customController.text, widget.text!);
        Navigator.of(context)
            .pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    MainPage(text: widget.text,)
            ),
                (Route<dynamic> route) => false
        );
      },
    );
    // set up the AlertDialog
    AlertDialog addsubject = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Add Subject", textAlign: TextAlign.center),
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
        return addsubject;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
      };
      if (states.any(interactiveStates.contains)) {
        return warna;
      }
      return warna;
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            foregroundColor: warna,
            elevation: 0,
            shadowColor: Colors.white,
            bottom: TabBar(
              indicatorPadding: EdgeInsets.fromLTRB(40, 7, 40, 7),
              unselectedLabelColor: warna,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  color: warna,
                  borderRadius: BorderRadius.circular(50)
              ),
              tabs: [
                Tab(
                    child:
                    Text("Subject")
                ),
                Tab(
                    child:
                    Text("To Do List")
                ),
              ],
            ),
            title: const Text('EDUC 8', style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal)),

            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.add_circle_outline_outlined),
                  tooltip: 'Add Subject',
                  onPressed: () {
                    showAlertDialogAddSubject(context);
                  }
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage(text: widget.text)));
                },
              ),
            ],

          ),

          body: TabBarView(
            children:  [
              Expanded(
                  child:
              FutureBuilder<List<Subjects>>(
                future : fetchSubjects(widget.text),
                builder: (context, snapshot){

                  if (snapshot.hasData) {
                    return Container(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                            child: StaggeredGridView.countBuilder(
                                itemCount: snapshot.data!.length,
                                  crossAxisCount: 4,
                                  itemBuilder: (BuildContext context, int index) => new Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: warna,
                                      ),
                                      child: SingleChildScrollView(
                                          child: Column(
                                            children:
                                            [
                                              GestureDetector(
                                                  onTap: (){
                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TopicPage(text: snapshot.data![index].subject_id!,
                                                        text2: widget.text, sub: snapshot.data![index].name!)));
                                                  }),
                                              Row(
                                                  children :[
                                                    Expanded(
                                                      flex: 4,
                                                        child: Text(snapshot.data![index].name!,
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.normal),
                                                        ),
                                                    ),

                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        iconSize: 17,
                                                        color: Colors.white,
                                                        icon: const Icon(Icons.edit_outlined),
                                                        tooltip: 'Edit',
                                                        onPressed: () {
                                                          showAlertDialogEdit(context, snapshot.data![index]);
                                                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                                                        },
                                                      ),
                                                    ),

                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        iconSize: 17,
                                                        color: Colors.white,
                                                        icon: const Icon(Icons
                                                            .delete_outline_rounded),
                                                        tooltip: 'Delete',
                                                        onPressed: () {
                                                          showAlertDialogDelete(context, snapshot.data![index]);

                                                        },
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              /*FutureBuilder<List<Topic>>(
                                                  future : fetchTopicMain(),
                                                  builder: (context, snapshot){

                                                    if (snapshot.hasData) {
                                                      return Container(
                                                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                          child: ListView.builder(
                                                              itemCount: snapshot.data!.length,
                                                              scrollDirection: Axis.vertical,
                                                              itemBuilder: (BuildContext context, int index) {
                                                                return Container(
                                                                  child: Text(
                                                                  snapshot.data![index].topic_name!,
                                                                  textAlign: TextAlign.left,
                                                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.white),
                                                                ),
                                                                );
                                                              }
                                                          )
                                                      );
                                                    }
                                                    else{
                                                      return Center(child: CircularProgressIndicator(color: warna));
                                                    }
                                                  }
                                              ),*/
                                              /*Divider(
                                                  color: Colors.white,
                                                  //height: 25,
                                                  thickness: 3,
                                                  indent: 5,
                                                  endIndent: 5,
                                                ),*/
                                              ],
                                          )
                                      ),
                                  ),
                                  staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.count(2, index.isEven ? 3 : 2),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                    );
                  }

                  else{
                    return Center(child: CircularProgressIndicator(color: warna));
                  }
                }
              )
              ),
              Expanded(child:
              FutureBuilder<List<Todo>>(
                  future : fetchAllTodo(widget.text),
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(15,10,10,10),
                        child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {

                                return Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 6,
                                                child: Text(snapshot.data![index].title!,
                                                    style: TextStyle(color: Colors.black)),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                icon: const Icon(Icons.check_outlined),
                                                tooltip: 'Done',
                                                onPressed: () {
                                                  showAlertDialogDeleteTodo(context, snapshot.data![index]);

                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                icon: const Icon(Icons.info_outline_rounded ),
                                                tooltip: 'Info',
                                                onPressed: () {
                                                  showAlertDialogTodo(
                                                      context,
                                                      snapshot.data![index].title!,
                                                      snapshot.data![index].type!,
                                                      snapshot.data![index].deadline!,
                                                      snapshot.data![index].description!);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    );


                                  /*CheckboxListTile(
                                  title: Text(snapshot.data![index].title!),
                                  secondary: const Icon(Icons.code),
                                  autofocus: false,
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  selected: _value,
                                  value: _value, onChanged: (bool? value) {  },

                                );

                                Container(
                                  margin: EdgeInsets.all(5),
                                  height: 130,
                                  child: Stack(
                                      children: [
                                        Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(

                                              height : 120,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      bottomLeft: Radius.circular(20),
                                                      bottomRight: Radius.circular(20),
                                                      topRight: Radius.circular(20),
                                                      topLeft: Radius.circular(20)
                                                  ),
                                                  gradient: LinearGradient(
                                                      begin: Alignment.bottomCenter,
                                                      end : Alignment.topCenter,
                                                      colors: [
                                                        Colors.purpleAccent.withOpacity(0.8),
                                                        Colors.purple.withOpacity(0.8)
                                                      ]
                                                  )
                                              ),
                                            )
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Text(snapshot.data![index].title!,
                                                    style: TextStyle(color: Colors.white, fontSize: 25))
                                              ],
                                            ),
                                          ),
                                        )

                                      ]
                                  ),
                                );*/

                              }
                          )
                      );
                    }
                    else{
                      return Center(child: CircularProgressIndicator(color: warna));
                    }
                  }
              )
              ),

            ],


          ),

        ),

      ),
    );
  }
}