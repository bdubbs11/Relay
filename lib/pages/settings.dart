import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay/components/button.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/pages/pages_login/loginorregister.dart';
import '../colors/colors.dart';
import 'package:relay/pages/pages_login/myhomepage.dart';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relay/pages/utils.dart';
import 'package:relay/components/add_data.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  Uint8List? _image;
  final user = FirebaseAuth.instance.currentUser!;
  final userNameController = TextEditingController();
  final String _username = "Dev";

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

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


  // brandond added the sign out button 
  void logOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    // Navigate back to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
    );
  } catch (e) {
    // Handle sign-out errors if necessary
    print("Error signing out: $e");
  }
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
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 147, 163, 188),
          title: const Text("Settings"),
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
                  Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://png.pngitem.com/pimgs/s/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
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


                // brandon added this bc i need to be able to sign out
              Button(
                text: 'Log Out',
                onTap: () => logOut(),
              ),


              ]), // This trailing comma makes auto-formatting nicer for build methods.
            );
          }
        ),
      ),
      bottomNavigationBar: MyNavBar(currentIndex: (3)),
    );
  }
}
