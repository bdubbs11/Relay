import 'package:flutter/material.dart';
import 'package:relay/components/navbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 221, 226),
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('lib/images/beetlejuice.jpg')),
                ),
              ),
              const Text("Beetle Juice",
                  style: TextStyle(fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 111, 88, 75)))
            ],
          ),
        ),
        const Divider(thickness: 2),
        const Text("Bio:",
                style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: Color.fromARGB(255, 111, 88, 75)

        ),),
        const Divider(thickness: 2),
        const TextSection(bio: "My favorite part of a retwist is being able to feel my scalp.")
      ],
    ),
    ),
    bottomNavigationBar: MyNavBar(),
    );
  }
}

// class ImageSection extends StatelessWidget {
//   const ImageSection({super.key, required this.image});

//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       image,
//       width: 400,
//       height: 120,
//       fit: BoxFit.cover,
//     );
//   }
// }

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
