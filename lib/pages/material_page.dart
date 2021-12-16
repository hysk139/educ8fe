import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'package:flutter_login_ui/models/todo.dart';
import 'package:flutter_login_ui/models/topic.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'add_todo_page.dart';
import 'topic_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<List<Todo>> fetchTodoPerTopic (int? topicId) async{
  final todoResponse = await
  http.get(Uri.parse('https://teameduc8.herokuapp.com/api/todo/${topicId}'));

  if (todoResponse.statusCode == 200) {
    return compute(parseTodo, todoResponse.body);
  } else {
    throw Exception('Failed to load topics');
  }

}

List<Todo> parseTodo(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Todo>((json) => Todo.fromJson(json)).toList();
}

Future<Topic> editTopicVideo(String video, Topic currentTopic) async {
  if (video==''){
    video = currentTopic.video!;
  }
  final response = await http.put(
    Uri.parse('https://teameduc8.herokuapp.com/api/edit/update/topics/video/${currentTopic.topic_id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "video": video
    }),
  );
  if (response.statusCode == 201) {
    return Topic.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to edit topic.');
  }
}

Future<Topic> editTopicMaterials(String materials, Topic currentTopic) async {
  if (materials==''){
    materials = currentTopic.materials!;
  }


  final response = await http.put(
    Uri.parse('https://teameduc8.herokuapp.com/api/edit/update/topics/material/${currentTopic.topic_id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "materials": materials
    }),
  );

  if (response.statusCode == 201) {
    Topic topicResponse = Topic.fromJson(jsonDecode(response.body));
    return topicResponse;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to edit topic.');
  }
}

class materialPage extends StatefulWidget{
  final int? text, text2;
  final String? sub;
  final Topic? top;

  materialPage({Key? key, @required this.text, required this.text2, required this.sub, required this.top}) : super(key: key);

  @override
  _materialPageState createState() => _materialPageState();
}

class _materialPageState extends State<materialPage>{

  YoutubePlayerController? _controller;

  @override
  void initState(){
    /*_controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=FEgH3UbjffA")!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );*/

    if (widget.top!.video == "" || widget.top!.video == null){
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=FEgH3UbjffA")!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
    else{
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.top!.video!)!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }

  }





  static const IconData arrow_back_ios_rounded = IconData(0xf571, fontFamily: 'MaterialIcons', matchTextDirection: true);

