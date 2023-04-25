import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:CapybaApp/Screens/home_display_screen.dart';
import 'package:CapybaApp/Screens/profile_screen.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  int currentIndex = 0;
  final pageController = PageController(initialPage: 0);

  final tabBarICons = [FontAwesomeIcons.house, FontAwesomeIcons.user];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: const [
                  HomeDisplayScreen(),
                  ProfileScreen(),
                ],
              ),
              // creates a personalized bottom bar
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...tabBarICons.asMap().entries.map((entry) => IconButton(
                          onPressed: () {
                            pageController.jumpToPage(entry.key);
                          },
                          icon: Icon(
                            entry.value,
                            color: currentIndex == entry.key
                                ? Colors.white
                                : Colors.white70,
                            size: 25,
                          ))),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
