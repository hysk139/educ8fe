import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'package:flutter_login_ui/models/topic.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'add_todo_page.dart';
import 'topic_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Topic> fetchTopicSingular (int? subjectId, int? topicId) async{
  final topicResponse = await
  http.get(Uri.parse('https://teameduc8.herokuapp.com/api/topics/${subjectId}/${topicId}'));

  if (topicResponse.statusCode == 200) {
    return await Topic.fromJson(jsonDecode(topicResponse.body));
  } else {
    throw Exception('Failed to load topics');
  }

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
            ],
          ),
        ),
      )
    );
  }
}
