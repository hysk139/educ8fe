import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'add_todo_page.dart';
import 'topic_page.dart';
import 'package:flutter/material.dart';

class materialPage extends StatefulWidget{
  const materialPage({Key? key}): super(key:key);

  @override
  _materialPageState createState() => _materialPageState();
}

class _materialPageState extends State<materialPage>{

  static const IconData arrow_back_ios_rounded = IconData(0xf571, fontFamily: 'MaterialIcons', matchTextDirection: true);

  showAlertDialogAddVideo(BuildContext context) {
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

  showAlertDialogAddNote(BuildContext context) {
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
      onPressed: () {

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

  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'iAgg5C-BN1s',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    )
  );

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
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TopicPage()));
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
                    'Software Architecture',
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
                          showAlertDialogAddNote(context);
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
              Text("Ini adalah contoh notes sjdxjsbidxsaihdxiasuhdihasniukcsuaidbiueda", style: TextStyle(color: Colors.white, fontSize: 16)
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
                          showAlertDialogAddVideo(context);
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
                    controller: _controller,
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddTodoPage()));
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