  showAlertDialogAddVideo(BuildContext context, Topic currentTopic) {
    TextEditingController customController = TextEditingController();

    Widget textField = TextField(
      style: TextStyle(fontSize: 14.0),
      controller: customController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Video Link',
      ),
    );
    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text('Insert', style: TextStyle(color: warna)),
      onPressed: () {
        editTopicVideo(customController.text, currentTopic);
      },
    );
    // set up the AlertDialog
    AlertDialog addvideo = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Insert Video Link", textAlign: TextAlign.center),
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
        return addvideo;
      },
    );
  }

  showAlertDialogAddNote(BuildContext context, Topic currentTopic) {
    TextEditingController customController = TextEditingController();

    Widget textField = TextField(
      style: TextStyle(fontSize: 14.0),
      controller: customController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Enter your notes',
      ),
    );
    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text('Edit', style: TextStyle(color: warna),),
      onPressed: () async {
          Topic newTopic = await editTopicMaterials(customController.text, currentTopic);
          showAlertDialogDoneEdit(context, newTopic);
              /*Navigator.of(context)
              .pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      materialPage(text: widget.text,
                          text2: widget.text2,
                          sub: widget.sub,
                          top: widget.top)
              ),
                  (Route<dynamic> route) => false
          );*/
      },
    );
    // set up the AlertDialog
    AlertDialog addnote = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Edit Notes", textAlign: TextAlign.center),
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
        return addnote;
      },
    );
  }

  showAlertDialogDoneEdit(BuildContext context, Topic newTopic) {
    TextEditingController customController = TextEditingController();

    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text('Done', style: TextStyle(color: warna),),
      onPressed: () {
        Navigator.of(context)
              .pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      materialPage(text: widget.text,
                          text2: widget.text2,
                          sub: widget.sub,
                          top: newTopic)
              ),
                  (Route<dynamic> route) => false
          );
      },
    );
    // set up the AlertDialog
    AlertDialog addnote = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Materials Edited", textAlign: TextAlign.center),
      titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'montserrat'),
      actions: [
        submitButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return addnote;
      },
    );
  }
  showAlertDialogTodo(BuildContext context, String title, String type, String deadline, String Desc) {
    Widget info = Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: warna, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text("Title", style: TextStyle(color: Colors.black, fontFamily: 'montserrat')),
              subtitle: Text(title, style: TextStyle(color: Colors.black, fontFamily: 'montserrat')),
              //tileColor: Color(0xFF383751),
            ),
          ),
          SizedBox(height: 10,),
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: warna, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text("Type", style: TextStyle(color: Colors.black, fontFamily: 'montserrat')),
              subtitle: Text(type, style: TextStyle(color: Colors.black, fontFamily: 'montserrat')),
              //tileColor: Color(0xFF383751),
            ),
          ),
          SizedBox(height: 10,),
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: warna, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text("Deadline", style: TextStyle(color: Colors.black, fontFamily: 'montserrat')),
              subtitle: Text(deadline, style: TextStyle(color: Colors.black, fontFamily: 'montserrat')),
              //tileColor: Color(0xFF383751),
            ),
          ),
          SizedBox(height: 10,),
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: warna, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text("Description", style: TextStyle(color: Colors.black, fontFamily: 'montserrat')),
              subtitle: Text(Desc, style: TextStyle(color: Colors.black, fontFamily: 'montserrat')),
              //tileColor: Color(0xFF383751),
            ),
          ),
          SizedBox(height: 10,),
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF252834),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFF252834),
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            //tambahin back kemana
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>
                    TopicPage(text: widget.text,
                      text2: widget.text2,
                    sub: widget.sub,
                    )));
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0
          ),
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.top!.topic_name!,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
              ),
              Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Note',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        alignment: Alignment.bottomCenter,
                        icon: const Icon(
                            Icons.edit_outlined, size: 20,color: Colors.white),
                        tooltip: 'Edit',
                        onPressed: () {
                          showAlertDialogAddNote(context, widget.top!);
                        },
                      ),
                    ),
                  ]
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                height: 2.0,
                width: 400.0,
                color: warna,
              ),
              Text((widget.top!.materials == null || widget.top!.materials == "") ? "-" : widget.top!.materials!,
                  style: TextStyle(color: Colors.white, fontSize: 16)
              ),
              Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Video',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        alignment: Alignment.bottomCenter,
                        icon: const Icon(
                            Icons.edit_outlined, size: 20,color: Colors.white),
                        tooltip: 'Edit',
                        onPressed: () {
                          showAlertDialogAddVideo(context, widget.top!);
                        },
                      ),
                    ),
                  ]
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                height: 2.0,
                width: 400.0,
                color: warna,
              ),
              YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: warna,
                    progressColors: ProgressBarColors(
                      playedColor: warna,
                      handleColor: warna,
                    ),
                  ),
                  builder: (context, player){
                    return Column(
                      children: [
                        // some widgets
                        player,
                        //some other widgets
                      ],
                    );
                  }
              ),
              Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'To Do',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        alignment: Alignment.bottomCenter,
                        icon: const Icon(
                            Icons.add_circle_outline_outlined, size: 20, color: Colors.white),
                        tooltip: 'Edit',
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>
                                  AddTodoPage(text: widget.text,
                                    text2: widget.text2,
                                    sub: widget.sub,
                                    top: widget.top,)));
                        },
                      ),
                    ),
                  ]
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                height: 2.0,
                width: 400.0,
                color: warna,
              ),
              FutureBuilder<List<Todo>>(
                  future : fetchTodoPerTopic(widget.top!.topic_id!),
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      print(snapshot.data);
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
                                              style: TextStyle(color: Colors.white)),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            icon: const Icon(Icons.check_outlined),
                                            tooltip: 'Done',
                                            color: Colors.white,
                                            onPressed: () {
                                              //showAlertDialogDeleteTodo(context, snapshot.data![index]);

                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            icon: const Icon(Icons.info_outline_rounded ),
                                            tooltip: 'Info',
                                            color: Colors.white,
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
                              }
                          )
                      );
                    }
                    else{
                      return Center(child: CircularProgressIndicator(color: Colors.white));
                    }
                  }
              )
            ],
          ),
        ),
      )
    );
  }
}
