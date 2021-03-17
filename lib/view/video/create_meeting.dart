import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:uuid/uuid.dart';
import 'package:video_meeting/constant.dart';

class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String code = '';

  createcode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  @override
  void initState() {
    super.initState();
    createcode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Text(
              'Create a code and share with your friends!',
              style: mystyle(20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Code:',
                style: mystyle(30),
              ),
              Column(
                children: [
                  GestureDetector(
                    onLongPress: (){
                      Clipboard.setData(new ClipboardData(text: code));
                      final snackBar = SnackBar(content: Text('Code Copied !'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                      child: Text(
                    code,
                    style: mystyle(30, Colors.purple, FontWeight.w700),
                  )),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                      onTap: () {
                        Clipboard.setData(new ClipboardData(text: code));
                        final snackBar = SnackBar(content: Text('Code Copied !'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text(
                        'COPY',
                        style: mystyle(15, Colors.blue),
                      )),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          Text('Copy your code and Paste into Join Meeting Room Code field.', style: mystyle(13),textAlign: TextAlign.center,),
          Divider(
            height: 48,
            thickness: 2,
          ),

          InkWell(
            onTap: () {
              return createcode();
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: GradientColors.facebookMessenger),
              ),
              child: Center(
                child: Text(
                  'Create Code',
                  style: mystyle(20, Colors.white, FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
