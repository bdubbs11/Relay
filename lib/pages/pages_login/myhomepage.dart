import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:relay/colors/colors.dart';
import 'package:relay/pages/chatpage.dart';
import 'package:relay/pages/profile.dart';

class MyHomePage extends StatefulWidget { // changed this to stateful widget
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  //int currentIndex = 0; // navigation

  // sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
             icon: const Icon(Icons.logout),
             )
         ],
        ),
      body: Center(child: Text(
        "LOGGED IN AS: ${user.email!}",
        style: const TextStyle(fontSize: 20),
        ),
      ),

      // navbar stuff
      bottomNavigationBar: Container(
        //currentIndex: currentIndex, // navagation btwn pages
        //onTap: (index) => setState(() => currentIndex = index),

        color: AppColors.lightBrown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: AppColors.lightBrown,
            color: AppColors.grayBlue,
            activeColor: AppColors.cloudBlue,
            tabBackgroundColor: AppColors.darkBrown,
            gap: 8,
           
            padding: const EdgeInsets.all(10),
            tabs: [
              const GButton(
                icon: Icons.home,
                text: "Home"
              ),// chat chat_bubble
              GButton(
                icon: Icons.add_comment,
                text: "Create Chat",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage(contactName: 'Chris Haynes', userName: 'Adrian Lopez',)),
                  );
                },
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child:Text("Logged in!"))
//     );
//   }
// }
