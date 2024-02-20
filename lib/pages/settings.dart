import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay/components/button.dart';
import 'package:relay/components/navbar.dart';
import '../colors/colors.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  final user = FirebaseAuth.instance.currentUser!;
  final userNameController = TextEditingController();
  final String _username = "Dev";

  void changeUserName() async {
    try {
      // ignore: deprecated_member_use
      user.updateDisplayName(userNameController.text);
      await user.reload();
      userNameController.clear();
      print("Updated Display name:");
      print("${user.displayName}");
      Navigator.pop(context);
    } on FirebaseException catch (e) {

    }
  }

  void changeUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Column(children: [
              Text(
                "Change the Username",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              TextField(
                controller: userNameController,
              ),
              ElevatedButton(
                  onPressed: changeUserName,
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(8),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.cloudBlue)),
                  child: const Text('Submit')),
            ]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: AppColors.lightBrown,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Settings Page")),
      body: SafeArea(        
        child: StreamBuilder<User?>(
          stream:  FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            return Center(
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: AppColors.grayBlue,
                      fontSize: 30,
                    ),
                  )
                ]),
                const SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Username: ${user.email!}",
                    style: TextStyle(
                      color: AppColors.grayBlue,
                      fontSize: 20,
                    ),
                  ),
                  Button(
                    text: 'Change Username',
                    onTap: changeUser,
                  ),
                ]),
                const SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    'Bio',
                    style: TextStyle(
                      color: AppColors.grayBlue,
                      fontSize: 20,
                    ),
                  ),
                  Button(
                    text: 'Change Biography',
                    onTap: changeUser,
                  ),
                ]),
                const SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    'Picture',
                    style: TextStyle(
                      color: AppColors.grayBlue,
                      fontSize: 20,
                    ),
                  ),
                  Button(
                    text: 'Change Profile Picture',
                    onTap: changeUser,
                  ),
                ]),
                const SizedBox(height: 15),
                const Row(children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: AppColors.grayBlue,
                      fontSize: 30,
                    ),
                  )
                ]),
                const SizedBox(height: 15),
              ]), // This trailing comma makes auto-formatting nicer for build methods.
            );
          }
        ),
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
