// I forgot i want to add this to the main.dart file bc i thought it
// could work 

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay/pages/loginorregister.dart';

import 'package:relay/pages/myhomepage.dart';





// this checks to see if the user is signed in or not
// if the user isnt signed in they will display the login page 
// if the user is signed it will show the "chats page"
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if the user is logged in show the home page
          if(snapshot.hasData){
            return MyHomePage(); // devons home page
          }
          // if the user isn't logged in show the login/register page
          else{
            return LoginOrRegisterPage(); //LoginOrRegisterPage()
          }
        },
      ),
    );
  }
}