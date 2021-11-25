import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/models/users.dart';
import 'package:http/http.dart' as http;
import 'main_page.dart';
import 'edit_profile.dart';

Future<List<Users>> fetchUsers(int? userId) async {
  final response = await http
      .get(Uri.parse('https://teameduc8.herokuapp.com/api/users/${userId}'));

  if (response.statusCode == 200) {
    return compute(parseUsers, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Subjects');
  }
}

List<Users> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Users>((json) => Users.fromJson(json)).toList();
}

class ProfilePage extends StatefulWidget{
  final int? text;

  ProfilePage({Key? key, @required this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{
  double _headerHeight = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            //tambahin back kemana
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(text: widget.text)));
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        flexibleSpace:Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),

        actions: [
          Container(
            child: IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Edit Profile',
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfilePage(text: widget.text)));
                }
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Users>>(
          future : fetchUsers(widget.text),
          builder: (context, snapshot){

            if (snapshot.hasData) {
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                          child: Stack(
                            children: [
                              Container(
                                height: _headerHeight,
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                                        color: Colors.white,
                                      ),
                                      child: Icon(Icons.person, size: 80, color: Theme.of(context).primaryColor),
                                    ),
                                    SizedBox(height: 20, width: 20,),
                                    Container(
                                        padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Text(snapshot.data![index].name!, style: TextStyle(fontSize: 20, color: Colors.white))
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                                                borderRadius: BorderRadius.circular(10)),
                                            child: ListTile(
                                              title: Text("Email"),
                                              subtitle: Text(snapshot.data![index].email!),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                                                borderRadius: BorderRadius.circular(10)),
                                            child: ListTile(
                                              title: Text("Phone"),
                                              subtitle: Text(snapshot.data![index].phone_number!),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                        //return Text(snapshot.data![index].name!);
                      }
                  )
              );
            }
            else{
              return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
            }
          }
      )
    );
      /*SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: _headerHeight,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                      color: Colors.white,
                    ),
                    child: Icon(Icons.person, size: 80, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: 20, width: 20,),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text('Tedi Setiawan', style: TextStyle(fontSize: 20, color: Colors.white))
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text("Email"),
                            subtitle: Text("donaldtrump@gmail.com"),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text("Phone"),
                            subtitle: Text("99--99876-56"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );*/
  }

}