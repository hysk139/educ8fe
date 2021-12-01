import 'package:flutter/material.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'add_todo_page.dart';
import 'topic_page.dart';

class materialPage extends StatelessWidget {
  const materialPage({Key? key}) : super(key: key);

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
      child: Text('Insert'),
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
      child: Text('Edit'),
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: warna,
        leading: IconButton(
          onPressed: () {
            //tambahin back kemana
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TopicPage()));
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Padding(
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
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
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
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      alignment: Alignment.bottomCenter,
                      icon: const Icon(
                          Icons.edit_outlined, size: 20,),
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
            Text("Ini adalah contoh notes sjdxjsbidxsaihdxiasuhdihasniukcsuaidbiueda", style: TextStyle(fontSize: 16)
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
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      alignment: Alignment.bottomCenter,
                      icon: const Icon(
                        Icons.edit_outlined, size: 20,),
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
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      alignment: Alignment.bottomCenter,
                      icon: const Icon(
                        Icons.add_circle_outline_outlined, size: 20,),
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
    );
  }
}
