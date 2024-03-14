import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/components/text_box.dart';
import 'package:relay/pages/myhomepage.dart';
import 'package:relay/colors/colors.dart';
import 'package:firebase_core/firebase_core.dart';




class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
      // Grab the Current user by the neck
    final userMan = FirebaseAuth.instance.currentUser!;

  @override
        // Redesign Portion

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.grayBlue,
      ),

      body: ListView(
        children: [

        const SizedBox(height: 45),

          // Profile Pic goes here
       const CircleAvatar(
          radius: 70, 
          backgroundImage: AssetImage('lib/images/beetlejuice.jpg'),),  //Replace with PFP from Firestore
        
        const SizedBox(height:15),

          // Display Email here
        Text(userMan.email!,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black)),


        const SizedBox(height: 45),


          // Display Username in large here
        const MyTextBox(text: 'Beetle Juice', sectionName: 'username', icon: Icon(Icons.person, color: AppColors.skyBlue,),),


          // Paragraph bio underneath
        const MyTextBox(text: 'empty Bio', sectionName: 'bio', icon: Icon(Icons.notes, color: AppColors.skyBlue)),

        ],

      ),
    );
  }
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
