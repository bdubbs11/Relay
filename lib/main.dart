import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:relay/pages/pages_login/auth.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: false
  );
  
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // if the user is not logged in they will go to the login page
      home: AuthPage(),
      // if the user is logged in they will simply go to the home page
    );
  }
}