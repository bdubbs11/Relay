import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../colors/colors.dart';
import '../../components/textfield.dart';
import '../../components/button.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

// sign user up
void signUserUp() async{

  // show loading circle 
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

  // try signing up
    try {
      // check if password is confirmed
      if(passwordController.text == confirmPasswordController.text){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      }else{
        // show error message, passwords don't match
        showErrorMessage("Passwords don't match!");
      }
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
  }
}

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBrown,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              const SizedBox(height: 200), 
              // Login text
              // optional logo or something around here
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: AppColors.grayBlue,
                  fontSize: 50,
                ),
              ),

              const SizedBox(height: 10), 

              // email field / alternatively can do username field
              MyTextField(
                controller: emailController,
                hintText: "Email", 
                obscureText: false,
              ),

              const SizedBox(height: 10), 

              // password field

              MyTextField(
                controller: passwordController,
                hintText: "Password", 
                obscureText: true,
              ),

              const SizedBox(height: 10), 

              // confirm password field

              MyTextField(
                controller: confirmPasswordController,
                hintText: " Confirm Password", 
                obscureText: true,
              ),

              const SizedBox(height: 50),  

                // sign in button
                Button(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),

                const SizedBox(height: 120),
                // or continue with i am not adding this unless we discuss something else



              // line above the sign up
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColors.cloudBlue,
                    
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              // not a member create an account 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: AppColors.cloudBlue),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: 
                      const Text(
                        'Login now',
                        style :TextStyle(
                          color: AppColors.skyBlue,
                          fontWeight: FontWeight.bold,
                        ),
                        
                      ),

                    ),
                  ],
                ),
                const SizedBox(height: 20),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}