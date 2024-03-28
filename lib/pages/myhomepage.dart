import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/colors/colors.dart';
import 'package:relay/pages/TestChatPage.dart';

// Home page widget
class MyHomePage extends StatefulWidget {

  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Search bar widget
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
  String username = '';
  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;

  // Realtime database reference
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('users');

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
              MaterialPageRoute(builder: (context) => MyHomePage()),
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

  // Build user list based on database snapshot
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _databaseReference.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null || snapshot.data!.snapshot == null) {
          return const Text('Loading...');
        }

        DataSnapshot dataSnapshot = snapshot.data!.snapshot!;
        dynamic rawData = dataSnapshot.value;

        if (rawData == null || rawData is! Map) {
          return const Text('No data available');
        }

        Map<String, dynamic> data = rawData.cast<String, dynamic>();

        data.entries.forEach((entry) {
          if (_auth.currentUser!.email == entry.value['email']) {
            username = entry.value['username'];
          }
        });

        final List<Widget> userWidgets = data.entries
            .where((entry) => _auth.currentUser!.email != entry.value['email'])
            .map<Widget>((entry) => _buildUserListItem(entry.value))
            .toList();

        return ListView(children: userWidgets);
      },
    );
  }

  // Build individual user list items
  Widget _buildUserListItem(Map<dynamic, dynamic> data) {
    // Display all users except for the current user
    if (_auth.currentUser!.email != data['email']) {
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey), // Set bottom border color
          ),
        ),
        child: ListTile(
          // Profile picture
          leading:
              CircleAvatar(backgroundImage: AssetImage('lib/images/baseProfile.jpg')),
          // Username
          title: Text(data['username']),
          // Last message
          subtitle: Text("This is the last message"),
          // Last message date
          trailing: Text("Yesterday"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                 builder: (context) => TestChatPage(
                  contactName: data['username'],
                  userName: username,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}

// This is a widget for the look of the messages
class MessageTile extends StatelessWidget {
  const MessageTile({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(backgroundImage: AssetImage('lib/images/baseProfile.jpg')),
        ),
        Expanded(
          child: Column(
            children: [
              Text("Username"),
              Text("This is the last message"), // Make this the last message
            ],
          ),
        ),
      ],
    );
  }
}