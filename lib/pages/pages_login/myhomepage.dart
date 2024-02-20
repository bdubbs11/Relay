import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:relay/colors/colors.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/pages/chatpage.dart';
import 'package:relay/pages/profile.dart';
import 'package:relay/pages/settings.dart';

class MyHomePage extends StatefulWidget {
  // changed this to stateful widget
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
    // padding constants
    final double horizontalPadding = 5;
    final double verticalPadding = 5;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'RELAY',
                        style: TextStyle(fontSize: 32),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            //divider to separate the welcome back message
            //and feed
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                thickness: 1,
                color: Color.fromARGB(255, 204, 204, 204),
              ),
            ),

            const SizedBox(height: 10),
            // welcome back
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back,",
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
                  ),
                  const Text(
                    'Devon Pedraza',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Search Bar
            TextField(
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.black87),
            ),
          ],
        ),
      ),

      // navbar stuff
      bottomNavigationBar: MyNavBar(),
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
