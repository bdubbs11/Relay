import 'package:flutter/material.dart';
import "../colors/colors.dart";

// text field used from other homework

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;


  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });


  @override
  Widget build(BuildContext context){
    return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grayBlue)
                  //borderSide: BorderSide(color: AppColors.lightBrown)
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grayBlue),
                    //borderSide: BorderSide(color: AppColors.lightBrown)
                  ),
                  fillColor:AppColors.grayBlue,
                  //fillColor:AppColors.lightBrown,
                  filled: true,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: AppColors.darkBrown),
                  //hintStyle: const TextStyle(color: AppColors.cloudBlue),
              ),
            ),
          );
  }
}