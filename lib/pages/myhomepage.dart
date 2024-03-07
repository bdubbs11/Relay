import 'package:cloud_firestore/cloud_firestore.dart'; // need to comment this out when done
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/colors/colors.dart';
import 'package:relay/pages/TestChatPage.dart';
import 'package:relay/pages/chatpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
  // made a class for the search bar
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: AppColors.cloudBlue),
        ),
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        prefixIconColor: Colors.black87,
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser!;

  // void signUserOut() {
  //   FirebaseAuth.instance.signOut();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Relay"),
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
      body: Column(
        children: [
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SearchBar(),
              ),
            ),
          ),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
      bottomNavigationBar: MyNavBar(currentIndex: (0)),
);
  }

// will need to switch to realtime just writing it out with firestore rn
  Widget _buildUserList(){
    return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('users').snapshots(), // Just a test stream
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text('Loading...');
      }
        return ListView(
          children: snapshot.data!.docs
            .map<Widget>((doc) => _buildUserListItem(doc))
            .toList(),
        );
      
    },
  );
  }


// build indivual user list items
Widget _buildUserListItem(DocumentSnapshot document){
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

  // display all the users except for the current user 
  if(_auth.currentUser!.email != data['email']){
    return ListTile(
      title: Text(data['email'] ?? 'No Email'),
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => TESTChatPage(
              receiverUserEmail: data['email'],
              // receiverUserId: data['uid'],
            ),
          )
        );
      }
    );
  } else{
    return Container();
  }
}
}
