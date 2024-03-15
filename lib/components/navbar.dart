import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:relay/colors/colors.dart';
import 'package:relay/pages/chatpage.dart';
import 'package:relay/pages/myhomepage.dart';
import 'package:relay/pages/profile.dart';
import 'package:relay/pages/settings.dart';


class MyNavBar extends StatefulWidget {
  final int currentIndex;
  final String userID;

  const MyNavBar({
    Key? key,
    required this.currentIndex,
    required this.userID,
  }) : super(key: key);

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
          color: AppColors.cloudBlue,
          activeColor: AppColors.grayBlue,
          tabBackgroundColor: AppColors.darkBrown,
          gap: 8,
          padding: const EdgeInsets.all(10),
          tabs: [
            GButton(
              icon: Icons.home,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(userID: widget.userID)),
                );
              },
            ),
            GButton(
              icon: Icons.add_comment,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      userID: widget.userID,
                      contactName: 'Brandon Wilson',
                      userName: 'Adrian Lopez',
                    ),
                  ),
                );
              },
            ),
            GButton(
              icon: Icons.person,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(userID: widget.userID)),
                );
              },
            ),
            GButton(
              icon: Icons.settings,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage(userID: widget.userID)),
                );
              },
            ),
          ],
          selectedIndex: widget.currentIndex,
        ),
      ),
    );
  }
}