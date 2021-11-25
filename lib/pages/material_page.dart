import 'package:flutter/material.dart';
import 'topic_page.dart';

class materialPage extends StatelessWidget {
  const materialPage({Key? key}) : super(key: key);
  static const IconData arrow_back_ios_rounded = IconData(0xf571, fontFamily: 'MaterialIcons', matchTextDirection: true);
  createAlertDialog(BuildContext context){

    TextEditingController customController = TextEditingController();

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: Text("Insert Video Link", textAlign: TextAlign.center),
        titleTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'montserrat'),

        content: TextField(
          style: TextStyle(fontSize: 14.0),
          controller: customController,
          decoration: InputDecoration(
            //border: InputBorder.none,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            hintText: 'Subject Name',
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Submit'),
            onPressed: (){
              //masukin ke back end
              Navigator.of(context).pop(customController.text.toString());
            },
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () {
            //tambahin back kemana
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TopicPage()));
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
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Note',
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                ),
              ),
            ),
            Container(
              height: 2.0,
              width: 400.0,
              color: Theme.of(context).primaryColor,
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Description',
                hintStyle: TextStyle(fontSize: 16)
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          createAlertDialog(context);
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
