import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import '../../constant.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

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
              child: Text('Register', style: mystyle(30),),
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
                    width: MediaQuery.of(context).size.width/1.7,
                    child: TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
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
                    onTap: (){
                      try{
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text, password: passwordController.text).then((value) {
                          userCollection.doc(value.user.uid).set({
                            'username' : usernameController.text,
                            'email' : emailController.text,
                            'password' : passwordController.text,
                            'uid' : value.user.uid,
                          });
                        });
                      }on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          showDialog(context: context, builder: (context){
                            return CupertinoAlertDialog(
                              title: Text("E-mail already use!"),
                              content: Text("Already created account with this E-mail. Please LogIn"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  isDefaultAction: true,
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          });
                        }
                      }
                      catch(e){
                        print(e);
                        var snackbar = SnackBar(content: Text(e.toString()));
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.aqua),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text('SIGN UP',
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
