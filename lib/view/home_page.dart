import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_meeting/constant.dart';
import 'package:video_meeting/view/HomeScreen.dart';
import 'package:video_meeting/view/ProfileScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  List pageslist = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: pageslist[count],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: mystyle(16,Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: mystyle(16, Colors.black),
        currentIndex: count,
        onTap: (index){
          setState(() {
            count = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.video_call)
          ),
          BottomNavigationBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.person)
          ),
        ],
      ),
    );
  }
}
