import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/colors/colors.dart';

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: horizontalPadding,
            //     vertical: verticalPadding,
            //   ),
            //   child: const Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Row(
            //         children: [
            //           Text(
            //             'RELAY',
            //             style: TextStyle(fontSize: 32),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

           // const SizedBox(height: 10),

            //divider to separate the welcome back message
            //and feed
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40.0),
            //   child: Divider(
            //     thickness: 1,
            //     color: Color.fromARGB(255, 204, 204, 204),
            //   ),
            // ),

            // const SizedBox(height: 20),
            // // welcome back
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Welcome Back,",
            //         style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
            //       ),
            //       const Text(
            //         'Devon Pedraza',
            //         style: TextStyle(fontSize: 20),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 0),

            // Search Bar
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
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
                ),
              ),
            ),
            // first  chat square



          ],
        ),
      ),



      // navbar stuff
      bottomNavigationBar: MyNavBar(currentIndex: (0)),
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
