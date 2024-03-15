import 'package:flutter/material.dart';
import 'package:relay/colors/colors.dart';

class MyTextBox extends StatelessWidget {
  // Data Members
  final String text;
  final String sectionName;
  final Icon icon;

  //Constructor
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(left: 15, bottom: 15),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(sectionName,
                    style: const TextStyle(color: AppColors.skyBlue)),
                icon,
              ],
            ),
            Text(
              text,
            ),
          ],
        ));
  }
}
