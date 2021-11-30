import 'package:flutter/material.dart';
import 'package:flutter/src/painting/border_radius.dart';
import 'main_page.dart';
import 'material_page.dart';

class TopicPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TopicPage();
  }
}

class _TopicPage extends State<TopicPage> {
  double _headerHeight = 10;
  Color warna = Colors.purple;
  final List<String> topics = <String>['A', 'B', 'C'];
  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: Text("Edit Topic", textAlign: TextAlign.center),
        titleTextStyle: TextStyle(
            fontSize: 20.0, color: Colors.black, fontFamily: 'montserrat'),

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
            onPressed: () {
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
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            foregroundColor: warna,
            elevation: 0,
            shadowColor: Colors.white,
            title: const Text(
                'RPL',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal)
            ),
            leading: IconButton(
              onPressed: () {
                //tambahin back kemana
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
              },
              icon: Icon(Icons.arrow_back_ios_rounded),
            ),
            actions: [Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: IconButton(
                    icon: const Icon(Icons.add_circle_outline_outlined),
                    tooltip: 'Add Topic',
                    onPressed: () {
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                    }
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: _headerHeight,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(20,0,5,10),
                  child:
                  Text(
                    'RPL',
                    style: TextStyle(fontSize: 30, color: warna, fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => materialPage()));
                        },
                        child: Card(
                          color: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 20,),
                              const Expanded(
                                flex: 6,
                                child: Text(
                                    'UML Design',
                                    textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.edit_outlined),
                                  tooltip: 'Edit',
                                  onPressed: () {
                                    createAlertDialog(context);
                                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded),
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
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => materialPage()));
                        },
                        child: Card(
                            color: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  const Expanded(
                                    flex: 6,
                                    child: Text(
                                      'Software Architecture',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(Icons.edit_outlined),
                                      tooltip: 'Edit',
                                      onPressed: () {
                                        createAlertDialog(context);
                                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete_outline_rounded),
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
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => materialPage()));
                        },
                        child: Card(
                            color: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  const Expanded(
                                    flex: 6,
                                    child: Text(
                                      'Software Process',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(Icons.edit_outlined),
                                      tooltip: 'Edit',
                                      onPressed: () {
                                        createAlertDialog(context);
                                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete_outline_rounded),
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
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => materialPage()));
                        },
                        child: Card(
                            color: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  const Expanded(
                                    flex: 6,
                                    child: Text(
                                      'Software Implementation',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(Icons.edit_outlined),
                                      tooltip: 'Edit',
                                      onPressed: () {
                                        createAlertDialog(context);
                                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete_outline_rounded),
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