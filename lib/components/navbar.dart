import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:relay/colors/colors.dart';
import 'package:relay/pages/chatpage.dart';
import 'package:relay/pages/pages_login/myhomepage.dart';
import 'package:relay/pages/profile.dart';
import 'package:relay/pages/settings.dart';


class MyNavBar extends StatefulWidget { // changed this to stateful widget

  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {

  @override
  Widget build(BuildContext context) {
    return Container(

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
              GButton(
                icon: Icons.home,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                },
                
              ),// chat chat_bubble
              GButton(
                icon: Icons.add_comment,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage(contactName: 'Chris Haynes', userName: 'Adrian Lopez',)),
                  );
                },
              ),
              GButton(
                icon: Icons.person,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
              ),
              GButton(
                icon: Icons.settings,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
            ]
          ),
        ),
      );
  }
}