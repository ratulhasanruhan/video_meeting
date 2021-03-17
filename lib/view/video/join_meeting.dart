import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:video_meeting/constant.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController nameEditext = TextEditingController();
  TextEditingController codeController = TextEditingController();
  bool isvideoMuted = false;
  bool isaudioMuted = false;
  String username = '';

  getUserData() async{
    DocumentSnapshot userdoc = await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
    });
  }

  joinmeeting() async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;

      var options = JitsiMeetingOptions()
        ..room = codeController.text
        ..userDisplayName = nameEditext.text == '' ? username : nameEditext.text
        ..audioMuted = isaudioMuted
        ..videoMuted = isvideoMuted
        ..featureFlag = featureFlag;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24,),
              Text("Room Code", 
              style: mystyle(20),),
              SizedBox(height: 20,),
              PinCodeTextField(
                controller: codeController,
                appContext: context,
                length: 6,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                ),
                animationDuration: Duration(microseconds: 3000),
                onChanged: (value){

                },
              ),
              SizedBox(height: 10,),
              TextField(
                controller: nameEditext,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name (Leave if you want use your username)',
                ),
              ),
              SizedBox(height: 16,),
              CheckboxListTile(
                value: isvideoMuted,
                title: Text('Video Muted'),
                onChanged: (bool value) {
                  setState(() {
                    isvideoMuted = value;
                  });
                },
              ),
              CheckboxListTile(
                value: isaudioMuted,
                title: Text('Audio Muted'),
                onChanged: (bool value) {
                  setState(() {
                    isaudioMuted = value;
                  });
                },
              ),
              SizedBox(
                height: 40,
              ),
              Text('Paste your meeting code on Long press in Room Code. You can set password and do more functionality in meeting page.', style: mystyle(13),textAlign: TextAlign.center,),
              Divider(
                height: 48,
                thickness: 2,
              ),
              InkWell(
                onTap: (){
                  return joinmeeting();
                },
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: GradientColors.facebookMessenger),
                  ),
                  child: Center(
                    child: Text('Join Meeting', style: mystyle(20, Colors.white, FontWeight.w700),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
