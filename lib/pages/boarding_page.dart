import 'package:flutter/material.dart';
import 'package:flutter_login_ui/helpers/preference.dart';
import 'package:flutter_login_ui/helpers/globals.dart';
import 'login_page.dart';
import 'material_page.dart';
import 'topic_page.dart';
import 'boarding_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'package:google_fonts/google_fonts.dart';

class boardingPage extends StatefulWidget {
  @override
  _boardingPageState createState() => _boardingPageState();
}

class _boardingPageState extends State<boardingPage> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/img-1.png',
      text: "Organize your tasks easily",
      desc:
      "With EDUC8 you can add elements and tags to find and complete your tasks efficiently",
      bg: Color(0xFF243A7A),
      button: Colors.white,
    ),
    OnboardModel(
      img: 'assets/images/img-2.png',
      text: "Complete your life goal",
      desc:
      "To-do-list feature in EDUC8 helps you to achive your goals, showing your progress and the sub-goals.",
      bg: Colors.white,
      button: Color(0xFF246BFD),
    ),
    OnboardModel(
      img: 'assets/images/img-3.png',
      text: "Show your achievements",
      desc:
      "You should be proud of the goals you have completed. Thats’s can take a look at them to your friends",
      bg: Color(0xFF243A7A),
      button: Colors.white,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /*_storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0 ? knavy: kwhite,
      appBar: AppBar(
        backgroundColor: currentIndex % 2 == 0 ? knavy : kwhite,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              Preference.setIsViewed(1);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: currentIndex % 2 == 0 ? kwhite : warna,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(screens[index].img),
                  Container(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 25 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? kpink
                                      : kyellow,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: index % 2 == 0 ? kwhite : warna,
                    ),
                  ),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Montserrat',
                      color: index % 2 == 0 ? kwhite : warna,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      print(index);
                      if (index == screens.length - 1) {
                        await Preference.setIsViewed(1);;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      }

                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                      );
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: index % 2 == 0 ? kwhite : warna,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: index % 2 == 0 ? warna : kwhite),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: index % 2 == 0 ? warna : kwhite,
                        )
                      ]),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

    