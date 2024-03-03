import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/colors/colors.dart';
import 'package:relay/pages/chatpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchBar(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _buildUserList(),
      bottomNavigationBar: MyNavBar(currentIndex: (0)),
    );
  }

// will need to switch to realtime just writing it out with firestore rn
  Widget _buildUserList(DocumentSnapshot document){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('error');
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('loading...');
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
      title: data['email'],
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => TESTChatPage(),
          )
        )
      }
    )
  }
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


}