import 'dart:js_interop_unsafe';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/pages/pages_login/myhomepage.dart';
import 'package:relay/colors/colors.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:relay/components/add_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  Future<String> getData(field) async{
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc('doc_id').get();
    if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var value = data?[field]; // <-- The value you want to retrieve. 
        // Call setState if needed.
        return value;
    }
    return "";
  }

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
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(user.email!)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userData = snapshot.data!.data() as Map<String, dynamic>;
                  var userDocument = snapshot.data;


                  

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  AssetImage('lib/images/beetlejuice.jpg'),
                            ),
                            
                            Text(userData['username'],
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
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[100]),
                            foregroundColor:
                                MaterialStateProperty.all(AppColors.relayBlue)),
                        child: Text(
                            userData['bio']),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error:${snapshot.error}"),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
      bottomNavigationBar: MyNavBar(currentIndex: (2)),
    );
  }

  void displayProfile() async {}
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
