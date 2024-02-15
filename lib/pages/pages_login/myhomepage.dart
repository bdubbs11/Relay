import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:relay/colors/colors.dart';

class MyHomePage extends StatefulWidget {
  // changed this to stateful widget
  MyHomePage({super.key});

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
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text(
          "LOGGED IN AS: " + user.email!,
          style: TextStyle(fontSize: 20),
        ),
      ),

      // navbar stuff
      bottomNavigationBar: Container(
        //currentIndex: currentIndex, // navagation btwn pages
        //onTap: (index) => setState(() => currentIndex = index),

        color: AppColors.lightBrown,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: AppColors.lightBrown,
            color: AppColors.grayBlue,
            activeColor: AppColors.cloudBlue,
            tabBackgroundColor: AppColors.darkBrown,
            gap: 8,
           
            padding: EdgeInsets.all(10),
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home"
              ),// chat chat_bubble
              GButton(
                icon: Icons.add_comment,
                text: "Create Chat",
              ), // add_circle 
              GButton(
                icon: Icons.person,
                text: "Profile",
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
