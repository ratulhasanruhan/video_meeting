import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:video_meeting/constant.dart';
import 'package:firebase_core/firebase_core.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  bool isloading = false;
  TextEditingController nameController = TextEditingController();

   getUserData() async{
    DocumentSnapshot userdoc = await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      name = userdoc.data()['username'];
      isloading = true;
    });
  }

  updateUsername() async{
     await userCollection.doc(FirebaseAuth.instance.currentUser.uid).update({
       'username': nameController.text
     });
     setState(() {
       name = nameController.text;
     });
     Navigator.pop(context);
  }

  showeditdialog() async{
    return showDialog(
        barrierDismissible: true, context: context, builder: (context){
      return AlertDialog(
        title: Text('Edit Information'),
        actions: [
          FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Cancel')),
          FlatButton(
            child: Text('Save'),
            onPressed: (){
              return updateUsername();
            },
          ),
        ],
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Update Name'
                ),
              ),
            ],
          ),
        ),
      );
        }
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: GradientColors.facebookMessenger)
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width /2 - 64,
              top: MediaQuery.of(context).size.height /3.1,
            ),
            child: CircleAvatar(
              radius: 64,
              backgroundImage: AssetImage('images/conference.png'),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 300,),
                Text(isloading == false ? 'Loading...' : name,
                style: mystyle(35, Colors.black,),textAlign: TextAlign.center,),
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                    return showeditdialog();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width /2,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: GradientColors.cherry),
                    ),
                    child: Center(child: Text('Edit Profile', style: mystyle(17, Colors.white),)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
