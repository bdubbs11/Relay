import "package:flutter/material.dart";
import "package:relay/colors/colors.dart";


class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed; 
  const MyTextBox({super.key,required this.text,required this.sectionName,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
        color:AppColors.skyBlue,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.only(left:15,right:15,bottom:10),
      margin: EdgeInsets.only(left:20,right:20,top:20,bottom:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sectionName),
            IconButton(onPressed: onPressed,icon: Icon(Icons.settings))
          ],
        ),
        Text(text)
      ],)

    );
  }
}