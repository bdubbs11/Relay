import 'dart:js_interop_unsafe';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/pages/pages_login/myhomepage.dart';
import 'package:relay/colors/colors.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:relay/components/add_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text("Profile"), //Will display "User's Profile"
        backgroundColor: AppColors.relayBlue,
        leading: IconButton(
          icon: Image.asset("lib/images/blackLogo.png"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('lib/images/beetlejuice.jpg'),
                  ),
                  Text("Beetle Juice",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 111, 88, 75)))
                ],
              ),
            ),
            const Text(
              "Bio:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 111, 88, 75)),
            ),
            const Divider(thickness: 2),
            ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                  foregroundColor:
                      MaterialStateProperty.all(AppColors.relayBlue)),
              child: const Text(
                  "My favorite part of a retwist is being able to feel my scalp."),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavBar(currentIndex: (2)),
    );
  }


  void displayProfile() async {
    
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.bio,
  });

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        bio,
        softWrap: true,
      ),
    );
  }
}
