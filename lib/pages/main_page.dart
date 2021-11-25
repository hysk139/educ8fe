//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/helpers/Utils.dart';
import 'package:flutter_login_ui/models/subjects.dart';
import 'package:flutter_login_ui/models/todo.dart';
import 'package:flutter_login_ui/pages/topic_page.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/src/painting/border_radius.dart';
import 'profile_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Future<List<Subjects>> fetchSubjects(int? userId) async {
  final response = await http
      .get(Uri.parse('https://teameduc8.herokuapp.com/api/subjects/${userId}'));

  if (response.statusCode == 200) {
    return compute(parseSubjects, response.body);
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

Future<List<Todo>> fetchTodo() async {
  final response = await
    http.get(Uri.parse('https://teameduc8.herokuapp.com/api/todo'));

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

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
      };
      if (states.any(interactiveStates.contains)) {
        return Theme.of(context).primaryColor;
      }
      return Theme.of(context).primaryColor;
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            shadowColor: Colors.white,
            bottom: TabBar(
              indicatorPadding: EdgeInsets.fromLTRB(40, 7, 40, 7),
              unselectedLabelColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TopicPage()));
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
              Expanded(child:
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
                                color: Colors.purple,
                              ),
                              child: Column(
                                children:
                                [
                                  Text(snapshot.data![index].name!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.normal),
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    height: 25,
                                    thickness: 3,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                ],
                              )
                              ),

                          staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(2, index.isEven ? 3 : 2),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        )

                      /*ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
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
                                            Text(snapshot.data![index].name!,
                                                style: TextStyle(color: Colors.white, fontSize: 25))
                                          ],
                                        ),
                                      ),
                                    )
                                  ]
                                ),
                              );
                              //return Text(snapshot.data![index].name!);
                            }
                        )*/
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
                  }
                }
              )
              ),
              Expanded(child:
              FutureBuilder<List<Todo>>(
                  future : fetchTodo(),
                  builder: (context, snapshot){

                    if (snapshot.hasData) {
                      return Container(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {

                                return Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty.resolveWith(getColor),
                                              value: isChecked,
                                              onChanged: (bool? value) {
                                                setState((){
                                                  isChecked = value!;
                                                });
                                              },
                                            ),
                                            Text(snapshot.data![index].title!,
                                                style: TextStyle(color: Colors.black)),
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
                      return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
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