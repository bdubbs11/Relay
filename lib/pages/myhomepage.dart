import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

   // sign user out
  void signUserOut(){
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
      body: Center(child: Text(
        "LOGGED IN AS: " + user.email!,
        style: TextStyle(fontSize: 20),
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