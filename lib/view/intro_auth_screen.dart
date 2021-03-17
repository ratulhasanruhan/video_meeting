import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:video_meeting/constant.dart';
import 'package:video_meeting/view/auth/navigate_auth_screen.dart';
import 'package:video_meeting/view/home_page.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Welcome',
          body: 'Welcome to the Flutter Video Conference!',
          image: Center(
            child: Image.asset('images/welcome.png', height: 175,),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Colors.black,),
            titleTextStyle: mystyle(20, Colors.black),
          )
        ),
        PageViewModel(
          title: 'Minimal Design',
          body: 'Simple User Interface!',
          image: Center(
            child: Image.asset('images/logo.png', height: 175,),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Colors.black,),
            titleTextStyle: mystyle(20, Colors.black),
          )
        ),
        PageViewModel(
          title: 'Join or Create a meeting.',
          body: 'One click join and create meeting',
          image: Center(
            child: Image.asset('images/conference.png', height: 175,),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Colors.black,),
            titleTextStyle: mystyle(20, Colors.black),
          )
        ),
        PageViewModel(
          title: 'Secured!',
          body: 'Your security is important for us. ',
          image: Center(
            child: Image.asset('images/secure.jpg', height: 175,),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Colors.black,),
            titleTextStyle: mystyle(20, Colors.black),
          )
        ),
      ],
      onDone: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => NavigateAuthScreen()));
      },
      onSkip: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => NavigateAuthScreen()));
      },

      showSkipButton: true,
      skip: Text('Skip', style: mystyle(15, Colors.lightBlueAccent, FontWeight.normal),),
      next: Text('Next', style: mystyle(15, Colors.lightBlueAccent, FontWeight.normal),),
      done: Text('Done', style: mystyle(15, Colors.lightBlueAccent, FontWeight.bold),),

    );
  }
}
