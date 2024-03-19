import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import "package:relay/components/text_box.dart";
import 'package:firebase_storage/firebase_storage.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  Uint8List? _image;
  final user = FirebaseAuth.instance.currentUser!;
  final userNameController = TextEditingController();
  final userCollection = FirebaseFirestore.instance.collection("Users");
  final FirebaseStorage _storage = FirebaseStorage.instance;

  

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
    if(newValue.trim().length > 0){
      await userCollection.doc(user.email!).update({field: newValue});
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
    print("picture changed");
    //String imageUrl = await uploadImageToStorage('profileImage', img);
    print("check 1");
    await userCollection.doc(user.email!).update({'photo': img as Uint8List});
    print("picture updated");
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
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection("Users").doc(user.email).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                final userData = snapshot.data!.data() as Map<String, dynamic>;

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
                    text: userData['username'],
                    sectionName: "username",
                    onPressed: () => editField("username"),
                  ),
                 
                  const SizedBox(height: 15),
                   MyTextBox(
                    text: userData['bio'],
                    sectionName: "Biography",
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
                                    backgroundImage: MemoryImage(userData['photo']),
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
              }else if (snapshot.hasError){
                return Center(child: Text("Error:${snapshot.error}"),);
              }
              
              return const Center(child: CircularProgressIndicator(),);

            }),
      ),
      bottomNavigationBar: MyNavBar(currentIndex: (3)),
    );
  }
}
