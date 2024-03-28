import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay/components/button.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/pages/pages_login/auth.dart';
import 'package:relay/pages/pages_login/loginorregister.dart';
import '../colors/colors.dart';
import 'package:relay/pages/myhomepage.dart';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relay/pages/utils.dart';
import 'package:relay/components/add_data.dart';
import "package:relay/components/textBox.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';


class SettingsPage extends StatefulWidget {

  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  Uint8List? _image;
  final user = FirebaseAuth.instance.currentUser!;
  final userNameController = TextEditingController();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('users');

  

  Future<void> editField(String field) async{
    String newValue = "";
    await showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Edit " + field),
      content: TextField(
        autofocus: true, 
        decoration: InputDecoration(hintText: "Enter new $field"),
        onChanged: (value){
          newValue = value;
        }),

        actions:[
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context)),

            TextButton(
            child: Text("Save"),
            onPressed: () => Navigator.of(context).pop(newValue)),
        ]
    ),);

    //update in firestore
    if (newValue.trim().length > 0) {
    // Define the path to the username field
    var updates = <String, Object?>{};
    updates['/' + uid + '/username'] = newValue;

    // Update the username field for the specified uid
    await dbRef.update(updates);
}

  }

  Future<String> uploadImageToStorage(String childName,Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    print("After issue");
    setState((){
      _image = img;
    });
  }

  

  //brandond added the sign out button
  void logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    } catch (e) {
      // Handle sign-out errors if necessary
      print("Error signing out: $e");
    }
  }
  final userMan = FirebaseAuth.instance.currentUser!;
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
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: dbRef.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData){
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
                  MyTextBox(
                    text: dbRef.child('/${uid}/username').onValue.toString(),
                    sectionName: "username",
                    onPressed: () => editField("username"),
                  ),
                  const SizedBox(height: 15),
                  MyTextBox(
                    text: userMan.displayName.toString(),
                    sectionName: "bio",
                    onPressed: () => editField("bio"),
                  ),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            }),
      ),
      bottomNavigationBar: MyNavBar(currentIndex: (3)),
    );
  }
}
