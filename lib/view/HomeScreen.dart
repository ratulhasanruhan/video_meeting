import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_meeting/constant.dart';
import 'package:video_meeting/view/video/create_meeting.dart';
import 'package:video_meeting/view/video/join_meeting.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  TabController tabController;
  
  tabview(String name){
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(child: Text(name, style: mystyle(15, Colors.black),),),
      ),
    );
  }
  
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text('Flutter Meeting', style: mystyle(20),),

        bottom: TabBar(
          controller: tabController,
          tabs: [
            tabview('Join Meeting'),
            tabview('Create Meeting'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          JoinMeeting(),
          CreateMeeting(),
        ],
      ),
    );
  }
}
