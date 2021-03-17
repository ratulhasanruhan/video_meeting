import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:video_meeting/constant.dart';
import 'package:video_meeting/view/home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: GradientColors.blue)
            ),
            child: Center(
              child: Text('Log In', style: mystyle(30),),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.6,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0,3)
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width /1.7,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width /1.7,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: () async{
                      try{
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);

                        int count = 0;
                        Navigator.popUntil(context, (route) {
                          return count ++ ==2;
                        });

                      }
                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showDialog(context: context, builder: (context){
                            return CupertinoAlertDialog(
                              title: Text("No Account Found!"),
                              content: Text("We don't find any account with this email. Please create account first."),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  isDefaultAction: true,
                                  child: Text("Try Again"),
                                ),
                              ],
                            );
                          });
                        } else if (e.code == 'wrong-password') {
                          showDialog(context: context, builder: (context){
                            return CupertinoAlertDialog(
                              title: Text("Wrong Password!"),
                              content: Text("Your given password is Wrong. Please enter correct password."),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  isDefaultAction: true,
                                  child: Text("Try Again"),
                                ),
                              ],
                            );
                          });
                        }
                      }
                      catch(e){
                        print(e);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.lightBlue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text('SIGN IN',
                        style: mystyle(25,Colors.white),)),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
