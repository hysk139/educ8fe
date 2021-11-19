import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/src/painting/border_radius.dart';
import 'profile_page.dart';
import 'topic_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ],

          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}